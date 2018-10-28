all:
	@echo Use \"make vagrant\" or \"make aws\"

prepare:
	@test -f ./id_rsa || ssh-keygen -t rsa -N '' -C 'paxful_tt' -f ./id_rsa
	@test -f ./terraform/terraform.tfvars || cp ./terraform/terraform.tfvars.example ./terraform/terraform.tfvars

vagrant:
	@cd ansible && vagrant up
	@cd ansible && ansible-playbook site.yml
	@inspec exec tests/app.rb -t ssh://vagrant@10.10.10.10 -i ~/.vagrant.d/insecure_private_key
	@inspec exec tests/dbmaster.rb -t ssh://vagrant@10.10.10.20 -i ~/.vagrant.d/insecure_private_key
	@inspec exec tests/dbslave.rb -t ssh://vagrant@10.10.10.21 -i ~/.vagrant.d/insecure_private_key
	@inspec exec tests/external --attrs tests/vagrant/attrs.yml

vagrant-destroy:
	@cd ansible && vagrant destroy -f

aws:
	@cd terraform && terraform init && terraform apply -auto-approve && cd ../ansible && \
		TERRAFORM_STATE_ROOT=../terraform ansible-playbook -i environments/aws/terraform.py site.yml
	@inspec exec tests/app.rb -t ssh://admin@$$(terraform output -state=./terraform/terraform.tfstate appserver_ip) -i id_rsa
	@inspec exec tests/dbmaster.rb -t ssh://admin@$$(terraform output -state=./terraform/terraform.tfstate dbmaster_ip) -i id_rsa
	@inspec exec tests/dbslave.rb -t ssh://admin@$$(terraform output -state=./terraform/terraform.tfstate dbslave_ip) -i id_rsa
	@echo "app_host: '$$(terraform output -state=./terraform/terraform.tfstate appserver_ip)'\ndbmaster: '$$(terraform output -state=./terraform/terraform.tfstate dbmaster_ip)'\ndbslave: '$$(terraform output -state=./terraform/terraform.tfstate dbslave_ip)'\n" > 'tests/aws/attrs.yml'
	@inspec exec tests/external --attrs tests/aws/attrs.yml

aws-destroy:
	@ cd terraform && terraform destroy -auto-approve

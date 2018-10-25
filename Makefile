all:
	@echo Use \"make vagrant\" or \"make aws\"

prepare:
	@test -f ./id_rsa || ssh-keygen -t rsa -N '' -C 'paxful_tt' -f ./id_rsa
	@test -f ./terraform/terraform.tfvars || cp ./terraform/terraform.tfvars.example ./terraform/terraform.tfvars

vagrant:
	@cd ansible && vagrant up
	@inspec exec tests/vagrant/app.rb -t ssh://vagrant@10.10.10.10 -i ~/.vagrant.d/insecure_private_key
	@inspec exec tests/vagrant/dbmaster.rb -t ssh://vagrant@10.10.10.20 -i ~/.vagrant.d/insecure_private_key
	@inspec exec tests/vagrant/dbslave.rb -t ssh://vagrant@10.10.10.21 -i ~/.vagrant.d/insecure_private_key
	@inspec exec tests/vagrant/ext

vagrant-destroy:
	@cd ansible && vagrant destroy -f

aws:
	@cd terraform && terraform init && terraform apply -auto-approve && cd ../ansible && \
		TERRAFORM_STATE_ROOT=../terraform ansible-playbook -i environments/aws/terraform.py site.yml

aws-destroy:
	@ cd terraform && terraform destroy -auto-approve

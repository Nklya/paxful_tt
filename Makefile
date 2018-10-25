all:
	@echo Use \"make vagrant\" or \"make aws\"

prepare:
	@test -f ./id_rsa || ssh-keygen -t rsa -N '' -C 'paxful_tt' -f ./id_rsa
	@test -f ./terraform/terraform.tfvars || cp ./terraform/terraform.tfvars.example ./terraform/terraform.tfvars

vagrant:
	@cd ansible && vagrant up

vagrant-destroy:
	@cd ansible && vagrant destroy -f

aws:
	@cd terraform && terraform init && terraform apply -auto-approve && cd ../ansible && \
		TERRAFORM_STATE_ROOT=../terraform ansible-playbook -i environments/aws/terraform.py site.yml

aws-destroy:
	@ cd terraform && terraform destroy -auto-approve

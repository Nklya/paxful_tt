all:
	@echo Use \"make vagrant\" or \"make aws\"

prepare:
	test -f ./id_rsa || ssh-keygen -t rsa -N '' -C 'paxful_tt' -f ./id_rsa
	test -f ./terraform/terraform.tfvars || cp ./terraform/terraform.tfvars.example ./terraform/terraform.tfvars

vagrant:
	@cd ansible && vagrant up

vagrant-stop:
	@cd ansible && vagrant destroy -f

aws:
	@echo Not yet implemented

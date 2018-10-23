all:
	@echo Use \"make vagrant\" or \"make aws\"

vagrant:
	@cd ansible && vagrant up

aws:
	@echo Not yet implemented

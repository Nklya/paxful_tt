all:
	@echo Use \"make vagrant\" or \"make aws\"

# prepare:
vagrant:
	@cd ansible && vagrant up

aws:
	@echo Not yet implemented

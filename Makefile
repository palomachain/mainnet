validate-gentxs:
	@cd gentx-validator; go build -o ../gentxv; cd ..; ./gentxv $(GIT_DIFF)

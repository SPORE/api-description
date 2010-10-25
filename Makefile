
check:
	@make -C apps check
	@make -C services check

test: check

clean:
	@make -C apps clean
	@make -C services clean

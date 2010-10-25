
check:
	@make -C apps check
	@make -C services check

test: check

png:
	@make -C apps png
	@make -C services png

clean:
	@make -C apps clean
	@make -C services clean

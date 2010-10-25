VALIDATOR := perl ../utils/validator.pl --schema spore_validation.rx --description

check: spore_validation.rx
	@make -C github check
	@$(VALIDATOR) backtweet.json
	@$(VALIDATOR) backtype.json
	@$(VALIDATOR) github.json
	@$(VALIDATOR) ihackernews.json
	@$(VALIDATOR) twitter.json

test: check

spore_validation.rx:
	wget http://github.com/SPORE/specifications/raw/master/spore_validation.rx

clean:
	@make -C github clean
	-rm spore_validation.rx

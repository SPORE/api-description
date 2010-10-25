
VALIDATOR := perl ../utils/validator.pl --schema spore_validation.rx --description

check: spore_validation.rx
	@$(VALIDATOR) couchdb.json
	@$(VALIDATOR) presque.json

test: check

spore_validation.rx:
	wget http://github.com/SPORE/specifications/raw/master/spore_validation.rx

clean:
	-rm spore_validation.rx


VALIDATOR := perl ../../utils/validator.pl --schema spore_validation.rx --description
SPORE2DOT := perl ../../utils/spore2dot.pl

check: spore_validation.rx
	@$(VALIDATOR) user.json
	@$(VALIDATOR) issue.json
	@$(VALIDATOR) gist.json
	@$(VALIDATOR) network.json
	@$(VALIDATOR) repository.json
	@$(VALIDATOR) commit.json
	@$(VALIDATOR) object.json
	@$(VALIDATOR) organization.json

test: check

spore_validation.rx:
	wget http://github.com/SPORE/specifications/raw/master/spore_validation.rx

png: github.png

%.png : %.dot
	dot -T png -o $@ $<

github.dot: \
    user.json \
    issue.json \
    gist.json \
    network.json \
    repository.json \
    commit.json \
    object.json \
    organization.json
	$(SPORE2DOT) $^ > $@

clean:
	-rm *.png *.dot spore_validation.rx

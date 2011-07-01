
VALIDATOR := perl ../../utils/validator.pl --schema spore_validation.rx --description
SPORE2DOT := perl ../../utils/spore2dot.pl

check: spore_validation.rx
	@$(VALIDATOR) oauth.json
	@$(VALIDATOR) people.json
	@$(VALIDATOR) groups.json
	@$(VALIDATOR) companies.json
	@$(VALIDATOR) jobs.json
	@$(VALIDATOR) network.json
	@$(VALIDATOR) communications.json

test: check

spore_validation.rx:
	wget http://github.com/SPORE/specifications/raw/master/spore_validation.rx

png: linkedin.png

%.png: %.dot
	dot -T png -o $@ $<

linkedin.dot: \
    people.json \
    groups.json \
    companies.json \
    jobs.json \
    network.json \
    communications.json
	$(SPORE2DOT) $^ > $@

clean:
	-rm *.png *.dot spore_validation.rx

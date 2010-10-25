
VALIDATOR := perl ../../utils/validator.pl --schema spore_validation.rx --description
SPORE2DOT := perl ../../utils/spore2dot.pl

check: spore_validation.rx
	@$(VALIDATOR) repository.json
	@$(VALIDATOR) user.json

test: check

spore_validation.rx:
	wget http://github.com/SPORE/specifications/raw/master/spore_validation.rx

png: github.png

%.png : %.dot
	dot -T png -o $@ $<

github.dot: user.json repository.json
	$(SPORE2DOT) $^ > $@

clean:
	-rm *.png *.dot spore_validation.rx

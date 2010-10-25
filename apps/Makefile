
VALIDATOR := perl ../utils/validator.pl --schema spore_validation.rx --description
SPORE2DOT := perl ../utils/spore2dot.pl

check: spore_validation.rx
	@$(VALIDATOR) couchdb.json
	@$(VALIDATOR) presque.json

test: check

spore_validation.rx:
	wget http://github.com/SPORE/specifications/raw/master/spore_validation.rx

png: \
    couchdb.png \
    presque.png

%.png : %.dot
	dot -T png -o $@ $<

%.dot: %.json
	$(SPORE2DOT) $< > $@

clean:
	-rm *.png *.dot spore_validation.rx

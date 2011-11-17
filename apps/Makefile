
VALIDATOR := perl ../utils/validator.pl --schema spore_validation.rx --description
SPORE2DOT := perl -CO ../utils/spore2dot.pl

check: spore_validation.rx
	@make -C couchdb check
	@$(VALIDATOR) couchdb.json
	@$(VALIDATOR) presque.json

test: check

spore_validation.rx:
	wget https://raw.github.com/SPORE/specifications/master/spore_validation.rx

png: \
    couchdb.png \
    presque.png
	@make -C couchdb png

%.png : %.dot
	dot -T png -Gutf8 -o $@ $<

%.dot: %.json
	$(SPORE2DOT) $< > $@

clean:
	@make -C couchdb clean
	-rm *.png *.dot spore_validation.rx

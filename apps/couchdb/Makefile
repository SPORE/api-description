
VALIDATOR := perl ../../utils/validator.pl --schema spore_validation.rx --description
SPORE2DOT := perl ../../utils/spore2dot.pl

check: spore_validation.rx
	@$(VALIDATOR) server.json
	@$(VALIDATOR) database.json
	@$(VALIDATOR) document.json
	@$(VALIDATOR) design.json

test: check

spore_validation.rx:
	wget http://github.com/SPORE/specifications/raw/master/spore_validation.rx

png: couchdb.png

%.png : %.dot
	dot -T png -o $@ $<

couchdb.dot: \
    server.json \
    database.json \
    document.json \
    design.json
	$(SPORE2DOT) $^ > $@

clean:
	-rm *.png *.dot spore_validation.rx

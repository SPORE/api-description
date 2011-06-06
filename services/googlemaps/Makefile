
VALIDATOR := perl ../../utils/validator.pl --schema spore_validation.rx --description
SPORE2DOT := perl ../../utils/spore2dot.pl

check: spore_validation.rx
	@$(VALIDATOR) directions.json
	@$(VALIDATOR) distancematrix.json
	@$(VALIDATOR) elevation.json
	@$(VALIDATOR) geocoding.json

test: check

spore_validation.rx:
	wget http://github.com/SPORE/specifications/raw/master/spore_validation.rx

png: googlemaps.png

%.png : %.dot
	dot -T png -o $@ $<

googlemaps.dot: \
    directions.json \
    distancematrix.json \
    geocoding.json \
    elevation.json
	$(SPORE2DOT) $^ > $@

clean:
	-rm *.png *.dot spore_validation.rx

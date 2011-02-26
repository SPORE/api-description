VALIDATOR := perl ../utils/validator.pl --schema spore_validation.rx --description
SPORE2DOT := perl ../utils/spore2dot.pl

check: spore_validation.rx
	@make -C github check
	@$(VALIDATOR) amazons3.json
	@$(VALIDATOR) backtweet.json
	@$(VALIDATOR) backtype.json
	@$(VALIDATOR) github.json
	@$(VALIDATOR) ihackernews.json
	@$(VALIDATOR) ohloh.json
	@$(VALIDATOR) twitter.json

test: check

spore_validation.rx:
	wget http://github.com/SPORE/specifications/raw/master/spore_validation.rx

png: \
    amazons3.png \
    backtweet.png \
    backtype.png \
    github.png \
    ihackernews.png \
    ohloh.png \
    twitter.png
	@make -C github png

%.png : %.dot
	dot -T png -o $@ $<

%.dot: %.json
	$(SPORE2DOT) $< > $@

clean:
	@make -C github clean
	-rm *.png *.dot spore_validation.rx

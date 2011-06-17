VALIDATOR := perl ../utils/validator.pl --schema spore_validation.rx --description
SPORE2DOT := perl ../utils/spore2dot.pl

check: spore_validation.rx
	@make -C github check
	@make -C googlemaps check
	@$(VALIDATOR) amazons3.json
	@$(VALIDATOR) backtweet.json
	@$(VALIDATOR) backtype.json
	@$(VALIDATOR) github.json
	@$(VALIDATOR) googleoauth.json
	@$(VALIDATOR) googleoauth2.json
	@$(VALIDATOR) googlepagespeed.json
	@$(VALIDATOR) googleshortener.json
	@$(VALIDATOR) googletranslate.json
	@$(VALIDATOR) ihackernews.json
	@$(VALIDATOR) ohloh.json
	@$(VALIDATOR) twitter.json
	@$(VALIDATOR) intervals.json

test: check

spore_validation.rx:
	wget http://raw.github.com/SPORE/specifications/master/spore_validation.rx

png: \
    amazons3.png \
    backtweet.png \
    backtype.png \
    github.png \
    googleoauth.png \
    googleoauth2.png \
    googlepagespeed.png \
    googleshortener.png \
    googletranslate.png \
    ihackernews.png \
    ohloh.png \
    intervals.png \
    indextank.png \
    twitter.png
	@make -C github png
	@make -C googlemaps png

%.png : %.dot
	dot -T png -o $@ $<

%.dot: %.json
	$(SPORE2DOT) $< > $@

clean:
	@make -C github clean
	@make -C googlemaps clean
	-rm *.png *.dot spore_validation.rx

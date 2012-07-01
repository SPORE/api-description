VALIDATOR := perl ../utils/validator.pl --schema spore_validation.rx --description
SPORE2DOT := perl ../utils/spore2dot.pl

check: spore_validation.rx
	@make -C github check
	@make -C googlemaps check
	@make -C linkedin check
	@$(VALIDATOR) amazons3.json
	@$(VALIDATOR) backtweet.json
	@$(VALIDATOR) backtype.json
	@$(VALIDATOR) bitly.json
	@$(VALIDATOR) datapublica.json
	@$(VALIDATOR) facebook_graph.json
	@$(VALIDATOR) github.json
	@$(VALIDATOR) gnip.json
	@$(VALIDATOR) googlemaps.json
	@$(VALIDATOR) googleoauth.json
	@$(VALIDATOR) googleoauth2.json
	@$(VALIDATOR) googlepagespeed.json
	@$(VALIDATOR) googleshortener.json
	@$(VALIDATOR) googletranslate.json
	@$(VALIDATOR) ihackernews.json
	@$(VALIDATOR) intervals.json
	@$(VALIDATOR) klout.json
	@$(VALIDATOR) ohloh.json
	@$(VALIDATOR) topsy.json
	@$(VALIDATOR) twitter.json
	@$(VALIDATOR) twitter_search.json
	@$(VALIDATOR) intervals.json

test: check

spore_validation.rx:
	wget https://raw.github.com/SPORE/specifications/master/spore_validation.rx

png: \
    amazons3.png \
    backtweet.png \
    backtype.png \
    bitly.png \
    datapublica.png \
    facebook_graph.png \
    github.png \
    gnip.png \
    googlemaps.png \
    googleoauth.png \
    googleoauth2.png \
    googlepagespeed.png \
    googleshortener.png \
    googletranslate.png \
    ihackernews.png \
    indextank.png \
    intervals.png \
    klout.png \
    ohloh.png \
    topsy.png \
    twitter.png \
    twitter_search.png
	@make -C github png
	@make -C googlemaps png
	@make -C linkedin png

%.png : %.dot
	dot -T png -o $@ $<

%.dot: %.json
	$(SPORE2DOT) $< > $@

clean:
	@make -C github clean
	@make -C googlemaps clean
	@make -C linkedin clean
	-rm *.png *.dot spore_validation.rx

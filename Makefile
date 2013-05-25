.PHONY: install uninstall clean

SEARCH_MARSHAL=lib/spotify_search_j.ml
SEARCH_TYPES=lib/spotify_search_t.ml
SEARCH=$(SEARCH_MARSHAL) $(SEARCH_TYPES)

dist/build/lib-spotify_web/spotify_web.cma: $(SEARCH)
	obuild configure
	obuild build

$(SEARCH_MARSHAL):
	atdgen -j lib/spotify_search.atd

$(SEARCH_TYPES):
	atdgen -t lib/spotify_search.atd

install:
	ocamlfind install spotify-web lib/META \
		$(wildcard dist/build/lib-spotify_web/*)

uninstall:
	ocamlfind remove spotify-web

clean:
	rm -f lib/spotify_j.ml*
	rm -f lib/spotify_t.ml*
	rm -rf dist

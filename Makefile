.PHONY: install uninstall clean

SEARCH_MARSHAL=lib/search_j.ml
SEARCH_TYPES=lib/search_t.ml
SEARCH=$(SEARCH_MARSHAL) $(SEARCH_TYPES)

dist/build/lib-spotify-web/spotify-web: $(SEARCH)
	obuild configure
	obuild build

$(SEARCH_MARSHAL):
	atdgen -j lib/search.atd

$(SEARCH_TYPES):
	atdgen -t lib/search.atd

install:
	ocamlfind install spotify-web lib/META \
		$(wildcard dist/build/lib-spotify_web/*)

uninstall:
	ocamlfind remove spotify-web

clean:
	rm -f lib/search_j.ml*
	rm -f lib/search_t.ml*
	rm -rf dist

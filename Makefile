all: build

NAME=spotify-web
J=4

TESTS_FLAG=--enable-tests

LOOKUP_MARSHAL=lib/spotify_lookup_j.ml
LOOKUP_TYPES=lib/spotify_lookup_t.ml
LOOKUP=$(LOOKUP_MARSHAL) $(LOOKUP_TYPES)

$(LOOKUP_MARSHAL):
	atdgen -j lib/spotify_lookup.atd

$(LOOKUP_TYPES):
	atdgen -t lib/spotify_lookup.atd

SEARCH_MARSHAL=lib/spotify_search_j.ml
SEARCH_TYPES=lib/spotify_search_t.ml
SEARCH=$(SEARCH_MARSHAL) $(SEARCH_TYPES)

$(SEARCH_MARSHAL):
	atdgen -j lib/spotify_search.atd

$(SEARCH_TYPES):
	atdgen -t lib/spotify_search.atd

setup.ml: _oasis
	oasis setup

setup.data: setup.ml
	ocaml setup.ml -configure $(TESTS_FLAG)

build: setup.data setup.ml $(LOOKUP) $(SEARCH)
	ocaml setup.ml -build -j $(J)

test: setup.ml build
	ocaml setup.ml -test

install: setup.data setup.ml
	ocaml setup.ml -install

uninstall:
	ocamlfind remove $(NAME)

reinstall: setup.ml
	ocamlfind remove $(NAME) || true
	ocaml setup.ml -reinstall

clean:
	ocamlbuild -clean
	rm -f lib/spotify_lookup_j.ml*
	rm -f lib/spotify_lookup_t.ml*
	rm -f lib/spotify_search_j.ml*
	rm -f lib/spotify_search_t.ml*
	rm -f setup.data setup.log

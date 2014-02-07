all: build

NAME=spotify-web
J=4

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
	ocaml setup.ml -configure

build: setup.data setup.ml $(SEARCH)
	ocaml setup.ml -build -j $(J)

install: setup.data setup.ml
	ocaml setup.ml -install

uninstall:
	ocamlfind remove $(NAME)

reinstall: setup.ml
	ocamlfind remove $(NAME) || true
	ocaml setup.ml -reinstall

clean:
	ocamlbuild -clean
	rm -f lib/spotify_search_j.ml*
	rm -f lib/spotify_search_t.ml*
	rm -f setup.data setup.log

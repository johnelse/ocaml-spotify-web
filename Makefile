.PHONY: install uninstall clean

dist/build/lib-spotify-web/spotify-web:
	obuild configure
	obuild build

install:
	ocamlfind install spotify-web lib/META \
		$(wildcard dist/build/lib-spotify_web/*)

uninstall:
	ocamlfind remove spotify-web

clean:
	rm -rf dist

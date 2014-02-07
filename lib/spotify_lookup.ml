module C = Cohttp_lwt_unix

let base_uri = "http://ws.spotify.com/lookup/1/"

exception Unknown_uid

let lookup mode href parse_fn =
  Spotify_common.check_href mode href;
  let open Cohttp_lwt_unix_io in
  let uri = Uri.of_string
    (Printf.sprintf "%s.json?uri=%s" base_uri href)
  in
  Spotify_common.read_uri uri
    (function
      | "" -> raise Unknown_uid
      | str -> parse_fn str)

let lookup_album href =
  lookup `album href Spotify_lookup_j.album_lookup_of_string

let lookup_artist href =
  lookup `artist href Spotify_lookup_j.artist_lookup_of_string

let lookup_track href =
  lookup `track href Spotify_lookup_j.track_lookup_of_string

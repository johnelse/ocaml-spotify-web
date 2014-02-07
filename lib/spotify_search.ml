module C = Cohttp_lwt_unix

let base_uri = "http://ws.spotify.com/search/1/"

let search mode query parse_fn =
  let open Cohttp_lwt_unix_io in
  let uri = Uri.of_string
    (Printf.sprintf "%s%s.json?q=%s"
      base_uri (Spotify_common.string_of_mode mode) query)
  in
  Spotify_common.read_uri uri parse_fn

let search_albums query =
  search `album query Spotify_search_j.album_search_of_string

let search_artists query =
  search `artist query Spotify_search_j.artist_search_of_string

let search_tracks query =
  search `track query Spotify_search_j.track_search_of_string

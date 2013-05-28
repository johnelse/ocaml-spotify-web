module C = Cohttp_lwt_unix
open Cohttp_lwt_unix_io

let base_uri = "http://ws.spotify.com/search/1/"

type search_mode = [ `album | `artist | `track ]

let string_of_mode = function
  | `album -> "album"
  | `artist -> "artist"
  | `track -> "track"

exception No_response

let search mode query parse_fn =
  let uri = Uri.of_string
    (Printf.sprintf "%s%s.json?q=%s"
      base_uri (string_of_mode mode) query)
  in
  C.Client.call ~chunked:false `GET uri
  >>= (fun result ->
    match result with
    | Some (_, body) ->
      Cohttp_lwt_body.string_of_body body
      >>= (fun data -> return (parse_fn data))
    | None -> Lwt.fail No_response)

let search_albums query =
  search `album query Spotify_search_j.album_search_of_string

let search_artists query =
  search `artist query Spotify_search_j.artist_search_of_string

let search_tracks query =
  search `track query Spotify_search_j.track_search_of_string

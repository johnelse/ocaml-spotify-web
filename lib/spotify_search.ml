module C = Cohttp_lwt_unix
open Cohttp_lwt_unix_io

exception No_response

let base_url = "http://ws.spotify.com/search/1/"

let search_albums query =
  let uri = Uri.of_string (Printf.sprintf "%salbum.json?q=%s" base_url query) in
  C.Client.call ~chunked:false `GET uri
  >>= (fun result ->
    match result with
    | Some (_, body) ->
      C.Body.string_of_body body
      >>= (fun data -> return (Spotify_search_j.album_search_of_string data))
    | None -> Lwt.fail No_response)

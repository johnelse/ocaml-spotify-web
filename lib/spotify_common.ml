let uid_length = 22

type mode = [ `album | `artist | `track ]

let string_of_mode = function
  | `album -> "album"
  | `artist -> "artist"
  | `track -> "track"

exception Invalid_href
exception No_response

module C = Cohttp_lwt_unix

let check_href mode href =
  try
    Scanf.sscanf href "spotify:%s@:%s"
      (fun mode_string uid ->
        if mode_string <> (string_of_mode mode)
        then raise Invalid_href;
        if (String.length uid) <> uid_length
        then raise Invalid_href)
  with Scanf.Scan_failure _ ->
    raise Invalid_href

let read_uri uri parse_fn =
  let open Cohttp_lwt_unix_io in
  C.Client.call ~chunked:false `GET uri
  >>= (fun result ->
    match result with
    | Some (_, body) ->
      Cohttp_lwt_body.string_of_body body
      >>= (fun data -> return (parse_fn data))
    | none -> Lwt.fail No_response)

exception Invalid_href
exception No_response

type mode = [ `album | `artist | `track ]

val string_of_mode : mode -> string

val check_href : mode -> string -> unit

val read_uri : Uri.t -> (string -> 'a) -> 'a Lwt.t

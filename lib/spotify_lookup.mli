exception Unknown_uid

val lookup_album : string -> Spotify_lookup_t.album_lookup Lwt.t
val lookup_artist : string -> Spotify_lookup_t.artist_lookup Lwt.t
val lookup_track : string -> Spotify_lookup_t.track_lookup Lwt.t

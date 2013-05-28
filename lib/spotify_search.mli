exception No_response

val search_albums: string -> Spotify_search_t.album_search Lwt.t
val search_artists: string -> Spotify_search_t.artist_search Lwt.t
val search_tracks: string -> Spotify_search_t.track_search Lwt.t

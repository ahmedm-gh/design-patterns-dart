/// Demonstrates the **Iterator** pattern.
///
/// Provides sequential access to a collection's elements without
/// exposing its underlying structure.
library;

/// A song with a title and artist.
final class Song {
  /// The title of the song.
  final String title;

  /// The artist who performed the song.
  final String artist;

  /// Creates a song with the given [title] and [artist].
  const Song(this.title, this.artist);

  @override
  String toString() => '$title — $artist';
}

/// A custom iterator that traverses a list of songs.
final class PlaylistIterator implements Iterator<Song> {
  final List<Song> _songs;
  int _index = -1;

  /// Creates an iterator over the given [songs].
  PlaylistIterator(List<Song> songs) : _songs = songs;

  @override
  Song get current => _songs[_index];

  @override
  bool moveNext() {
    _index++;
    return _index < _songs.length;
  }
}

/// A named playlist that provides a custom [Iterator].
final class Playlist {
  /// The name of this playlist.
  final String name;

  final List<Song> _songs = [];

  /// Creates a playlist with the given [name].
  Playlist(this.name);

  /// Adds a [song] to this playlist.
  void add(Song song) => _songs.add(song);

  /// The number of songs in this playlist.
  int get length => _songs.length;

  /// Returns an iterator over the songs.
  PlaylistIterator get iterator => PlaylistIterator(_songs);
}

void main() {
  final playlist = Playlist('My Favorites')
    ..add(const Song('Bohemian Rhapsody', 'Queen'))
    ..add(const Song('Stairway to Heaven', 'Led Zeppelin'))
    ..add(const Song('Hotel California', 'Eagles'));

  print('🎵 ${playlist.name} (${playlist.length} songs):');

  final it = playlist.iterator;
  while (it.moveNext()) {
    print('  ▶ ${it.current}');
  }
  // 🎵 My Favorites (3 songs):
  //   ▶ Bohemian Rhapsody — Queen
  //   ▶ Stairway to Heaven — Led Zeppelin
  //   ▶ Hotel California — Eagles
}

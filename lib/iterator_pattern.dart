class Song {
  final String title;
  final String artist;
  Song(this.title, this.artist);

  @override
  String toString() => '$title — $artist';
}

class PlaylistIterator implements Iterator<Song> {
  final List<Song> _songs;
  int _index = -1;

  PlaylistIterator(this._songs);

  @override
  Song get current => _songs[_index];

  @override
  bool moveNext() {
    _index++;
    return _index < _songs.length;
  }
}

class Playlist {
  final String name;
  final List<Song> _songs = [];

  Playlist(this.name);

  void add(Song song) => _songs.add(song);
  int get length => _songs.length;

  PlaylistIterator get iterator => PlaylistIterator(_songs);
}

void main() {
  // --- Usage ---
  final playlist = Playlist('My Favorites')
    ..add(Song('Bohemian Rhapsody', 'Queen'))
    ..add(Song('Stairway to Heaven', 'Led Zeppelin'))
    ..add(Song('Hotel California', 'Eagles'));

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

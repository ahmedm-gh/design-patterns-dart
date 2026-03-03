/// Demonstrates the **Iterator** pattern.
///
/// Provides sequential access to a collection's elements without
/// exposing its underlying structure.
library;

class Song {
  final String title;
  final String artist;
  Song(this.title, this.artist);

  @override
  String toString() => '$title — $artist';
}

// المُكرِّر المُخصَّص — يتتبَّع موضع التنقُّل يدويًا
// Custom Iterator — tracks traversal position manually
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

// المُجمِّع — يُوفِّر المُكرِّر
// Aggregate — provides the iterator
class Playlist {
  final String name;
  final List<Song> _songs = [];

  Playlist(this.name);

  void add(Song song) => _songs.add(song);
  int get length => _songs.length;

  PlaylistIterator get iterator => PlaylistIterator(_songs);
}

void main() {
  // --- الاستخدام ---
  // --- Usage ---
  print('--- 🎶 قائمة الأغاني | Playlist Iterator ---');
  final playlist = Playlist('My Favorites')
    ..add(Song('Bohemian Rhapsody', 'Queen'))
    ..add(Song('Stairway to Heaven', 'Led Zeppelin'))
    ..add(Song('Hotel California', 'Eagles'));

  print('🎵 قائمة "${playlist.name}" تحتوي على ${playlist.length} أغانٍ:');

  final it = playlist.iterator;
  while (it.moveNext()) {
    print('  ▶ ${it.current}');
  }
}

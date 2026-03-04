/// Demonstrates the **Facade** pattern.
///
/// Provides a simplified, unified interface to a complex subsystem.
library;

// DART EXAMPLE

// --- أصناف النظام الفرعي المُعقَّد ---
// --- Complex Subsystem Classes ---
class AudioDecoder {
  String decode(String file) => 'audio_data($file)';
}

class VideoDecoder {
  String decode(String file) => 'video_data($file)';
}

class ScreenRenderer {
  void render(String video, String audio) =>
      // ▶ عرض
      print('Playing: $video + $audio');
}

// --- الواجهة المُبسَّطة ---
// --- Facade ---
class MediaPlayer {
  final _audio = AudioDecoder();
  final _video = VideoDecoder();
  final _renderer = ScreenRenderer();

  void play(String file) {
    final audioData = _audio.decode(file);
    final videoData = _video.decode(file);
    _renderer.render(videoData, audioData);
  }
}

void main() {
  // --- الاستخدام ---
  // --- Usage ---
  // --- 🎬 بدء تشغيل الفيلم
  print('Starting Movie ---');
  MediaPlayer().play('movie.mp4');
}

// --- Complex Subsystem Classes ---
class AudioDecoder {
  String decode(String file) => 'audio_data($file)';
}

class VideoDecoder {
  String decode(String file) => 'video_data($file)';
}

class ScreenRenderer {
  void render(String video, String audio) =>
      print('▶ Playing: $video with $audio');
}

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
  // --- Usage ---
  MediaPlayer().play('movie.mp4'); // ▶ Playing: video_data(movie.mp4) with audio_data(movie.mp4)
}

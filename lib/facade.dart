/// Demonstrates the **Facade** pattern.
///
/// Provides a simplified, unified interface to a complex subsystem.
library;

/// Decodes audio from a media file.
class AudioDecoder {
  /// Decodes and returns audio data from [file].
  String decode(String file) => 'audio_data($file)';
}

/// Decodes video from a media file.
class VideoDecoder {
  /// Decodes and returns video data from [file].
  String decode(String file) => 'video_data($file)';
}

/// Renders video and audio to the screen.
class ScreenRenderer {
  /// Renders the given [video] and [audio] data.
  void render(String video, String audio) =>
      print('▶ Playing: $video with $audio');
}

/// A simplified interface for playing media files.
///
/// Hides the complexity of decoding audio/video and rendering.
class MediaPlayer {
  final _audio = AudioDecoder();
  final _video = VideoDecoder();
  final _renderer = ScreenRenderer();

  /// Plays the media [file] by decoding and rendering it.
  void play(String file) {
    final audioData = _audio.decode(file);
    final videoData = _video.decode(file);
    _renderer.render(videoData, audioData);
  }
}

void main() {
  MediaPlayer().play('movie.mp4');
  // ▶ Playing: video_data(movie.mp4) with audio_data(movie.mp4)
}

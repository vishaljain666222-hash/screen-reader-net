import 'package:audioplayers/audioplayers.dart';

/// Plays short quiz sound effects. Uses a fresh low-latency AudioPlayer per
/// call (audioplayers' recommended pattern for quick one-shot sounds) so
/// rapid taps never get stuck waiting on a previous sound to finish.
class SoundService {
  static Future<void> _play(String assetPath) async {
    try {
      final player = AudioPlayer();
      await player.setReleaseMode(ReleaseMode.release);
      await player.play(AssetSource(assetPath));
    } catch (_) {
      // Never let a missing/broken sound file interrupt the quiz.
    }
  }

  static Future<void> playCorrect() => _play('sounds/correct.wav');
  static Future<void> playWrong() => _play('sounds/wrong.wav');
  static Future<void> playClick() => _play('sounds/click.wav');
}

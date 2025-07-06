import 'dart:io';
import 'package:record/record.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

class AudioService {
  final AudioRecorder _audioRecorder = AudioRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();

  String? _currentRecordingPath;
  bool _isRecording = false;
  bool _isPlaying = false;

  // Getters
  bool get isRecording => _isRecording;
  bool get isPlaying => _isPlaying;
  String? get currentRecordingPath => _currentRecordingPath;
  Stream<Duration> get positionStream => _audioPlayer.positionStream;
  Stream<Duration?> get durationStream => _audioPlayer.durationStream;

  // Recording methods
  Future<bool> startRecording() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        final Directory appDocumentsDir =
            await getApplicationDocumentsDirectory();
        final String filePath =
            '${appDocumentsDir.path}/recording_${DateTime.now().millisecondsSinceEpoch}.m4a';

        await _audioRecorder.start(
          const RecordConfig(
            encoder: AudioEncoder.aacLc,
            bitRate: 128000,
            sampleRate: 44100,
          ),
          path: filePath,
        );

        _currentRecordingPath = filePath;
        _isRecording = true;
        return true;
      }
      return false;
    } catch (e) {
      throw Exception('Failed to start recording: $e');
    }
  }

  Future<String?> stopRecording() async {
    try {
      final String? path = await _audioRecorder.stop();
      _isRecording = false;
      return path;
    } catch (e) {
      throw Exception('Failed to stop recording: $e');
    }
  }

  Future<void> pauseRecording() async {
    try {
      await _audioRecorder.pause();
    } catch (e) {
      throw Exception('Failed to pause recording: $e');
    }
  }

  Future<void> resumeRecording() async {
    try {
      await _audioRecorder.resume();
    } catch (e) {
      throw Exception('Failed to resume recording: $e');
    }
  }

  // Playback methods
  Future<void> play(String filePath) async {
    try {
      await _audioPlayer.setFilePath(filePath);
      await _audioPlayer.play();
      _isPlaying = true;
    } catch (e) {
      throw Exception('Failed to play audio: $e');
    }
  }

  Future<void> pause() async {
    try {
      await _audioPlayer.pause();
      _isPlaying = false;
    } catch (e) {
      throw Exception('Failed to pause audio: $e');
    }
  }

  Future<void> stop() async {
    try {
      await _audioPlayer.stop();
      _isPlaying = false;
    } catch (e) {
      throw Exception('Failed to stop audio: $e');
    }
  }

  Future<void> seek(Duration position) async {
    try {
      await _audioPlayer.seek(position);
    } catch (e) {
      throw Exception('Failed to seek audio: $e');
    }
  }

  // Cleanup
  Future<void> dispose() async {
    await _audioRecorder.dispose();
    await _audioPlayer.dispose();
  }
}

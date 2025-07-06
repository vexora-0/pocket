import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../data/datasources/audio_service.dart';
import '../data/models/conversation.dart';

part 'audio_controller.freezed.dart';

@freezed
class AudioState with _$AudioState {
  const factory AudioState({
    @Default(false) bool isRecording,
    @Default(false) bool isPlaying,
    @Default(false) bool isPaused,
    @Default([]) List<Conversation> conversations,
    Conversation? currentConversation,
    @Default(Duration.zero) Duration recordingDuration,
    @Default(Duration.zero) Duration playbackPosition,
    String? error,
  }) = _AudioState;
}

class AudioController extends StateNotifier<AudioState> {
  final AudioService _audioService;

  AudioController(this._audioService) : super(const AudioState());

  Future<void> startRecording() async {
    try {
      final bool success = await _audioService.startRecording();
      if (success) {
        state = state.copyWith(isRecording: true, error: null);
      } else {
        state = state.copyWith(
          error: 'Failed to start recording. Please check permissions.',
        );
      }
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> stopRecording() async {
    try {
      final String? filePath = await _audioService.stopRecording();
      if (filePath != null) {
        // Create a simple conversation type for recordings
        final recordingType = ConversationType(
          id: 'recording',
          title: 'Recording',
          iconPath: 'assets/icons/audio.svg',
        );

        final conversation = Conversation(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: 'Recording ${DateTime.now().day}/${DateTime.now().month}',
          type: recordingType, // Add required type parameter
          gradientColors: [
            0xFF8B5CF6,
            0xFFEC4899,
          ], // Add gradient colors for recordings
          createdAt: DateTime.now(),
          duration:
              state.recordingDuration.inSeconds, // Convert to seconds (int)
        );

        state = state.copyWith(
          isRecording: false,
          conversations: [...state.conversations, conversation],
          recordingDuration: Duration.zero,
          error: null,
        );
      }
    } catch (e) {
      state = state.copyWith(error: e.toString(), isRecording: false);
    }
  }

  Future<void> playConversation(Conversation conversation) async {
    try {
      // For now, we'll need to handle audio file paths differently
      // since filePath is no longer part of the Conversation model
      // This would need to be stored separately or handled by an audio service
      await _audioService.play(conversation.id); // Use ID as temporary solution
      state = state.copyWith(
        isPlaying: true,
        currentConversation: conversation,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> pausePlayback() async {
    try {
      await _audioService.pause();
      state = state.copyWith(isPlaying: false, isPaused: true);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> stopPlayback() async {
    try {
      await _audioService.stop();
      state = state.copyWith(
        isPlaying: false,
        isPaused: false,
        currentConversation: null,
        playbackPosition: Duration.zero,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

// Providers
final audioServiceProvider = Provider<AudioService>((ref) => AudioService());

final audioControllerProvider =
    StateNotifierProvider<AudioController, AudioState>((ref) {
      final audioService = ref.watch(audioServiceProvider);
      return AudioController(audioService);
    });

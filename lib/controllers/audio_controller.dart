import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../data/datasources/audio_service.dart';
import '../data/models/conversation.dart';

part 'audio_controller.freezed.dart';

/// Represents the current state of the audio system.
///
/// This state includes recording status, playback status, conversations,
/// and error information for the audio functionality.
@freezed
class AudioState with _$AudioState {
  const factory AudioState({
    /// Whether audio recording is currently active
    @Default(false) bool isRecording,

    /// Whether audio playback is currently active
    @Default(false) bool isPlaying,

    /// Whether audio playback is paused
    @Default(false) bool isPaused,

    /// List of all recorded conversations
    @Default([]) List<Conversation> conversations,

    /// The conversation currently being played
    Conversation? currentConversation,

    /// Duration of the current recording session
    @Default(Duration.zero) Duration recordingDuration,

    /// Current playback position
    @Default(Duration.zero) Duration playbackPosition,

    /// Error message if any operation fails
    String? error,
  }) = _AudioState;
}

/// Controller for managing audio recording and playback operations.
///
/// This controller handles all audio-related functionality including
/// starting/stopping recordings, playing conversations, and managing
/// the audio state throughout the application.
class AudioController extends StateNotifier<AudioState> {
  final AudioService _audioService;

  AudioController(this._audioService) : super(const AudioState());

  /// Starts a new audio recording session.
  ///
  /// Updates the state to indicate recording is active if successful,
  /// or sets an error message if the operation fails.
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

  /// Stops the current recording session and saves the conversation.
  ///
  /// Creates a new [Conversation] object with the recorded audio
  /// and adds it to the conversations list.
  Future<void> stopRecording() async {
    try {
      final String? filePath = await _audioService.stopRecording();
      if (filePath != null) {
        final recordingType = ConversationType(
          id: 'recording',
          title: 'Recording',
          iconPath: 'assets/icons/audio.svg',
        );

        final conversation = Conversation(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: 'Recording ${DateTime.now().day}/${DateTime.now().month}',
          type: recordingType,
          gradientColors: [0xFF8B5CF6, 0xFFEC4899],
          createdAt: DateTime.now(),
          duration: state.recordingDuration.inSeconds,
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

  /// Starts playback of the specified conversation.
  ///
  /// Updates the state to indicate playback is active and sets
  /// the current conversation being played.
  Future<void> playConversation(Conversation conversation) async {
    try {
      await _audioService.play(conversation.id);
      state = state.copyWith(
        isPlaying: true,
        currentConversation: conversation,
        error: null,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Pauses the current audio playback.
  Future<void> pausePlayback() async {
    try {
      await _audioService.pause();
      state = state.copyWith(isPlaying: false, isPaused: true);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Stops the current audio playback and resets playback state.
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

  /// Clears any error message from the state.
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

// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AudioState {
  bool get isRecording => throw _privateConstructorUsedError;
  bool get isPlaying => throw _privateConstructorUsedError;
  bool get isPaused => throw _privateConstructorUsedError;
  List<Conversation> get conversations => throw _privateConstructorUsedError;
  Conversation? get currentConversation => throw _privateConstructorUsedError;
  Duration get recordingDuration => throw _privateConstructorUsedError;
  Duration get playbackPosition => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of AudioState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AudioStateCopyWith<AudioState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioStateCopyWith<$Res> {
  factory $AudioStateCopyWith(
    AudioState value,
    $Res Function(AudioState) then,
  ) = _$AudioStateCopyWithImpl<$Res, AudioState>;
  @useResult
  $Res call({
    bool isRecording,
    bool isPlaying,
    bool isPaused,
    List<Conversation> conversations,
    Conversation? currentConversation,
    Duration recordingDuration,
    Duration playbackPosition,
    String? error,
  });

  $ConversationCopyWith<$Res>? get currentConversation;
}

/// @nodoc
class _$AudioStateCopyWithImpl<$Res, $Val extends AudioState>
    implements $AudioStateCopyWith<$Res> {
  _$AudioStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AudioState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isRecording = null,
    Object? isPlaying = null,
    Object? isPaused = null,
    Object? conversations = null,
    Object? currentConversation = freezed,
    Object? recordingDuration = null,
    Object? playbackPosition = null,
    Object? error = freezed,
  }) {
    return _then(
      _value.copyWith(
            isRecording:
                null == isRecording
                    ? _value.isRecording
                    : isRecording // ignore: cast_nullable_to_non_nullable
                        as bool,
            isPlaying:
                null == isPlaying
                    ? _value.isPlaying
                    : isPlaying // ignore: cast_nullable_to_non_nullable
                        as bool,
            isPaused:
                null == isPaused
                    ? _value.isPaused
                    : isPaused // ignore: cast_nullable_to_non_nullable
                        as bool,
            conversations:
                null == conversations
                    ? _value.conversations
                    : conversations // ignore: cast_nullable_to_non_nullable
                        as List<Conversation>,
            currentConversation:
                freezed == currentConversation
                    ? _value.currentConversation
                    : currentConversation // ignore: cast_nullable_to_non_nullable
                        as Conversation?,
            recordingDuration:
                null == recordingDuration
                    ? _value.recordingDuration
                    : recordingDuration // ignore: cast_nullable_to_non_nullable
                        as Duration,
            playbackPosition:
                null == playbackPosition
                    ? _value.playbackPosition
                    : playbackPosition // ignore: cast_nullable_to_non_nullable
                        as Duration,
            error:
                freezed == error
                    ? _value.error
                    : error // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }

  /// Create a copy of AudioState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConversationCopyWith<$Res>? get currentConversation {
    if (_value.currentConversation == null) {
      return null;
    }

    return $ConversationCopyWith<$Res>(_value.currentConversation!, (value) {
      return _then(_value.copyWith(currentConversation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AudioStateImplCopyWith<$Res>
    implements $AudioStateCopyWith<$Res> {
  factory _$$AudioStateImplCopyWith(
    _$AudioStateImpl value,
    $Res Function(_$AudioStateImpl) then,
  ) = __$$AudioStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool isRecording,
    bool isPlaying,
    bool isPaused,
    List<Conversation> conversations,
    Conversation? currentConversation,
    Duration recordingDuration,
    Duration playbackPosition,
    String? error,
  });

  @override
  $ConversationCopyWith<$Res>? get currentConversation;
}

/// @nodoc
class __$$AudioStateImplCopyWithImpl<$Res>
    extends _$AudioStateCopyWithImpl<$Res, _$AudioStateImpl>
    implements _$$AudioStateImplCopyWith<$Res> {
  __$$AudioStateImplCopyWithImpl(
    _$AudioStateImpl _value,
    $Res Function(_$AudioStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AudioState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isRecording = null,
    Object? isPlaying = null,
    Object? isPaused = null,
    Object? conversations = null,
    Object? currentConversation = freezed,
    Object? recordingDuration = null,
    Object? playbackPosition = null,
    Object? error = freezed,
  }) {
    return _then(
      _$AudioStateImpl(
        isRecording:
            null == isRecording
                ? _value.isRecording
                : isRecording // ignore: cast_nullable_to_non_nullable
                    as bool,
        isPlaying:
            null == isPlaying
                ? _value.isPlaying
                : isPlaying // ignore: cast_nullable_to_non_nullable
                    as bool,
        isPaused:
            null == isPaused
                ? _value.isPaused
                : isPaused // ignore: cast_nullable_to_non_nullable
                    as bool,
        conversations:
            null == conversations
                ? _value._conversations
                : conversations // ignore: cast_nullable_to_non_nullable
                    as List<Conversation>,
        currentConversation:
            freezed == currentConversation
                ? _value.currentConversation
                : currentConversation // ignore: cast_nullable_to_non_nullable
                    as Conversation?,
        recordingDuration:
            null == recordingDuration
                ? _value.recordingDuration
                : recordingDuration // ignore: cast_nullable_to_non_nullable
                    as Duration,
        playbackPosition:
            null == playbackPosition
                ? _value.playbackPosition
                : playbackPosition // ignore: cast_nullable_to_non_nullable
                    as Duration,
        error:
            freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc

class _$AudioStateImpl implements _AudioState {
  const _$AudioStateImpl({
    this.isRecording = false,
    this.isPlaying = false,
    this.isPaused = false,
    final List<Conversation> conversations = const [],
    this.currentConversation,
    this.recordingDuration = Duration.zero,
    this.playbackPosition = Duration.zero,
    this.error,
  }) : _conversations = conversations;

  @override
  @JsonKey()
  final bool isRecording;
  @override
  @JsonKey()
  final bool isPlaying;
  @override
  @JsonKey()
  final bool isPaused;
  final List<Conversation> _conversations;
  @override
  @JsonKey()
  List<Conversation> get conversations {
    if (_conversations is EqualUnmodifiableListView) return _conversations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_conversations);
  }

  @override
  final Conversation? currentConversation;
  @override
  @JsonKey()
  final Duration recordingDuration;
  @override
  @JsonKey()
  final Duration playbackPosition;
  @override
  final String? error;

  @override
  String toString() {
    return 'AudioState(isRecording: $isRecording, isPlaying: $isPlaying, isPaused: $isPaused, conversations: $conversations, currentConversation: $currentConversation, recordingDuration: $recordingDuration, playbackPosition: $playbackPosition, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AudioStateImpl &&
            (identical(other.isRecording, isRecording) ||
                other.isRecording == isRecording) &&
            (identical(other.isPlaying, isPlaying) ||
                other.isPlaying == isPlaying) &&
            (identical(other.isPaused, isPaused) ||
                other.isPaused == isPaused) &&
            const DeepCollectionEquality().equals(
              other._conversations,
              _conversations,
            ) &&
            (identical(other.currentConversation, currentConversation) ||
                other.currentConversation == currentConversation) &&
            (identical(other.recordingDuration, recordingDuration) ||
                other.recordingDuration == recordingDuration) &&
            (identical(other.playbackPosition, playbackPosition) ||
                other.playbackPosition == playbackPosition) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    isRecording,
    isPlaying,
    isPaused,
    const DeepCollectionEquality().hash(_conversations),
    currentConversation,
    recordingDuration,
    playbackPosition,
    error,
  );

  /// Create a copy of AudioState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AudioStateImplCopyWith<_$AudioStateImpl> get copyWith =>
      __$$AudioStateImplCopyWithImpl<_$AudioStateImpl>(this, _$identity);
}

abstract class _AudioState implements AudioState {
  const factory _AudioState({
    final bool isRecording,
    final bool isPlaying,
    final bool isPaused,
    final List<Conversation> conversations,
    final Conversation? currentConversation,
    final Duration recordingDuration,
    final Duration playbackPosition,
    final String? error,
  }) = _$AudioStateImpl;

  @override
  bool get isRecording;
  @override
  bool get isPlaying;
  @override
  bool get isPaused;
  @override
  List<Conversation> get conversations;
  @override
  Conversation? get currentConversation;
  @override
  Duration get recordingDuration;
  @override
  Duration get playbackPosition;
  @override
  String? get error;

  /// Create a copy of AudioState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AudioStateImplCopyWith<_$AudioStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation.freezed.dart';
part 'conversation.g.dart';

/// Represents a conversation or recording in the app.
///
/// A conversation contains metadata about an audio recording including
/// its title, type, duration, and visual styling information.
@freezed
class Conversation with _$Conversation {
  const factory Conversation({
    /// Unique identifier for the conversation
    required String id,

    /// Display title of the conversation
    required String title,

    /// Optional subtitle or description
    String? subtitle,

    /// Formatted time string for display
    String? time,

    /// The type/category of this conversation
    required ConversationType type,

    /// Colors for gradient background (as integer values for serialization)
    required List<int> gradientColors,

    /// Whether this conversation is currently active/selected
    @Default(false) bool isActive,

    /// When the conversation was created
    DateTime? createdAt,

    /// When the conversation was last updated
    DateTime? updatedAt,

    /// Duration of the audio in seconds
    int? duration,

    /// Playback progress from 0.0 to 1.0
    double? progress,
  }) = _Conversation;

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);
}

/// Represents a category or type of conversation.
///
/// Used for organizing conversations into different categories
/// such as "Chats", "Meetings", "Thoughts", etc.
@freezed
class ConversationType with _$ConversationType {
  const factory ConversationType({
    /// Unique identifier for the conversation type
    required String id,

    /// Display title of the conversation type
    required String title,

    /// Path to the icon asset for this type
    required String iconPath,
  }) = _ConversationType;

  factory ConversationType.fromJson(Map<String, dynamic> json) =>
      _$ConversationTypeFromJson(json);
}

/// Represents date information for the date picker calendar.
///
/// Contains formatted date strings and selection state for
/// displaying dates in the calendar interface.
@freezed
class DateInfo with _$DateInfo {
  const factory DateInfo({
    /// The actual date
    required DateTime date,

    /// Full weekday name (e.g., "Monday")
    required String weekday,

    /// Short weekday abbreviation (e.g., "Mon")
    required String shortWeekday,

    /// Full weekday name for display
    required String fullWeekday,

    /// Whether this date is currently selected
    @Default(false) bool isSelected,
  }) = _DateInfo;

  factory DateInfo.fromJson(Map<String, dynamic> json) =>
      _$DateInfoFromJson(json);
}

/// Represents data for the mini audio player.
///
/// Contains the current playback state and metadata for
/// the minimized audio player interface.
@freezed
class MiniPlayerData with _$MiniPlayerData {
  const factory MiniPlayerData({
    /// Title of the currently playing audio
    required String title,

    /// Formatted duration string (e.g., "03:45")
    required String duration,

    /// Playback progress from 0.0 to 1.0
    required double progress,

    /// Whether audio is currently playing
    required bool isPlaying,

    /// URL or path to album art image
    String? albumArtUrl,

    /// Whether the audio has been processed
    @Default(false) bool isProcessed,
  }) = _MiniPlayerData;

  factory MiniPlayerData.fromJson(Map<String, dynamic> json) =>
      _$MiniPlayerDataFromJson(json);
}

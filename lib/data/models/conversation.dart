import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation.freezed.dart';
part 'conversation.g.dart';

@freezed
class Conversation with _$Conversation {
  const factory Conversation({
    required String id,
    required String title,
    String? subtitle,
    String? time,
    required ConversationType type,
    required List<int>
    gradientColors, // Add back gradient colors for conversation cards
    @Default(false) bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? duration, // in seconds
    double? progress, // 0.0 to 1.0
  }) = _Conversation;

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);
}

@freezed
class ConversationType with _$ConversationType {
  const factory ConversationType({
    required String id,
    required String title,
    required String iconPath,
  }) = _ConversationType;

  factory ConversationType.fromJson(Map<String, dynamic> json) =>
      _$ConversationTypeFromJson(json);
}

@freezed
class DateInfo with _$DateInfo {
  const factory DateInfo({
    required DateTime date,
    required String weekday,
    required String shortWeekday,
    required String fullWeekday,
    @Default(false) bool isSelected,
  }) = _DateInfo;

  factory DateInfo.fromJson(Map<String, dynamic> json) =>
      _$DateInfoFromJson(json);
}

@freezed
class MiniPlayerData with _$MiniPlayerData {
  const factory MiniPlayerData({
    required String title,
    required String duration,
    required double progress, // 0.0 to 1.0
    required bool isPlaying,
    String? albumArtUrl,
    @Default(false) bool isProcessed,
  }) = _MiniPlayerData;

  factory MiniPlayerData.fromJson(Map<String, dynamic> json) =>
      _$MiniPlayerDataFromJson(json);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConversationImpl _$$ConversationImplFromJson(Map<String, dynamic> json) =>
    _$ConversationImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      time: json['time'] as String?,
      type: ConversationType.fromJson(json['type'] as Map<String, dynamic>),
      gradientColors:
          (json['gradientColors'] as List<dynamic>)
              .map((e) => (e as num).toInt())
              .toList(),
      isActive: json['isActive'] as bool? ?? false,
      createdAt:
          json['createdAt'] == null
              ? null
              : DateTime.parse(json['createdAt'] as String),
      updatedAt:
          json['updatedAt'] == null
              ? null
              : DateTime.parse(json['updatedAt'] as String),
      duration: (json['duration'] as num?)?.toInt(),
      progress: (json['progress'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$ConversationImplToJson(_$ConversationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'time': instance.time,
      'type': instance.type,
      'gradientColors': instance.gradientColors,
      'isActive': instance.isActive,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'duration': instance.duration,
      'progress': instance.progress,
    };

_$ConversationTypeImpl _$$ConversationTypeImplFromJson(
  Map<String, dynamic> json,
) => _$ConversationTypeImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  iconPath: json['iconPath'] as String,
);

Map<String, dynamic> _$$ConversationTypeImplToJson(
  _$ConversationTypeImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'iconPath': instance.iconPath,
};

_$DateInfoImpl _$$DateInfoImplFromJson(Map<String, dynamic> json) =>
    _$DateInfoImpl(
      date: DateTime.parse(json['date'] as String),
      weekday: json['weekday'] as String,
      shortWeekday: json['shortWeekday'] as String,
      fullWeekday: json['fullWeekday'] as String,
      isSelected: json['isSelected'] as bool? ?? false,
    );

Map<String, dynamic> _$$DateInfoImplToJson(_$DateInfoImpl instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'weekday': instance.weekday,
      'shortWeekday': instance.shortWeekday,
      'fullWeekday': instance.fullWeekday,
      'isSelected': instance.isSelected,
    };

_$MiniPlayerDataImpl _$$MiniPlayerDataImplFromJson(Map<String, dynamic> json) =>
    _$MiniPlayerDataImpl(
      title: json['title'] as String,
      duration: json['duration'] as String,
      progress: (json['progress'] as num).toDouble(),
      isPlaying: json['isPlaying'] as bool,
      albumArtUrl: json['albumArtUrl'] as String?,
      isProcessed: json['isProcessed'] as bool? ?? false,
    );

Map<String, dynamic> _$$MiniPlayerDataImplToJson(
  _$MiniPlayerDataImpl instance,
) => <String, dynamic>{
  'title': instance.title,
  'duration': instance.duration,
  'progress': instance.progress,
  'isPlaying': instance.isPlaying,
  'albumArtUrl': instance.albumArtUrl,
  'isProcessed': instance.isProcessed,
};

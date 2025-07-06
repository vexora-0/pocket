// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Conversation _$ConversationFromJson(Map<String, dynamic> json) {
  return _Conversation.fromJson(json);
}

/// @nodoc
mixin _$Conversation {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get subtitle => throw _privateConstructorUsedError;
  String? get time => throw _privateConstructorUsedError;
  ConversationType get type => throw _privateConstructorUsedError;
  List<int> get gradientColors =>
      throw _privateConstructorUsedError; // Add back gradient colors for conversation cards
  bool get isActive => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  int? get duration => throw _privateConstructorUsedError; // in seconds
  double? get progress => throw _privateConstructorUsedError;

  /// Serializes this Conversation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConversationCopyWith<Conversation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationCopyWith<$Res> {
  factory $ConversationCopyWith(
    Conversation value,
    $Res Function(Conversation) then,
  ) = _$ConversationCopyWithImpl<$Res, Conversation>;
  @useResult
  $Res call({
    String id,
    String title,
    String? subtitle,
    String? time,
    ConversationType type,
    List<int> gradientColors,
    bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? duration,
    double? progress,
  });

  $ConversationTypeCopyWith<$Res> get type;
}

/// @nodoc
class _$ConversationCopyWithImpl<$Res, $Val extends Conversation>
    implements $ConversationCopyWith<$Res> {
  _$ConversationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subtitle = freezed,
    Object? time = freezed,
    Object? type = null,
    Object? gradientColors = null,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? duration = freezed,
    Object? progress = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            title:
                null == title
                    ? _value.title
                    : title // ignore: cast_nullable_to_non_nullable
                        as String,
            subtitle:
                freezed == subtitle
                    ? _value.subtitle
                    : subtitle // ignore: cast_nullable_to_non_nullable
                        as String?,
            time:
                freezed == time
                    ? _value.time
                    : time // ignore: cast_nullable_to_non_nullable
                        as String?,
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as ConversationType,
            gradientColors:
                null == gradientColors
                    ? _value.gradientColors
                    : gradientColors // ignore: cast_nullable_to_non_nullable
                        as List<int>,
            isActive:
                null == isActive
                    ? _value.isActive
                    : isActive // ignore: cast_nullable_to_non_nullable
                        as bool,
            createdAt:
                freezed == createdAt
                    ? _value.createdAt
                    : createdAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            updatedAt:
                freezed == updatedAt
                    ? _value.updatedAt
                    : updatedAt // ignore: cast_nullable_to_non_nullable
                        as DateTime?,
            duration:
                freezed == duration
                    ? _value.duration
                    : duration // ignore: cast_nullable_to_non_nullable
                        as int?,
            progress:
                freezed == progress
                    ? _value.progress
                    : progress // ignore: cast_nullable_to_non_nullable
                        as double?,
          )
          as $Val,
    );
  }

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ConversationTypeCopyWith<$Res> get type {
    return $ConversationTypeCopyWith<$Res>(_value.type, (value) {
      return _then(_value.copyWith(type: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ConversationImplCopyWith<$Res>
    implements $ConversationCopyWith<$Res> {
  factory _$$ConversationImplCopyWith(
    _$ConversationImpl value,
    $Res Function(_$ConversationImpl) then,
  ) = __$$ConversationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String? subtitle,
    String? time,
    ConversationType type,
    List<int> gradientColors,
    bool isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? duration,
    double? progress,
  });

  @override
  $ConversationTypeCopyWith<$Res> get type;
}

/// @nodoc
class __$$ConversationImplCopyWithImpl<$Res>
    extends _$ConversationCopyWithImpl<$Res, _$ConversationImpl>
    implements _$$ConversationImplCopyWith<$Res> {
  __$$ConversationImplCopyWithImpl(
    _$ConversationImpl _value,
    $Res Function(_$ConversationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? subtitle = freezed,
    Object? time = freezed,
    Object? type = null,
    Object? gradientColors = null,
    Object? isActive = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? duration = freezed,
    Object? progress = freezed,
  }) {
    return _then(
      _$ConversationImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        title:
            null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String,
        subtitle:
            freezed == subtitle
                ? _value.subtitle
                : subtitle // ignore: cast_nullable_to_non_nullable
                    as String?,
        time:
            freezed == time
                ? _value.time
                : time // ignore: cast_nullable_to_non_nullable
                    as String?,
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as ConversationType,
        gradientColors:
            null == gradientColors
                ? _value._gradientColors
                : gradientColors // ignore: cast_nullable_to_non_nullable
                    as List<int>,
        isActive:
            null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                    as bool,
        createdAt:
            freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        updatedAt:
            freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                    as DateTime?,
        duration:
            freezed == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                    as int?,
        progress:
            freezed == progress
                ? _value.progress
                : progress // ignore: cast_nullable_to_non_nullable
                    as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ConversationImpl implements _Conversation {
  const _$ConversationImpl({
    required this.id,
    required this.title,
    this.subtitle,
    this.time,
    required this.type,
    required final List<int> gradientColors,
    this.isActive = false,
    this.createdAt,
    this.updatedAt,
    this.duration,
    this.progress,
  }) : _gradientColors = gradientColors;

  factory _$ConversationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConversationImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String? subtitle;
  @override
  final String? time;
  @override
  final ConversationType type;
  final List<int> _gradientColors;
  @override
  List<int> get gradientColors {
    if (_gradientColors is EqualUnmodifiableListView) return _gradientColors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_gradientColors);
  }

  // Add back gradient colors for conversation cards
  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final int? duration;
  // in seconds
  @override
  final double? progress;

  @override
  String toString() {
    return 'Conversation(id: $id, title: $title, subtitle: $subtitle, time: $time, type: $type, gradientColors: $gradientColors, isActive: $isActive, createdAt: $createdAt, updatedAt: $updatedAt, duration: $duration, progress: $progress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConversationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(
              other._gradientColors,
              _gradientColors,
            ) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.progress, progress) ||
                other.progress == progress));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    subtitle,
    time,
    type,
    const DeepCollectionEquality().hash(_gradientColors),
    isActive,
    createdAt,
    updatedAt,
    duration,
    progress,
  );

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConversationImplCopyWith<_$ConversationImpl> get copyWith =>
      __$$ConversationImplCopyWithImpl<_$ConversationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConversationImplToJson(this);
  }
}

abstract class _Conversation implements Conversation {
  const factory _Conversation({
    required final String id,
    required final String title,
    final String? subtitle,
    final String? time,
    required final ConversationType type,
    required final List<int> gradientColors,
    final bool isActive,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final int? duration,
    final double? progress,
  }) = _$ConversationImpl;

  factory _Conversation.fromJson(Map<String, dynamic> json) =
      _$ConversationImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String? get subtitle;
  @override
  String? get time;
  @override
  ConversationType get type;
  @override
  List<int> get gradientColors; // Add back gradient colors for conversation cards
  @override
  bool get isActive;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  int? get duration; // in seconds
  @override
  double? get progress;

  /// Create a copy of Conversation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConversationImplCopyWith<_$ConversationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ConversationType _$ConversationTypeFromJson(Map<String, dynamic> json) {
  return _ConversationType.fromJson(json);
}

/// @nodoc
mixin _$ConversationType {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get iconPath => throw _privateConstructorUsedError;

  /// Serializes this ConversationType to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ConversationType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ConversationTypeCopyWith<ConversationType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationTypeCopyWith<$Res> {
  factory $ConversationTypeCopyWith(
    ConversationType value,
    $Res Function(ConversationType) then,
  ) = _$ConversationTypeCopyWithImpl<$Res, ConversationType>;
  @useResult
  $Res call({String id, String title, String iconPath});
}

/// @nodoc
class _$ConversationTypeCopyWithImpl<$Res, $Val extends ConversationType>
    implements $ConversationTypeCopyWith<$Res> {
  _$ConversationTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ConversationType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? iconPath = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            title:
                null == title
                    ? _value.title
                    : title // ignore: cast_nullable_to_non_nullable
                        as String,
            iconPath:
                null == iconPath
                    ? _value.iconPath
                    : iconPath // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ConversationTypeImplCopyWith<$Res>
    implements $ConversationTypeCopyWith<$Res> {
  factory _$$ConversationTypeImplCopyWith(
    _$ConversationTypeImpl value,
    $Res Function(_$ConversationTypeImpl) then,
  ) = __$$ConversationTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title, String iconPath});
}

/// @nodoc
class __$$ConversationTypeImplCopyWithImpl<$Res>
    extends _$ConversationTypeCopyWithImpl<$Res, _$ConversationTypeImpl>
    implements _$$ConversationTypeImplCopyWith<$Res> {
  __$$ConversationTypeImplCopyWithImpl(
    _$ConversationTypeImpl _value,
    $Res Function(_$ConversationTypeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ConversationType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? iconPath = null,
  }) {
    return _then(
      _$ConversationTypeImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        title:
            null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String,
        iconPath:
            null == iconPath
                ? _value.iconPath
                : iconPath // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ConversationTypeImpl implements _ConversationType {
  const _$ConversationTypeImpl({
    required this.id,
    required this.title,
    required this.iconPath,
  });

  factory _$ConversationTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConversationTypeImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String iconPath;

  @override
  String toString() {
    return 'ConversationType(id: $id, title: $title, iconPath: $iconPath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConversationTypeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.iconPath, iconPath) ||
                other.iconPath == iconPath));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, iconPath);

  /// Create a copy of ConversationType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ConversationTypeImplCopyWith<_$ConversationTypeImpl> get copyWith =>
      __$$ConversationTypeImplCopyWithImpl<_$ConversationTypeImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ConversationTypeImplToJson(this);
  }
}

abstract class _ConversationType implements ConversationType {
  const factory _ConversationType({
    required final String id,
    required final String title,
    required final String iconPath,
  }) = _$ConversationTypeImpl;

  factory _ConversationType.fromJson(Map<String, dynamic> json) =
      _$ConversationTypeImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get iconPath;

  /// Create a copy of ConversationType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ConversationTypeImplCopyWith<_$ConversationTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DateInfo _$DateInfoFromJson(Map<String, dynamic> json) {
  return _DateInfo.fromJson(json);
}

/// @nodoc
mixin _$DateInfo {
  DateTime get date => throw _privateConstructorUsedError;
  String get weekday => throw _privateConstructorUsedError;
  String get shortWeekday => throw _privateConstructorUsedError;
  String get fullWeekday => throw _privateConstructorUsedError;
  bool get isSelected => throw _privateConstructorUsedError;

  /// Serializes this DateInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DateInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DateInfoCopyWith<DateInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DateInfoCopyWith<$Res> {
  factory $DateInfoCopyWith(DateInfo value, $Res Function(DateInfo) then) =
      _$DateInfoCopyWithImpl<$Res, DateInfo>;
  @useResult
  $Res call({
    DateTime date,
    String weekday,
    String shortWeekday,
    String fullWeekday,
    bool isSelected,
  });
}

/// @nodoc
class _$DateInfoCopyWithImpl<$Res, $Val extends DateInfo>
    implements $DateInfoCopyWith<$Res> {
  _$DateInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DateInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? weekday = null,
    Object? shortWeekday = null,
    Object? fullWeekday = null,
    Object? isSelected = null,
  }) {
    return _then(
      _value.copyWith(
            date:
                null == date
                    ? _value.date
                    : date // ignore: cast_nullable_to_non_nullable
                        as DateTime,
            weekday:
                null == weekday
                    ? _value.weekday
                    : weekday // ignore: cast_nullable_to_non_nullable
                        as String,
            shortWeekday:
                null == shortWeekday
                    ? _value.shortWeekday
                    : shortWeekday // ignore: cast_nullable_to_non_nullable
                        as String,
            fullWeekday:
                null == fullWeekday
                    ? _value.fullWeekday
                    : fullWeekday // ignore: cast_nullable_to_non_nullable
                        as String,
            isSelected:
                null == isSelected
                    ? _value.isSelected
                    : isSelected // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DateInfoImplCopyWith<$Res>
    implements $DateInfoCopyWith<$Res> {
  factory _$$DateInfoImplCopyWith(
    _$DateInfoImpl value,
    $Res Function(_$DateInfoImpl) then,
  ) = __$$DateInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DateTime date,
    String weekday,
    String shortWeekday,
    String fullWeekday,
    bool isSelected,
  });
}

/// @nodoc
class __$$DateInfoImplCopyWithImpl<$Res>
    extends _$DateInfoCopyWithImpl<$Res, _$DateInfoImpl>
    implements _$$DateInfoImplCopyWith<$Res> {
  __$$DateInfoImplCopyWithImpl(
    _$DateInfoImpl _value,
    $Res Function(_$DateInfoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DateInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? weekday = null,
    Object? shortWeekday = null,
    Object? fullWeekday = null,
    Object? isSelected = null,
  }) {
    return _then(
      _$DateInfoImpl(
        date:
            null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                    as DateTime,
        weekday:
            null == weekday
                ? _value.weekday
                : weekday // ignore: cast_nullable_to_non_nullable
                    as String,
        shortWeekday:
            null == shortWeekday
                ? _value.shortWeekday
                : shortWeekday // ignore: cast_nullable_to_non_nullable
                    as String,
        fullWeekday:
            null == fullWeekday
                ? _value.fullWeekday
                : fullWeekday // ignore: cast_nullable_to_non_nullable
                    as String,
        isSelected:
            null == isSelected
                ? _value.isSelected
                : isSelected // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DateInfoImpl implements _DateInfo {
  const _$DateInfoImpl({
    required this.date,
    required this.weekday,
    required this.shortWeekday,
    required this.fullWeekday,
    this.isSelected = false,
  });

  factory _$DateInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$DateInfoImplFromJson(json);

  @override
  final DateTime date;
  @override
  final String weekday;
  @override
  final String shortWeekday;
  @override
  final String fullWeekday;
  @override
  @JsonKey()
  final bool isSelected;

  @override
  String toString() {
    return 'DateInfo(date: $date, weekday: $weekday, shortWeekday: $shortWeekday, fullWeekday: $fullWeekday, isSelected: $isSelected)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DateInfoImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.weekday, weekday) || other.weekday == weekday) &&
            (identical(other.shortWeekday, shortWeekday) ||
                other.shortWeekday == shortWeekday) &&
            (identical(other.fullWeekday, fullWeekday) ||
                other.fullWeekday == fullWeekday) &&
            (identical(other.isSelected, isSelected) ||
                other.isSelected == isSelected));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    date,
    weekday,
    shortWeekday,
    fullWeekday,
    isSelected,
  );

  /// Create a copy of DateInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DateInfoImplCopyWith<_$DateInfoImpl> get copyWith =>
      __$$DateInfoImplCopyWithImpl<_$DateInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DateInfoImplToJson(this);
  }
}

abstract class _DateInfo implements DateInfo {
  const factory _DateInfo({
    required final DateTime date,
    required final String weekday,
    required final String shortWeekday,
    required final String fullWeekday,
    final bool isSelected,
  }) = _$DateInfoImpl;

  factory _DateInfo.fromJson(Map<String, dynamic> json) =
      _$DateInfoImpl.fromJson;

  @override
  DateTime get date;
  @override
  String get weekday;
  @override
  String get shortWeekday;
  @override
  String get fullWeekday;
  @override
  bool get isSelected;

  /// Create a copy of DateInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DateInfoImplCopyWith<_$DateInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MiniPlayerData _$MiniPlayerDataFromJson(Map<String, dynamic> json) {
  return _MiniPlayerData.fromJson(json);
}

/// @nodoc
mixin _$MiniPlayerData {
  String get title => throw _privateConstructorUsedError;
  String get duration => throw _privateConstructorUsedError;
  double get progress => throw _privateConstructorUsedError; // 0.0 to 1.0
  bool get isPlaying => throw _privateConstructorUsedError;
  String? get albumArtUrl => throw _privateConstructorUsedError;
  bool get isProcessed => throw _privateConstructorUsedError;

  /// Serializes this MiniPlayerData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MiniPlayerData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MiniPlayerDataCopyWith<MiniPlayerData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MiniPlayerDataCopyWith<$Res> {
  factory $MiniPlayerDataCopyWith(
    MiniPlayerData value,
    $Res Function(MiniPlayerData) then,
  ) = _$MiniPlayerDataCopyWithImpl<$Res, MiniPlayerData>;
  @useResult
  $Res call({
    String title,
    String duration,
    double progress,
    bool isPlaying,
    String? albumArtUrl,
    bool isProcessed,
  });
}

/// @nodoc
class _$MiniPlayerDataCopyWithImpl<$Res, $Val extends MiniPlayerData>
    implements $MiniPlayerDataCopyWith<$Res> {
  _$MiniPlayerDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MiniPlayerData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? duration = null,
    Object? progress = null,
    Object? isPlaying = null,
    Object? albumArtUrl = freezed,
    Object? isProcessed = null,
  }) {
    return _then(
      _value.copyWith(
            title:
                null == title
                    ? _value.title
                    : title // ignore: cast_nullable_to_non_nullable
                        as String,
            duration:
                null == duration
                    ? _value.duration
                    : duration // ignore: cast_nullable_to_non_nullable
                        as String,
            progress:
                null == progress
                    ? _value.progress
                    : progress // ignore: cast_nullable_to_non_nullable
                        as double,
            isPlaying:
                null == isPlaying
                    ? _value.isPlaying
                    : isPlaying // ignore: cast_nullable_to_non_nullable
                        as bool,
            albumArtUrl:
                freezed == albumArtUrl
                    ? _value.albumArtUrl
                    : albumArtUrl // ignore: cast_nullable_to_non_nullable
                        as String?,
            isProcessed:
                null == isProcessed
                    ? _value.isProcessed
                    : isProcessed // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MiniPlayerDataImplCopyWith<$Res>
    implements $MiniPlayerDataCopyWith<$Res> {
  factory _$$MiniPlayerDataImplCopyWith(
    _$MiniPlayerDataImpl value,
    $Res Function(_$MiniPlayerDataImpl) then,
  ) = __$$MiniPlayerDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String title,
    String duration,
    double progress,
    bool isPlaying,
    String? albumArtUrl,
    bool isProcessed,
  });
}

/// @nodoc
class __$$MiniPlayerDataImplCopyWithImpl<$Res>
    extends _$MiniPlayerDataCopyWithImpl<$Res, _$MiniPlayerDataImpl>
    implements _$$MiniPlayerDataImplCopyWith<$Res> {
  __$$MiniPlayerDataImplCopyWithImpl(
    _$MiniPlayerDataImpl _value,
    $Res Function(_$MiniPlayerDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MiniPlayerData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? duration = null,
    Object? progress = null,
    Object? isPlaying = null,
    Object? albumArtUrl = freezed,
    Object? isProcessed = null,
  }) {
    return _then(
      _$MiniPlayerDataImpl(
        title:
            null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String,
        duration:
            null == duration
                ? _value.duration
                : duration // ignore: cast_nullable_to_non_nullable
                    as String,
        progress:
            null == progress
                ? _value.progress
                : progress // ignore: cast_nullable_to_non_nullable
                    as double,
        isPlaying:
            null == isPlaying
                ? _value.isPlaying
                : isPlaying // ignore: cast_nullable_to_non_nullable
                    as bool,
        albumArtUrl:
            freezed == albumArtUrl
                ? _value.albumArtUrl
                : albumArtUrl // ignore: cast_nullable_to_non_nullable
                    as String?,
        isProcessed:
            null == isProcessed
                ? _value.isProcessed
                : isProcessed // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MiniPlayerDataImpl implements _MiniPlayerData {
  const _$MiniPlayerDataImpl({
    required this.title,
    required this.duration,
    required this.progress,
    required this.isPlaying,
    this.albumArtUrl,
    this.isProcessed = false,
  });

  factory _$MiniPlayerDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$MiniPlayerDataImplFromJson(json);

  @override
  final String title;
  @override
  final String duration;
  @override
  final double progress;
  // 0.0 to 1.0
  @override
  final bool isPlaying;
  @override
  final String? albumArtUrl;
  @override
  @JsonKey()
  final bool isProcessed;

  @override
  String toString() {
    return 'MiniPlayerData(title: $title, duration: $duration, progress: $progress, isPlaying: $isPlaying, albumArtUrl: $albumArtUrl, isProcessed: $isProcessed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MiniPlayerDataImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.isPlaying, isPlaying) ||
                other.isPlaying == isPlaying) &&
            (identical(other.albumArtUrl, albumArtUrl) ||
                other.albumArtUrl == albumArtUrl) &&
            (identical(other.isProcessed, isProcessed) ||
                other.isProcessed == isProcessed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    title,
    duration,
    progress,
    isPlaying,
    albumArtUrl,
    isProcessed,
  );

  /// Create a copy of MiniPlayerData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MiniPlayerDataImplCopyWith<_$MiniPlayerDataImpl> get copyWith =>
      __$$MiniPlayerDataImplCopyWithImpl<_$MiniPlayerDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$MiniPlayerDataImplToJson(this);
  }
}

abstract class _MiniPlayerData implements MiniPlayerData {
  const factory _MiniPlayerData({
    required final String title,
    required final String duration,
    required final double progress,
    required final bool isPlaying,
    final String? albumArtUrl,
    final bool isProcessed,
  }) = _$MiniPlayerDataImpl;

  factory _MiniPlayerData.fromJson(Map<String, dynamic> json) =
      _$MiniPlayerDataImpl.fromJson;

  @override
  String get title;
  @override
  String get duration;
  @override
  double get progress; // 0.0 to 1.0
  @override
  bool get isPlaying;
  @override
  String? get albumArtUrl;
  @override
  bool get isProcessed;

  /// Create a copy of MiniPlayerData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MiniPlayerDataImplCopyWith<_$MiniPlayerDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

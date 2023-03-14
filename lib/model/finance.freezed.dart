// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'finance.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Finance _$FinanceFromJson(Map<String, dynamic> json) {
  return _Finance.fromJson(json);
}

/// @nodoc
mixin _$Finance {
  int? get id => throw _privateConstructorUsedError;
  String? get operationNumber => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  String? get date => throw _privateConstructorUsedError;
  double? get sum => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FinanceCopyWith<Finance> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FinanceCopyWith<$Res> {
  factory $FinanceCopyWith(Finance value, $Res Function(Finance) then) =
      _$FinanceCopyWithImpl<$Res, Finance>;
  @useResult
  $Res call(
      {int? id,
      String? operationNumber,
      String? name,
      String? description,
      String? category,
      String? date,
      double? sum});
}

/// @nodoc
class _$FinanceCopyWithImpl<$Res, $Val extends Finance>
    implements $FinanceCopyWith<$Res> {
  _$FinanceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? operationNumber = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? category = freezed,
    Object? date = freezed,
    Object? sum = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      operationNumber: freezed == operationNumber
          ? _value.operationNumber
          : operationNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      sum: freezed == sum
          ? _value.sum
          : sum // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FinanceCopyWith<$Res> implements $FinanceCopyWith<$Res> {
  factory _$$_FinanceCopyWith(
          _$_Finance value, $Res Function(_$_Finance) then) =
      __$$_FinanceCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? operationNumber,
      String? name,
      String? description,
      String? category,
      String? date,
      double? sum});
}

/// @nodoc
class __$$_FinanceCopyWithImpl<$Res>
    extends _$FinanceCopyWithImpl<$Res, _$_Finance>
    implements _$$_FinanceCopyWith<$Res> {
  __$$_FinanceCopyWithImpl(_$_Finance _value, $Res Function(_$_Finance) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? operationNumber = freezed,
    Object? name = freezed,
    Object? description = freezed,
    Object? category = freezed,
    Object? date = freezed,
    Object? sum = freezed,
  }) {
    return _then(_$_Finance(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      operationNumber: freezed == operationNumber
          ? _value.operationNumber
          : operationNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String?,
      sum: freezed == sum
          ? _value.sum
          : sum // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Finance implements _Finance {
  const _$_Finance(
      {this.id,
      this.operationNumber,
      this.name,
      this.description,
      this.category,
      this.date,
      this.sum});

  factory _$_Finance.fromJson(Map<String, dynamic> json) =>
      _$$_FinanceFromJson(json);

  @override
  final int? id;
  @override
  final String? operationNumber;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final String? category;
  @override
  final String? date;
  @override
  final double? sum;

  @override
  String toString() {
    return 'Finance(id: $id, operationNumber: $operationNumber, name: $name, description: $description, category: $category, date: $date, sum: $sum)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Finance &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.operationNumber, operationNumber) ||
                other.operationNumber == operationNumber) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.sum, sum) || other.sum == sum));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, operationNumber, name, description, category, date, sum);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FinanceCopyWith<_$_Finance> get copyWith =>
      __$$_FinanceCopyWithImpl<_$_Finance>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FinanceToJson(
      this,
    );
  }
}

abstract class _Finance implements Finance {
  const factory _Finance(
      {final int? id,
      final String? operationNumber,
      final String? name,
      final String? description,
      final String? category,
      final String? date,
      final double? sum}) = _$_Finance;

  factory _Finance.fromJson(Map<String, dynamic> json) = _$_Finance.fromJson;

  @override
  int? get id;
  @override
  String? get operationNumber;
  @override
  String? get name;
  @override
  String? get description;
  @override
  String? get category;
  @override
  String? get date;
  @override
  double? get sum;
  @override
  @JsonKey(ignore: true)
  _$$_FinanceCopyWith<_$_Finance> get copyWith =>
      throw _privateConstructorUsedError;
}

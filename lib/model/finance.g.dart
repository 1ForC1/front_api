// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Finance _$$_FinanceFromJson(Map<String, dynamic> json) => _$_Finance(
      id: json['id'] as int?,
      operationNumber: json['operationNumber'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      category: json['category'] as String?,
      date: json['date'] as String?,
      sum: (json['sum'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$_FinanceToJson(_$_Finance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'operationNumber': instance.operationNumber,
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'date': instance.date,
      'sum': instance.sum,
    };

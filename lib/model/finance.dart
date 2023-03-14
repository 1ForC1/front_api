import 'package:freezed_annotation/freezed_annotation.dart';

part 'finance.freezed.dart';
part 'finance.g.dart';

@freezed
class Finance with _$Finance {
  const factory Finance({
    int? id,
    String? operationNumber,
    String? name,
    String? description,
    String? category,
    String? date,
    double? sum,
  }) = _Finance;

  factory Finance.fromJson(Map<String, dynamic> json) => _$FinanceFromJson(json);
}

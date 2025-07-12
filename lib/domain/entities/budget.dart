import 'package:equatable/equatable.dart';

class Budget extends Equatable {
  final int? budgetId;
  final int bCategoryId;
  final double budgetAmount;
  final DateTime budgetMonth;

  const Budget({
    this.budgetId,
    required this.bCategoryId,
    required this.budgetAmount,
    required this.budgetMonth,
  });

  Budget copyWith({
    int? budgetId,
    int? bCategoryId,
    double? budgetAmount,
    DateTime? budgetMonth,
  }) {
    return Budget(
      budgetId: budgetId ?? this.budgetId,
      bCategoryId: bCategoryId ?? this.bCategoryId,
      budgetAmount: budgetAmount ?? this.budgetAmount,
      budgetMonth: budgetMonth ?? this.budgetMonth,
    );
  }

  @override
List<Object?> get props => [budgetId, bCategoryId, budgetAmount, budgetMonth];
}

import 'package:the_app/domain/entities/budget.dart';

class BudgetModel {
  final int? mBudgetId;
  final int mBudgetCategoryId;
  final double mBudgetAmount;
  final String mBudgetMonth;

  BudgetModel({
    this.mBudgetId,
    required this.mBudgetCategoryId,
    required this.mBudgetAmount,
    required this.mBudgetMonth,
  });

  //function to add model to database
  Map<String, dynamic> toMap() {
    return {
      if (mBudgetId != null) 'budgetId': mBudgetId,
      'bCategoryId': mBudgetCategoryId,
      'budgetAmount': mBudgetAmount,
      'budgetMonth': mBudgetMonth,
    };
  }

  //retrieve budget from database to a model
  factory BudgetModel.fromMap(Map<String, dynamic> map) {
    return BudgetModel(
      mBudgetId: map['budgetId'],
      mBudgetCategoryId: map['bCategoryId'],
      mBudgetAmount: map['budgetAmount'],
      mBudgetMonth: map['budgetMonth'],
    );
  }

  //convert model to an entity
  Budget toEntity() {
    return Budget(
      budgetId: mBudgetId,
      bCategoryId: mBudgetCategoryId,
      budgetAmount: mBudgetAmount,
      budgetMonth: DateTime.parse(mBudgetMonth),
    );
  }

  //convert an entity to a model
  factory BudgetModel.fromEntity(Budget budget) {
    return BudgetModel(
      mBudgetId: budget.budgetId,
      mBudgetCategoryId: budget.bCategoryId,
      mBudgetAmount: budget.budgetAmount,
      mBudgetMonth: budget.budgetMonth.toIso8601String(),
    );
  }

  // the classic one for update
  BudgetModel copyWith({
    int? mBudgetId,
    int? mBudgetCategoryId,
    double? mBudgetAmount,
    String? mBudgetMonth,
  }) {
    return BudgetModel(
      mBudgetId: mBudgetId ?? this.mBudgetId,
      mBudgetCategoryId: mBudgetCategoryId ?? this.mBudgetCategoryId,
      mBudgetAmount: mBudgetAmount ?? this.mBudgetAmount,
      mBudgetMonth: mBudgetMonth ?? this.mBudgetMonth,
    );
  }
}

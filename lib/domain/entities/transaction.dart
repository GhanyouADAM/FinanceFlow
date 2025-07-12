import 'package:equatable/equatable.dart';

enum TransactionType { expense, income }

class TransactionEntity extends Equatable{
  final int? transactionId;
  final int tCategoryId;
  final int accountId; // <-- Ajout de la clé étrangère
  final double transactionAmount;
  final DateTime transactionDate;
  final String? note;

  const TransactionEntity({
    this.transactionId,
    required this.tCategoryId,
    required this.accountId,
    required this.transactionAmount,
    required this.transactionDate,
    this.note,
  });

  TransactionEntity copyWith({
    int? transactionId,
    int? tCategoryId,
    int? accountId,
    double? transactionAmount,
    DateTime? transactionDate,
    String? note,
  }) {
    return TransactionEntity(
      transactionId: transactionId ?? this.transactionId,
      tCategoryId: tCategoryId ?? this.tCategoryId,
      accountId: accountId ?? this.accountId,
      transactionAmount: transactionAmount ?? this.transactionAmount,
      transactionDate: transactionDate ?? this.transactionDate,
      note: note ?? this.note,
    );
  }

  @override
  List<Object?> get props => [transactionId, tCategoryId, accountId, transactionAmount, transactionDate, note];
}

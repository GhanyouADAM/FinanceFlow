import 'dart:core';

import 'package:the_app/domain/entities/transaction.dart';

class TransactionModel {
  final int? mTransactionId;
  final int mTransactionCategoryId;
  final int mAccountId; // <-- Ajout de la clé étrangère
  final double mTransactionAmount;
  final String mTransactionDate;
  final String? mNote;

  TransactionModel({
    this.mTransactionId,
    required this.mTransactionCategoryId,
    required this.mAccountId,
    required this.mTransactionAmount,
    required this.mTransactionDate,
    this.mNote,
  });

  //convert model to map for database
  Map<String, dynamic> toMap() {
    return {
      if (mTransactionId != null) 'transactionId': mTransactionId,
      'tCategoryId': mTransactionCategoryId,
      'accountId': mAccountId,
      'transactionAmount': mTransactionAmount,
      'transactionDate': mTransactionDate,
      'note': mNote,
    };
  }

  //convert back a Map from database to a model
  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      mTransactionId: map['transactionId'],
      mTransactionCategoryId: map['tCategoryId'],
      mAccountId: map['accountId'],
      mTransactionAmount: map['transactionAmount'],
      mTransactionDate: map['transactionDate'] as String,
      mNote: map['note'] as String?,
    );
  }

  //convert a model to an Entity
  TransactionEntity toEntity() {
    return TransactionEntity(
      transactionId: mTransactionId,
      tCategoryId: mTransactionCategoryId,
      accountId: mAccountId,
      transactionAmount: mTransactionAmount,
      transactionDate: DateTime.parse(mTransactionDate),
      note: mNote,
    );
  }

  //convert an entity to a model
  factory TransactionModel.fromEntity(TransactionEntity transaction) {
    return TransactionModel(
      mTransactionId: transaction.transactionId,
      mTransactionCategoryId: transaction.tCategoryId,
      mAccountId: transaction.accountId, // <-- Prise en compte de la clé étrangère
      mTransactionAmount: transaction.transactionAmount,
      mTransactionDate: transaction.transactionDate.toIso8601String(),
      mNote: transaction.note,
    );
  }

  TransactionModel copyWith({
    int? mTransactionId,
    int? mTransactionAccountId,
    int? mTransactionCategoryId,
    String? mTransactionType,
    double? mTransactionAmount,
    String? mTransactionDate,
    String? mNote,
  }) {
    return TransactionModel(
      mTransactionId: mTransactionId ?? this.mTransactionId,
      mTransactionCategoryId:
          mTransactionCategoryId ?? this.mTransactionCategoryId,
      mAccountId: mTransactionAccountId ?? mAccountId, // <-- Ajout du copyWith pour la clé étrangère
      mTransactionAmount: mTransactionAmount ?? this.mTransactionAmount,
      mTransactionDate: mTransactionDate ?? this.mTransactionDate,
      mNote: mNote ?? this.mNote,
    );
  }
}

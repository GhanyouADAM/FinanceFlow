import 'package:the_app/domain/entities/account.dart';

class AccountModel {
  final int? mAccountId;
  final String mAccountName;
  final double mAccountAmount;

  AccountModel({
    this.mAccountId,
    required this.mAccountName,
    required this.mAccountAmount,
  });

  AccountModel copyWith({
    int? mAccountId,
    String? mAccountName,
    double? mAccountAmount,
  }) {
    return AccountModel(
      mAccountId: mAccountId ?? this.mAccountId,
      mAccountName: mAccountName ?? this.mAccountName,
      mAccountAmount: mAccountAmount ?? this.mAccountAmount,
    );
  }

  //to add an account into the database
  Map<String, dynamic> toMap() {
    return {
      if (mAccountId != null) 'accountId': mAccountId,
      'accountName': mAccountName,
      'accountAmount': mAccountAmount,
    };
  }

  //to retrieve data from database
  factory AccountModel.fromMap(Map<String, dynamic> map) {
    return AccountModel(
      mAccountId: map['accountId'],
      mAccountName: map['accountName'] as String,
      mAccountAmount: map['accountAmount'],
    );
  }

  //transform the model into an entity
  Account toAccount() {
    return Account(
      accountId: mAccountId,
      name: mAccountName,
      amount: mAccountAmount,
    );
  }

  //transform an entity into a model
  factory AccountModel.fromEntity(Account account) {
    return AccountModel(
      mAccountId: account.accountId,
      mAccountName: account.name,
      mAccountAmount: account.amount,
    );
  }
}

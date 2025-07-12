

import 'package:equatable/equatable.dart';

class Account  extends Equatable{
  final int? accountId;
  final String name;
  final double amount;

  const Account({this.accountId, required this.name, this.amount = 0});

  Account copyWith({int? accountId, String? name, double? amount}) {
    return Account(
      accountId: accountId ?? this.accountId,
      name: name ?? this.name,
      amount: amount ?? this.amount,
    );
  }

  @override
 List<Object?> get props => [accountId, name, amount];
}

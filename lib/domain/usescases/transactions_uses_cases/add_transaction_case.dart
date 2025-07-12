
import 'package:the_app/domain/entities/transaction.dart';
import 'package:the_app/domain/repositories/transactions_repository.dart';

class AddTransactionCase {
  final TransactionsRepository _transactionsRepository;

  AddTransactionCase(this._transactionsRepository);

  Future<void> call(TransactionEntity transaction) async =>
      await _transactionsRepository.addTransaction(transaction);
}

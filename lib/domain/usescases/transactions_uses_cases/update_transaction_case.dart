
import 'package:the_app/domain/entities/transaction.dart';
import 'package:the_app/domain/repositories/transactions_repository.dart';

class UpdateTransactionCase {
  final TransactionsRepository _transactionsRepository;

  UpdateTransactionCase(this._transactionsRepository);

  Future<void> call(TransactionEntity transaction) async =>
      await _transactionsRepository.updateTransaction(transaction);
}

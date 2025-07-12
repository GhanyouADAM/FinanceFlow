
import 'package:the_app/domain/entities/transaction.dart';
import 'package:the_app/domain/repositories/transactions_repository.dart';

class GetTransactionsCase {
  final TransactionsRepository _transactionsRepository;

  GetTransactionsCase(this._transactionsRepository);

  Future<List<TransactionEntity>> call() async =>
      await _transactionsRepository.getTransactions();
}

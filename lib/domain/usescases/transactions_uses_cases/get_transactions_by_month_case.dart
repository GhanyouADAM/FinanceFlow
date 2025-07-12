
import 'package:the_app/domain/entities/transaction.dart';
import 'package:the_app/domain/repositories/transactions_repository.dart';

class GetTransactionsByMonthCase {
  final TransactionsRepository _transactionsRepository;

  GetTransactionsByMonthCase(this._transactionsRepository);

  Future<List<TransactionEntity>> call(DateTime date) async =>
      await _transactionsRepository.getTransactionsByMonth(date);
}

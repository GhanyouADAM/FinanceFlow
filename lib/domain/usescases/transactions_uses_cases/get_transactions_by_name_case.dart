
import 'package:the_app/domain/entities/transaction.dart';
import 'package:the_app/domain/repositories/transactions_repository.dart';

class GetTransactionsbyName {
  final TransactionsRepository _transactionsRepository;

  GetTransactionsbyName(this._transactionsRepository);

  Future<List<TransactionEntity>> call(String name) async =>
      await _transactionsRepository.getTransactionByName(name);
}

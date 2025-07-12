
import 'package:the_app/domain/entities/transaction.dart';

import 'package:the_app/domain/repositories/transactions_repository.dart';

class GetTransactionByCategory {
  final TransactionsRepository _transactionsRepository;

  GetTransactionByCategory(this._transactionsRepository);

  Future<List<TransactionEntity>> call( int categoryId) async =>
      await _transactionsRepository.getTransactionsByCategory(
        categoryId,
      );
}

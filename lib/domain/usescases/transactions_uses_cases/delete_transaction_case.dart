import 'package:the_app/domain/repositories/transactions_repository.dart';

class DeleteTransactionCase {
  final TransactionsRepository _transactionsRepository;

  DeleteTransactionCase(this._transactionsRepository);

  Future<void> call(int id) async =>
      await _transactionsRepository.deleteTransaction(id);
}

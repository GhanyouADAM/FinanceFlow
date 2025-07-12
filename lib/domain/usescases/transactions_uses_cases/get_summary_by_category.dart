import 'package:the_app/domain/repositories/transactions_repository.dart';

class GetSummaryByCategory {
  final TransactionsRepository _transactionsRepository;
  GetSummaryByCategory(this._transactionsRepository);
  
  Future<Map<String, double>> call(int accountID) async => await _transactionsRepository.getSummaryByCategory(accountID);
}
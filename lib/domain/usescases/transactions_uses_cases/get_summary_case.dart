
import 'package:the_app/domain/repositories/transactions_repository.dart';

class GetSummaryCase {
  final TransactionsRepository _transactionsRepository;
 GetSummaryCase(this._transactionsRepository);

 Future<Map<String, double>> call(int accountID) async => await _transactionsRepository.getSummary(accountID);
}
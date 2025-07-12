
import 'package:the_app/domain/entities/transaction.dart';


abstract class TransactionsRepository {
  Future<List<TransactionEntity>> getTransactions();

  Future<List<TransactionEntity>> getTransactionsByCategory(
    int categoryId,
  );

  Future<List<TransactionEntity>> getTransactionsByMonth(
    DateTime date,
  );

Future<Map<String, double>> getSummary(int accountID);
Future<Map<String, double>> getSummaryByCategory(int accountID);


  Future<List<TransactionEntity>> getTransactionByName(String name);

  Future<void> addTransaction(TransactionEntity transaction);

  Future<void> updateTransaction(TransactionEntity transaction);

  Future<void> deleteTransaction(int id);
}

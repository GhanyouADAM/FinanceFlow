
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_app/domain/usescases/transactions_uses_cases/add_transaction_case.dart';
import 'package:the_app/domain/usescases/transactions_uses_cases/delete_transaction_case.dart';
import 'package:the_app/domain/usescases/transactions_uses_cases/get_summary_by_category.dart';
import 'package:the_app/domain/usescases/transactions_uses_cases/get_summary_case.dart';
import 'package:the_app/domain/usescases/transactions_uses_cases/get_transactions_by_category.dart';
import 'package:the_app/domain/usescases/transactions_uses_cases/get_transactions_by_month_case.dart';
import 'package:the_app/domain/usescases/transactions_uses_cases/get_transactions_by_name_case.dart';
import 'package:the_app/domain/usescases/transactions_uses_cases/get_transactions_case.dart';
import 'package:the_app/domain/usescases/transactions_uses_cases/update_transaction_case.dart';
import 'package:the_app/presentation/providers/transaction/transaction_provider.dart';

final addTransactionCaseProvider = Provider<AddTransactionCase>((ref){
  final repository = ref.watch(transactionRepositoryProvider);
  return AddTransactionCase(repository);
});

final updateTransactionCaseProvider =Provider<UpdateTransactionCase>((ref){
  final repository = ref.watch(transactionRepositoryProvider);
  return UpdateTransactionCase(repository);
});

// final getSummaryCaseProvider = Provider<GetSummaryCase>((ref){
//   final repository = ref.watch(transactionRepositoryProvider);
//   return GetSummaryCase(repository);
// });

final getTransactionsCaseProvider= Provider<GetTransactionsCase>((ref){
  final repository = ref.watch(transactionRepositoryProvider);
  return GetTransactionsCase(repository);
});

final deleteTransactionCaseProvider = Provider<DeleteTransactionCase>((ref){
  final repository = ref.watch(transactionRepositoryProvider);
  return DeleteTransactionCase(repository);
});

final getTransactionsByCategoryCaseProvider = Provider<GetTransactionByCategory>((ref){
  final repository = ref.watch(transactionRepositoryProvider);
  return GetTransactionByCategory(repository);
});

final getTransactionsByMonthCaseProvider = Provider<GetTransactionsByMonthCase>((ref){
  final repository = ref.watch(transactionRepositoryProvider);
  return GetTransactionsByMonthCase(repository);
});

final getTransactionsByNameCaseProvider = Provider<GetTransactionsbyName>((ref){
  final repository = ref.watch(transactionRepositoryProvider);
  return GetTransactionsbyName(repository);
});

final getSummaryCaseProvider = Provider<GetSummaryCase>((ref){
  final repository = ref.watch(transactionRepositoryProvider);
  return GetSummaryCase(repository);
});

final getSummaryByCategoryCaseProvider = Provider<GetSummaryByCategory>((ref){
  final repository = ref.watch(transactionRepositoryProvider);
  return GetSummaryByCategory(repository);
});

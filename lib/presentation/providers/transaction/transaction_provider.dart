
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_app/core/provider/db_provider.dart';
import 'package:the_app/data/repositories/transaction_repository_impl.dart';
import 'package:the_app/domain/entities/category.dart';
import 'package:the_app/domain/entities/transaction.dart';
import 'package:the_app/domain/repositories/transactions_repository.dart';
import 'package:the_app/presentation/providers/category/usecases/category_usecases_provider.dart';
import 'package:the_app/presentation/providers/transaction/usecases/transaction_usecases_provider.dart';
import 'package:the_app/presentation/viewmodels/transaction_viewmodel.dart';

import '../../../core/provider/account_provider.dart';

final transactionRepositoryProvider = Provider<TransactionsRepository>((ref){
  final source = ref.watch(localSourceProvider);
  return TransactionRepositoryImpl(source);
});
final transactionTypeProvider = StateProvider<TransactionType>((ref){
  return TransactionType.expense;
});
final categoryIdProvider = Provider<int?>((ref){
  return null;
});
final selectedDateProvider = StateProvider<DateTime?>((ref)=>null);
final transactionItemCategoryLoaderProvider = FutureProvider.family.autoDispose<TransactionCategory?, int>((ref, id)async{
 final loader = ref.watch(getCategoryByIdCaseProvider);
  return await loader.call(id);
});
final categoryGridItemProvider = FutureProvider<List<TransactionCategory>>((ref)async{
  final loader = ref.watch(getCategoriesByTypeCaseProvider);
  final account = ref.watch(currentAccountProvider);
  final type = ref.watch(transactionTypeProvider);
  return await loader.call(type, accountId:account?.accountId);
});

final categoryLoaderProvider = Provider.family.autoDispose<TransactionCategory?, int>((ref, id){
  final asynCategory = ref.watch(transactionItemCategoryLoaderProvider(id));
  return asynCategory.when(
    data: (category)=> category,
     error: (_, _)=> null,
      loading: ()=>null);
});

final transactionCategoryProvider = StateProvider<TransactionCategory?>((ref)=> null);
final transactionViewModelProvider = StateNotifierProvider<TransactionViewModel,AsyncValue<List<TransactionEntity>>>((ref){
  final addTransactionCase = ref.watch(addTransactionCaseProvider);
  final updateTransactionCase = ref.watch(updateTransactionCaseProvider);
  final deleteTransactionCase =  ref.watch(deleteTransactionCaseProvider);
  final getTransactionsCase = ref.watch(getTransactionsCaseProvider);
  final getTransactionsByCategoryCase = ref.watch(getTransactionsByCategoryCaseProvider);
  final getTransactionsByMonthCase = ref.watch(getTransactionsByMonthCaseProvider);
  final getTransactionsByNameCase =  ref.watch(getTransactionsByNameCaseProvider);
  

  return TransactionViewModel(addTransactionCase, updateTransactionCase, deleteTransactionCase, getTransactionsCase, getTransactionsByCategoryCase, getTransactionsByNameCase, getTransactionsByMonthCase);
});
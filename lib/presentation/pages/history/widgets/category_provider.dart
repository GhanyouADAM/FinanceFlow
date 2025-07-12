
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_app/domain/entities/category.dart';
import 'package:the_app/domain/entities/transaction.dart';
import 'package:the_app/presentation/providers/category/usecases/category_usecases_provider.dart';
import 'package:the_app/presentation/providers/transaction/usecases/transaction_usecases_provider.dart';

enum TransactionsLoadingType{
  toutes,
  depense,
  revenu
}
final transactionsLoadingTypeProvider = StateProvider<TransactionsLoadingType?>((ref)=>TransactionsLoadingType.toutes );
 final selectedCategoryProvider = StateProvider<TransactionCategory?>((ref)=>null);

final searchTermProvider = StateProvider<String?>((ref)=>null);
final categoryProvider = FutureProvider<List<TransactionCategory>>((ref)async{
  final loader = ref.watch(getCategoriesCaseProvider);

  return await loader.call();
});

final transactionsProvider = FutureProvider<List<TransactionEntity>>((ref) async{
 final query = ref.watch(searchTermProvider);
 final getTransactionsCase = ref.watch(getTransactionsCaseProvider);
 final getTransactionsByCategoryCase = ref.watch(getTransactionsByCategoryCaseProvider);
   final getTransactionsByNameCase = ref.watch(getTransactionsByNameCaseProvider);
   final category = ref.watch(selectedCategoryProvider);
   List<TransactionEntity> transactions = [];
    if (query != null && query.isNotEmpty) {
      transactions = await getTransactionsByNameCase.call(query);
    }else if(category != null && category.categoryId != null){
      transactions = await getTransactionsByCategoryCase.call(category.categoryId!);
 }else{
      transactions = await getTransactionsCase.call();
    }
  return transactions;
});
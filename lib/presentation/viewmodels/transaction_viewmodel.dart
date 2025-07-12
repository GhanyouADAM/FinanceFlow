
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_app/domain/entities/transaction.dart';
import 'package:the_app/domain/usescases/transactions_uses_cases/add_transaction_case.dart';
import 'package:the_app/domain/usescases/transactions_uses_cases/delete_transaction_case.dart';
import 'package:the_app/domain/usescases/transactions_uses_cases/get_transactions_by_category.dart';
import 'package:the_app/domain/usescases/transactions_uses_cases/get_transactions_by_month_case.dart';
import 'package:the_app/domain/usescases/transactions_uses_cases/get_transactions_by_name_case.dart';
import 'package:the_app/domain/usescases/transactions_uses_cases/get_transactions_case.dart';
import 'package:the_app/domain/usescases/transactions_uses_cases/update_transaction_case.dart';

class TransactionViewModel extends StateNotifier<AsyncValue<List<TransactionEntity>>>{
  final AddTransactionCase addTransactionCase;
  final UpdateTransactionCase updateTransactionCase;
  final DeleteTransactionCase deleteTransactionCase;
  final GetTransactionsCase getTransactionsCase;
  final GetTransactionByCategory getTransactionByCategory;
  final GetTransactionsbyName getTransactionsbyName;
  final GetTransactionsByMonthCase getTransactionsByMonthCase;

  TransactionViewModel(this.addTransactionCase, this.updateTransactionCase, this.deleteTransactionCase, this.getTransactionsCase, this.getTransactionByCategory, this.getTransactionsbyName, this.getTransactionsByMonthCase) : super(const AsyncValue.loading()){
    _loadTransactions();
  }


  Future<void> _loadTransactions() async{
    state = AsyncValue.loading();
    try{
      final transactions = await getTransactionsCase();
      state = AsyncValue.data(transactions);
    }catch(e, s){
        state = AsyncValue.error(e, s);
    }
  }

  Future<void> addTransaction(TransactionEntity transaction) async {
    state = AsyncValue.loading();
    try{
      await addTransactionCase(transaction);
      _loadTransactions();
    }catch(e, s){
        state = AsyncValue.error(e, s);
    }
  }

  Future<void> updateTransaction(TransactionEntity transaction) async {
    state = AsyncValue.loading();
    try{
      await updateTransactionCase(transaction);
      _loadTransactions();
    }catch(e, s){
        state = AsyncValue.error(e, s);
    }
  }

  Future<void> deleteTransaction(int id) async {
   
    if(state.value != null){
      state = AsyncValue.data(state.value!.where((transaction)=> transaction.transactionId != id).toList());
    }else{
       state = AsyncValue.loading();
    }
    try{
      await deleteTransactionCase(id);
      _loadTransactions();
    }catch(e, s){
        state = AsyncValue.error(e, s);
    }
  }

}
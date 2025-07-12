

import 'package:the_app/data/datasource/database_helper.dart';
import 'package:the_app/data/models/transaction_model.dart';
import 'package:the_app/domain/entities/transaction.dart';
import 'package:the_app/domain/repositories/transactions_repository.dart';

class TransactionRepositoryImpl implements TransactionsRepository{
  final DatabaseHelper _source;
  TransactionRepositoryImpl(this._source);

  @override
  Future<void> addTransaction(TransactionEntity transaction) async{
    final model = TransactionModel.fromEntity(transaction);
    await _source.addTransaction(model);
  }

  @override
  Future<void> deleteTransaction(int id) async {
    await _source.deleteTransaction(id);
  }

  @override
  Future<List<TransactionEntity>> getTransactionByName(String name,) async {
    final models = await _source.getTransactionByName( name);
    return models.map((model)=> model.toEntity()).toList();
  }

  @override
  Future<List<TransactionEntity>> getTransactions() async {
   final models = await _source.getTransactions();
   return  models.map((model)=> model.toEntity()).toList();
  }

  @override
  Future<List<TransactionEntity>> getTransactionsByCategory( int categoryId) async {
    final models = await _source.getTransactionsByCategory( categoryId);
    return  models.map((model)=> model.toEntity()).toList();
  }

  @override
  Future<List<TransactionEntity>> getTransactionsByMonth(DateTime date) async{
    final year = date.year;
    final month =  date.month;
    final models = await _source.getTransactionByMonth( year, month);
    return  models.map((model)=> model.toEntity()).toList();
  }

  @override
  Future<void> updateTransaction(TransactionEntity transaction) async {
   final model = TransactionModel.fromEntity(transaction);
   await _source.updateTransaction(model);
  }
  
  @override
  Future<Map<String, double>> getSummary(int accountID) async {
    return await _source.getSummary(accountID);
  }
  
  @override
  Future<Map<String, double>> getSummaryByCategory(int accountID) async {
   return await _source.getSummaryByCategory(accountID);
  }
 

}
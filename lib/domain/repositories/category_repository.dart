import 'package:the_app/domain/entities/category.dart';
import 'package:the_app/domain/entities/transaction.dart';

abstract class CategoryRepository {
  Future<List<TransactionCategory>> getCategories({int? accountId});
  Future<List<TransactionCategory>> getCategoriesByType(TransactionType type, {int? accountId});
  Future<TransactionCategory?> getCategoryById(int id);
  Future<void> addCategory(TransactionCategory category);
    Future<void> updateCategory(TransactionCategory category);
  Future<void> deleteCategory(int id);
}
import 'package:the_app/data/datasource/database_helper.dart';
import 'package:the_app/data/models/category_model.dart';
import 'package:the_app/domain/entities/category.dart';
import 'package:the_app/domain/entities/transaction.dart';
import 'package:the_app/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository{
  final DatabaseHelper _source;
  CategoryRepositoryImpl(this._source);
  @override
  Future<void> addCategory(TransactionCategory category) async {
    final model = CategoryModel.fromEntity(category);
    await _source.addCategory(model);
  }

  @override
  Future<void> deleteCategory(int id) async {
   await _source.deleteCategory(id);
  }

  @override
  Future<List<TransactionCategory>> getCategories({int? accountId}) async {
   final models = await _source.getCategories(accountId: accountId);
   final categories = models.map((model)=> model.toEntity()).toList();
   return categories;
  }

  @override
  Future<TransactionCategory?> getCategoryById(int id) async {
    final model = await _source.getCategoryById(id);
    return model?.toEntity();
  }

  @override
  Future<List<TransactionCategory>> getCategoriesByType(TransactionType type, {int? accountId}) async {
    final theType = type.name;
    final models = await _source.getCategoriesByType(theType, accountId: accountId);
    return models.map((model) => model.toEntity()).toList();
  }
  
  @override
  Future<void> updateCategory(TransactionCategory category) async{
    final categoryModel = CategoryModel.fromEntity(category);
    await _source.updateCategory(categoryModel);
  }

}
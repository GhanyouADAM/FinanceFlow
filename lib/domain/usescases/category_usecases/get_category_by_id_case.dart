

import 'package:the_app/domain/entities/category.dart';
import 'package:the_app/domain/repositories/category_repository.dart';

class GetCategoryByIdCase {
  final CategoryRepository _categoryRepository;
  GetCategoryByIdCase(this._categoryRepository);
  Future<TransactionCategory?> call(int id) async => await _categoryRepository.getCategoryById(id);
}
import 'package:the_app/domain/entities/category.dart';
import 'package:the_app/domain/repositories/category_repository.dart';

class AddCategoryCase {
  final CategoryRepository _categoryRepository;

  AddCategoryCase(this._categoryRepository);

  Future<void> call(TransactionCategory category) async =>
      await _categoryRepository.addCategory(category);
}

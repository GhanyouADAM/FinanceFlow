import 'package:the_app/domain/repositories/category_repository.dart';

class DeleteCategoryCase {
  final CategoryRepository _categoryRepository;

  DeleteCategoryCase(this._categoryRepository);

  Future<void> call(int id) async =>
      await _categoryRepository.deleteCategory(id);
}

import 'package:the_app/domain/entities/category.dart';
import 'package:the_app/domain/repositories/category_repository.dart';

class UpdateCategoryCase {
  final CategoryRepository categoryRepository;
  UpdateCategoryCase(this.categoryRepository);

  Future<void> call(TransactionCategory category) async => categoryRepository.updateCategory(category);
}
import 'package:the_app/domain/entities/category.dart';
import 'package:the_app/domain/repositories/category_repository.dart';

class GetCategoriesCase {
  final CategoryRepository _categoryRepository;

  GetCategoriesCase(this._categoryRepository);

  Future<List<TransactionCategory>> call({int? accountId}) async =>
      await _categoryRepository.getCategories(accountId: accountId);
}

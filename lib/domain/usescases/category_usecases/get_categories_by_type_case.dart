import 'package:the_app/domain/entities/category.dart';
import 'package:the_app/domain/entities/transaction.dart';
import 'package:the_app/domain/repositories/category_repository.dart';

class GetCategoriesByTypeCase {
  CategoryRepository  categoryRepository;

  GetCategoriesByTypeCase(this.categoryRepository);

  Future<List<TransactionCategory>> call(TransactionType type, {int? accountId}) async {
    return await categoryRepository.getCategoriesByType(type, accountId: accountId);
  }
}
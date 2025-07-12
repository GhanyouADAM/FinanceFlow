
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:the_app/domain/usescases/category_usecases/add_category_case.dart';
import 'package:the_app/domain/usescases/category_usecases/delete_category_case.dart';
import 'package:the_app/domain/usescases/category_usecases/get_categories_by_type_case.dart';
import 'package:the_app/domain/usescases/category_usecases/get_categories_case.dart';
import 'package:the_app/domain/usescases/category_usecases/get_category_by_id_case.dart';
import 'package:the_app/domain/usescases/category_usecases/update_category_case.dart';
import 'package:the_app/presentation/providers/category/category_provider.dart';

final addCategoryCaseProvider = Provider<AddCategoryCase>((ref){
final repository = ref.watch(categoryRepositoryProvider);
return AddCategoryCase(repository);
});

final getCategoriesByTypeCaseProvider = Provider<GetCategoriesByTypeCase>((ref){
  final repository = ref.watch(categoryRepositoryProvider);
  return GetCategoriesByTypeCase(repository);
});

final deleteCategoryCaseProvider =  Provider<DeleteCategoryCase>((ref){
  final repository = ref.watch(categoryRepositoryProvider);
  return DeleteCategoryCase(repository);
});

final getCategoriesCaseProvider = Provider<GetCategoriesCase>((ref){
  final repository = ref.watch(categoryRepositoryProvider);
  return GetCategoriesCase(repository);
});

final getCategoryByIdCaseProvider = Provider((ref){
  final repository = ref.watch(categoryRepositoryProvider);
  return GetCategoryByIdCase(repository);
});

final updateCategoryCaseProvider = Provider<UpdateCategoryCase>((ref){
  final repository = ref.watch(categoryRepositoryProvider);
  return UpdateCategoryCase(repository);
});
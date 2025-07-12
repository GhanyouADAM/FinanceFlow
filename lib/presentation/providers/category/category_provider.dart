import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_app/core/provider/account_provider.dart';
import 'package:the_app/data/repositories/category_repository_impl.dart';
import 'package:the_app/domain/entities/category.dart';
import 'package:the_app/domain/entities/transaction.dart';
import 'package:the_app/domain/repositories/category_repository.dart';
import 'package:the_app/presentation/providers/category/usecases/category_usecases_provider.dart';

import '../../../core/provider/db_provider.dart';
import '../../viewmodels/category_viewmodel.dart';

enum CategoryFilter {
  all,
  expense,
  income
}

final categoryRepositoryProvider = Provider<CategoryRepository>((ref){
  final source = ref.watch(localSourceProvider);
  return CategoryRepositoryImpl(source);
});
final categoryTypeFIlterProvider = StateProvider<TransactionType>((ref)=> TransactionType.expense);
final selectedCategoryProvider = StateProvider<TransactionCategory?>((ref)=>null);

final categoryIconProvider = StateProvider<IconData?>((ref)=> null );
final categoryTypeProvider =  StateProvider<TransactionType>((ref)=>TransactionType.expense);
final categoryColorProvider = StateProvider<Color?>((ref)=>null);
final wichCategoryToLoadFilter = StateProvider<CategoryFilter>((ref) => CategoryFilter.expense);

final categoryViewModelProvider = StateNotifierProvider<CategoryViewModel, AsyncValue<List<TransactionCategory>>>((ref){
  final addCategoryCase = ref.watch(addCategoryCaseProvider);
  final deleteCategoryCase = ref.watch(deleteCategoryCaseProvider);
  final getCategoriesCase = ref.watch(getCategoriesCaseProvider);
  final getCategoriesByType = ref.watch(getCategoriesByTypeCaseProvider);
  final getCategoryById = ref.watch(getCategoryByIdCaseProvider);
  final account = ref.watch(currentAccountProvider);
  final updateCategoryCase = ref.watch(updateCategoryCaseProvider);
  return CategoryViewModel(addCategoryCase, deleteCategoryCase, getCategoriesCase, getCategoriesByType, getCategoryById, updateCategoryCase, ref, account?.accountId);
});
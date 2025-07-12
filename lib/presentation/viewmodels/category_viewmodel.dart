import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_app/domain/entities/category.dart';
import 'package:the_app/domain/entities/transaction.dart';
import 'package:the_app/domain/usescases/category_usecases/add_category_case.dart';
import 'package:the_app/domain/usescases/category_usecases/delete_category_case.dart';
import 'package:the_app/domain/usescases/category_usecases/get_categories_by_type_case.dart';
import 'package:the_app/domain/usescases/category_usecases/get_categories_case.dart';
import 'package:the_app/domain/usescases/category_usecases/get_category_by_id_case.dart';
import 'package:the_app/domain/usescases/category_usecases/update_category_case.dart';
import 'package:the_app/presentation/providers/category/category_provider.dart';

class CategoryViewModel extends StateNotifier<AsyncValue<List<TransactionCategory>>>{
  final AddCategoryCase addCategoryCase;
  final DeleteCategoryCase deleteCategoryCase;
  final GetCategoriesCase getCategoriesCase;
  final GetCategoriesByTypeCase getCategoriesByTypeCase;
  final GetCategoryByIdCase getCategoryByIdCase;
  final UpdateCategoryCase updateCategoryCase;
  final Ref ref;
  final int? accountId;
  CategoryViewModel(this.addCategoryCase, this.deleteCategoryCase, this.getCategoriesCase, this.getCategoriesByTypeCase, this.getCategoryByIdCase,this.updateCategoryCase ,this.ref, this.accountId): super(const AsyncValue.loading()){
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    state = AsyncValue.loading();
    final loadType = ref.watch(wichCategoryToLoadFilter);
    List<TransactionCategory> categories = [];
    try{
      switch (loadType) {
        case CategoryFilter.expense:
          categories = await getCategoriesByTypeCase(TransactionType.expense, accountId: accountId);
          break;
        case CategoryFilter.income:
          categories = await getCategoriesByTypeCase(TransactionType.income, accountId: accountId);
          break;
        case CategoryFilter.all : 
         categories = await getCategoriesCase(accountId: accountId);
         break;
      }
       state = AsyncValue.data(categories);
    }catch(e, s){
        state = AsyncValue.error(e, s);
    }
  }

  // Future<void> loadCategoriesByType() async {
  //   state  = AsyncValue.loading();
  //   final type = ref.watch(categoryTypeFIlterProvider);
  //   try {
  //     final categories = await getCategoriesByTypeCase(type);
  //     state = AsyncValue.data(categories);
  //   } catch (e, s) {
  //     state = AsyncValue.error(e, s);
  //   }
  // }

  Future<void> addCategory(TransactionCategory category) async {
    state = const AsyncValue.loading();
    try{
      await addCategoryCase(category);
      _loadCategories();
    }catch(e, s){
        state = AsyncValue.error(e, s);
    }
  }

  Future<TransactionCategory?> getCategoryByID(int id) async {
    state = const AsyncValue.loading();
    try{
      final category =await getCategoryByIdCase(id);
      if (category != null) {
        return category;
      }else{
        return  null;
      }
    } catch(e,s){
              state = AsyncValue.error(e, s);
              rethrow;

    }
  }
  Future<void> updateCategory(TransactionCategory category) async {
    state = const AsyncValue.loading();
    
    try {
      await updateCategoryCase(category);
      _loadCategories();
    } catch (e, s) {
      state = AsyncValue.error(e, s);
    }
  }
  Future<void> deleteCategory(int categoryId) async {
    state = const AsyncValue.loading();
    try{
      await deleteCategoryCase(categoryId);
      _loadCategories();
    }catch(e, s){
      state = AsyncValue.error(e, s);
    }
  }

}
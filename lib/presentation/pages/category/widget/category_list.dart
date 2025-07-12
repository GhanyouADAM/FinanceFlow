import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_app/presentation/pages/category/widget/category_item.dart';
import 'package:the_app/presentation/providers/category/category_provider.dart';

class CategoryList extends ConsumerWidget {
  const CategoryList({super.key});
  @override
  Widget build(BuildContext context, ref) {
    final asyncCategories = ref.watch(categoryViewModelProvider);
    return Scaffold(
      body: asyncCategories.when(
        //---------data------
        data: (categories){
          if (categories.isNotEmpty) {
            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index){
        final category = categories[index];
        return CategoryItem(category: category);
    }).animate(key: ValueKey(categories.length)).fadeIn();
          }else{
            return Center(child: Text('Aucune catégorie trouvée'),);
          }
        },

//-----------error---------
         error: (e, s)=> Center(child: Text('oops somthing went wrong : ${e.toString()}'),),
//------------
          loading: ()=> const Center(child: CircularProgressIndicator(),)),
    );
  }
}
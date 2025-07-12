import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:the_app/core/theme/build_extension.dart';
import 'package:the_app/presentation/pages/category/widget/category_list.dart';
import 'package:the_app/presentation/providers/category/category_provider.dart';


class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {

    
    return DefaultTabController(
      length: 2,
       child: Scaffold(
        //-------app bar-------
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('Categories'),
          titleTextStyle: context.textTheme.headlineSmall!.copyWith(
            color: context.colorScheme.onSurface
          ),
          bottom: TabBar(

            onTap: (value) {
              switch (value) {
                case 0:
                  ref.read(wichCategoryToLoadFilter.notifier).state = CategoryFilter.expense;
                case 1 :
                 ref.read(wichCategoryToLoadFilter.notifier).state = CategoryFilter.income;
                default:
              }
            },
            tabs: [
            Tab(text: 'Dépenses',),
            Tab(text: 'Revenus',)
          ]),
        ),

      //-------body-----------
      body: const TabBarView(
        children: [
         CategoryList(),
         CategoryList()

        ]),

        floatingActionButton: FloatingActionButton(
          backgroundColor: context.colorScheme.primary,
          foregroundColor: context.colorScheme.onPrimary,
          onPressed: (){
        context.pushNamed('new_category');
      }, child: Icon(Icons.add),),
       ));
  }
}
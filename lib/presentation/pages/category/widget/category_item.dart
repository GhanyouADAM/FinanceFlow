import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_app/core/theme/build_extension.dart';
import 'package:the_app/domain/entities/category.dart';
import 'package:the_app/presentation/pages/category/edit_category_screen.dart';
import 'package:the_app/presentation/providers/category/category_provider.dart';
import 'package:the_app/presentation/providers/transaction/transaction_provider.dart';

class CategoryItem extends ConsumerWidget {
  const CategoryItem({super.key, required this.category});

final TransactionCategory category;

 void _updateCategory(TransactionCategory categoryItem, BuildContext context){
   showModalBottomSheet(
    isScrollControlled: true,
    useSafeArea: true,
    context: context, builder: (ctx)=> EditCategoryScreen(category: categoryItem, onCancel: (){Navigator.of(ctx).pop();},));
 }

 void _deleteCategory(WidgetRef ref, TransactionCategory categoryItem){
  ref.read(categoryViewModelProvider.notifier).deleteCategoryCase(categoryItem.categoryId!);
  ref.invalidate(categoryViewModelProvider);
 }
  @override
  Widget build(BuildContext context, ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 70,
        width: double.infinity,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                spreadRadius: 0.5,
                color: Colors.grey,
                offset: Offset(0, 2)
              )
            ]
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: category.color.withValues(alpha: 0.3),
              child: Icon(category.icon, color: category.color,)),
            SizedBox(width: 10),
            Text(category.name, style: context.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold
            ),),
            const Spacer(),
            IconButton(onPressed: (){
              _updateCategory(category, context);
            }, icon: Icon(Icons.edit, color: context.colorScheme.primary,)),
            SizedBox(width: 10),
            IconButton(onPressed: (){
             showDialog(context: context, builder: (ctx)=> AlertDialog(
              title: Text('Attention !!!'),

              content: Text('cela supprimera également toutes les transactions liées a cette catégorie'),
              actions: [
                 ElevatedButton(onPressed: (){
                  Navigator.of(ctx).pop();
                  }, child: Text('Annuler', style: TextStyle(color: Colors.red),)),

        //button to confirm deletion
        ElevatedButton(onPressed: (){
          //deletion logic
           _deleteCategory(ref, category);
              ref.invalidate(transactionViewModelProvider);
              Navigator.of(ctx).pop();
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  behavior: SnackBarBehavior.floating,
                backgroundColor: context.colorScheme.error,
                content: Text('Categorie supprimé')));
        }, child:  Text('Confirmer', style: TextStyle(color: Colors.green)))
              ],
             ));
             
            }, icon: Icon(Icons.delete_outline_rounded, color: context.colorScheme.error,)),
          ],
        ),
      ),
    );
  }
}
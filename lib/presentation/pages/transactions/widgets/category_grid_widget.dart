import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_app/domain/entities/category.dart';
import 'package:the_app/presentation/pages/transactions/widgets/category_grid_item_widget.dart';
import 'package:the_app/presentation/providers/transaction/transaction_provider.dart';

class CategoryGridWidget extends ConsumerWidget {
  const CategoryGridWidget({super.key, required this.categories});
  final List<TransactionCategory> categories;
  @override
  Widget build(BuildContext context, ref) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: categories.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 1.5,
        mainAxisSpacing: 3,
        crossAxisSpacing: 3,
        crossAxisCount: 3),
       itemBuilder: (context, index){
        final category = categories[index];
        return InkWell(
          onTap: (){
            ref.read(transactionCategoryProvider.notifier).state = category;
          },
          child: CategoryGridItemWidget(category: category));
       });
  }
}
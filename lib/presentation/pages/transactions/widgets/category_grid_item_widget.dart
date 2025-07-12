import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_app/core/theme/build_extension.dart';
import 'package:the_app/domain/entities/category.dart';
import 'package:the_app/presentation/providers/transaction/transaction_provider.dart';

class CategoryGridItemWidget extends ConsumerWidget {
  const CategoryGridItemWidget({super.key, required this.category});
 final TransactionCategory category;
  @override
  Widget build(BuildContext context, ref) {
    final selectedCategory = ref.watch(transactionCategoryProvider);
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(7),
      height: 170,
      width: 170,
      decoration: BoxDecoration(
        border: Border.all(color: selectedCategory == category ? category.color : Colors.grey.shade400, width: selectedCategory == category ? 2 : 1),
        color: selectedCategory == category ? category.color.withValues(alpha: 0.2) : context.colorScheme.surface,
        borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(child: Icon(category.icon, color: category.color,)),
          Expanded(child: Text(category.name, style: context.textTheme.bodySmall,))
        ],
      ),
    );
  }
}
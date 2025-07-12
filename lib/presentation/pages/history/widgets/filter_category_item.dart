import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_app/domain/entities/category.dart';

class FilterCategoryItem extends ConsumerWidget {
  const FilterCategoryItem({super.key, required this.category});
 final TransactionCategory category;
  @override
  Widget build(BuildContext context, ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      child: Chip(
        avatar: CircleAvatar(backgroundColor: category.color,),
        label: Text(category.name)),
    );
  }
}
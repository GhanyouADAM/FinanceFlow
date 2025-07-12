
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_app/domain/entities/transaction.dart';

class CategorySelection extends ConsumerStatefulWidget {
  const CategorySelection({super.key, required this.currentCategoryTypeSelection, required this.onTypeSelected});
 final TransactionType currentCategoryTypeSelection;
 final ValueChanged<TransactionType> onTypeSelected;
  @override
  ConsumerState<CategorySelection> createState() => _CategorySelectionState();
}

class _CategorySelectionState extends ConsumerState<CategorySelection> {
  @override
  Widget build(BuildContext context) {
    return SegmentedButton<TransactionType>(segments: <ButtonSegment<TransactionType>>[

                ButtonSegment(
                  value: TransactionType.expense,
                  icon: Icon(Icons.arrow_downward_rounded),
                  label: Text('Dépenses')
                  ),

                  ButtonSegment(
                  value: TransactionType.income,
                  icon: Icon(Icons.arrow_upward_rounded),
                  label: Text('Revenus')
                  )
            ], 
            selected: <TransactionType>{widget.currentCategoryTypeSelection},
            onSelectionChanged: (Set<TransactionType> newSelection) {
              widget.onTypeSelected(newSelection.first);
            },
            );
  }
}
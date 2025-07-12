import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:the_app/core/provider/theme_provider.dart';
import 'package:the_app/core/theme/build_extension.dart';
import 'package:the_app/core/utils/async_value_widget.dart';
import 'package:the_app/domain/entities/transaction.dart';
import 'package:the_app/presentation/providers/transaction/transaction_provider.dart';


class TransactionItem extends ConsumerWidget {
  const TransactionItem({super.key, required this.transaction});
  final TransactionEntity transaction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncCategory = ref.watch(transactionItemCategoryLoaderProvider(transaction.tCategoryId));
    final date = transaction.transactionDate;
    final formatttedDate = DateFormat('EEEE MMMM y', 'fr_FR').format(date);
    final currency = ref.watch(currencyTypeProvider);
    return AsyncValueWidget(
      value: asyncCategory,
      data: (category) => Container(
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              spreadRadius: 2,
              color: Colors.grey.shade300,
              offset: Offset(1, 2)
            )
          ]
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: category!.color.withValues(alpha: 0.3),
            child: Icon(category.icon, color: category.color),
          ),
          title: Text(category.name),
          titleTextStyle: context.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(transaction.note ?? ''),
              Text(formatttedDate, style: context.textTheme.bodySmall,),
            
              
            ],
          ),
          trailing: category.type == TransactionType.expense ? Text(' - ${transaction.transactionAmount}${currency.values.first}', style: context.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.error
          ),): Text(' ${transaction.transactionAmount}${currency.values.first}', style: context.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
            color: context.colorScheme.secondary
          ),),
        ),
      ),
      loading: const ListTile(
        leading: CircleAvatar(child: CircularProgressIndicator()),
        title: Text('Chargement...'),
      ),
      error: const ListTile(
        leading: Icon(Icons.error),
        title: Text('Erreur catégorie'),
      ),
    );
  }
}
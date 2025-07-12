import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_app/core/theme/build_extension.dart';
import 'package:the_app/domain/entities/transaction.dart';
import 'package:the_app/presentation/pages/transactions/widgets/transaction_item.dart';
import 'package:the_app/presentation/providers/transaction/transaction_provider.dart';

class TransactionsList extends ConsumerStatefulWidget {
  const TransactionsList({super.key, required this.transactions});
  final List<TransactionEntity> transactions;

  @override
  ConsumerState<TransactionsList> createState() => _TransactionsListState();
}

class _TransactionsListState extends ConsumerState<TransactionsList> {
  bool showAll = false;
  static const int previewCount = 3;

  @override
  Widget build(BuildContext context) {
    final displayed = showAll ? widget.transactions : widget.transactions.take(previewCount).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ...displayed.map((transaction) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Dismissible(
                 direction: DismissDirection.endToStart,
              onDismissed: (direction){
              if (transaction.transactionId != null) {
                ref.read(transactionViewModelProvider.notifier).deleteTransaction(transaction.transactionId!);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: context.colorScheme.primaryContainer,
                  content: Text("Transaction supprimée avec succès", style: TextStyle(
                    color: context.colorScheme.onPrimaryContainer,
                  ),)));
              }
              },
                background: Container(
              decoration: BoxDecoration(
                color: context.colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(8)
              ),
              padding: EdgeInsets.only(right: 20),
              alignment: Alignment.centerRight,

              child: Icon(Icons.delete_sweep_rounded, color: context.colorScheme.onErrorContainer,),
            ),
                key: ValueKey(transaction.transactionId), child: TransactionItem(transaction: transaction)),
            )),
        if (widget.transactions.length > previewCount && !showAll)
          TextButton.icon(
            onPressed: () => setState(() => showAll = true),
            icon: Icon(Icons.expand_more),
            label: Text('Voir toutes les transactions'),
          ),
        if (showAll && widget.transactions.length > previewCount)
          TextButton.icon(
            onPressed: () => setState(() => showAll = false),
            icon: Icon(Icons.expand_less),
            label: Text('Réduire'),
          ),
      ],
    );
  }
}
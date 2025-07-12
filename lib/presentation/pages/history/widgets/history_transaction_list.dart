import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_app/core/theme/build_extension.dart';
import 'package:the_app/domain/entities/transaction.dart';
import 'package:the_app/presentation/pages/transactions/widgets/transaction_item.dart';
import 'package:the_app/presentation/providers/transaction/transaction_provider.dart';

class HistoryTransactionList extends StatelessWidget {
  const HistoryTransactionList({super.key, required this.transactions});
  final List<TransactionEntity> transactions;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index){
      final transaction = transactions[index];
      return Consumer(builder: (context, ref, child){
        return Dismissible(
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
                key: ValueKey(transaction.transactionId), child: TransactionItem(transaction: transaction));
      });
    });
  }
}
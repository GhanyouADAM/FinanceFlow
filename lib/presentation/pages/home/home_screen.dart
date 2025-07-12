import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:the_app/core/provider/summary_provider.dart';
import 'package:the_app/core/theme/build_extension.dart';
import 'package:the_app/core/utils/async_value_widget.dart';
import 'package:the_app/domain/entities/account.dart';
import 'package:the_app/presentation/pages/home/widgets/big_card_resume.dart';
import 'package:the_app/presentation/pages/home/widgets/title_widget.dart';
import 'package:the_app/presentation/pages/transactions/widgets/transactions_list.dart';
import 'package:the_app/presentation/providers/transaction/transaction_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key, required this.currentAccount});
 final Account currentAccount;


  @override
  Widget build(BuildContext context, ref) {
    final transactions = ref.watch(transactionViewModelProvider);
    final summary = ref.watch(summaryAsyncProvider);
    return Scaffold(

      //--------Appbar------
      appBar: AppBar(
        backgroundColor: context.colorScheme.primary,
        title: Text('FinanceFLow'),
        titleTextStyle: context.textTheme.headlineSmall!.copyWith(
          color: context.colorScheme.onPrimary
        ),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search)),
           InkWell(
            onTap: () {
              context.pushNamed('account_details', extra: currentAccount);
            },
            child: CircleAvatar(child: Icon(Icons.person),))
        ],
      ),
      //-------------body----------
  body: SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(3.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //---finance resume card--------
          AsyncValueWidget(
            value: summary ,
             data: (s){
              final income = s['income'] ?? 0;
              final expense = s['expense'] ?? 0;
              return BigCardResume(
                budget: income - expense, // Correction ici : solde dynamique
                incomeBudget: income,
                expenseBudget: expense,
              );
             },
            loading: BigCardResume(budget: 0, incomeBudget: 0, expenseBudget: 0).animate().slideY().fadeIn(),
            error: BigCardResume(budget: 0.404, incomeBudget: 0.404, expenseBudget: 0.404),
             ),
      
          //------transaction----------
        
          TitleWidget(title: 'Transactions récentes'),
          SizedBox(height: 7,),
          transactions.when(
            data: (data){
              if (data.isNotEmpty) {
                return Container(
                          decoration: BoxDecoration(),
                          child: TransactionsList(transactions: data, key: ValueKey(data.length),),
                        );
              } else {
                return Center(child: Text('Aucune transaction'),);
              }
            },
            error: (e, s)=> Center(child: Text(e.toString()),),
            loading: ()=> Center(child: CircularProgressIndicator(),),
          ),
            
          //-----chart section---------
         
          TitleWidget(title: 'Analyses financières'),
          const SizedBox(height: 16,),
          Center(child: Text('Fonctionnalité a venir'),)
        ],
      ),
    ),
  )
    );
  }
}
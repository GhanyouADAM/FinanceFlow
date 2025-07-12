import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:the_app/core/provider/summary_provider.dart';
import 'package:the_app/core/theme/build_extension.dart';
import 'package:the_app/domain/entities/transaction.dart';
import 'package:the_app/presentation/pages/transactions/widgets/category_grid_widget.dart';
import 'package:the_app/presentation/providers/account/account_provider.dart';
import 'package:the_app/presentation/providers/transaction/transaction_provider.dart';
import 'package:the_app/core/provider/account_provider.dart';

import '../../../core/provider/theme_provider.dart';

class AddTransaction extends ConsumerStatefulWidget {
  const AddTransaction({super.key});

  @override
  ConsumerState<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends ConsumerState<AddTransaction> {
  final TextEditingController _amountController = TextEditingController();
    final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }
  void _onValidate({int? categoryId, double? amount, DateTime? date,String? note}){
    final account = ref.read(currentAccountProvider);
    if (categoryId == null || amount == null || account == null || date == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: context.colorScheme.error,
        content: Text('Veuillez fournir toutes les informations', style: TextStyle(color: context.colorScheme.onError),)));
    } else {
      final TransactionEntity transaction = TransactionEntity(
        tCategoryId: categoryId,
        accountId: account.accountId!,
        transactionAmount: amount,
        transactionDate: date,
        note: note ?? ''
      );
      showDialog(context: context, builder: (ctx)=> AlertDialog(
        title: Text('Confirmation'),
        actions: [
          Row(
            children: [
              ElevatedButton(
                 style: ElevatedButton.styleFrom(
            backgroundColor: context.colorScheme.surface
          ),
                onPressed: (){
                  ctx.pop();
              }, child: Text('Non', style: TextStyle(color: Colors.red),)),
              const Spacer(),
              ElevatedButton(
                 style: ElevatedButton.styleFrom(
            backgroundColor: context.colorScheme.surface
          ),
                onPressed: (){
                 ref.read(transactionViewModelProvider.notifier).addTransaction(transaction);
                // ref.invalidate(transactionViewModelProvider);
                 ref.invalidate(accountViewModelProvider);
                 ref.invalidate(summaryAsyncProvider);
                 ref.invalidate(currentAccountProvider);
                 ctx.pop();
                 
                 
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                   behavior: SnackBarBehavior.floating,
                  backgroundColor: context.colorScheme.secondary,
                  content: Text('Transaction ajoutée avec succès', style: TextStyle(color: context.colorScheme.surface),)));
              }, child: Text('Oui', style: TextStyle(color: Colors.green),))
            ],
          )
        ],
      ));
             
    }
  }

  //--------date picker------
  Future<void> onSelectDate()async{
    final now = DateTime.now();
   final pickedDate = await showDatePicker(context: context, firstDate: DateTime(now.year-1),
   currentDate: now, lastDate: DateTime(now.year+7));
   ref.read(selectedDateProvider.notifier).state =pickedDate;
  }

  @override
  Widget build(BuildContext context) {
    final currentCategoryTypeSelection = ref.watch(transactionTypeProvider);
    final asyncCategories = ref.watch(categoryGridItemProvider);
    final selectedCategory = ref.watch(transactionCategoryProvider);
    final selectedDate = ref.watch(selectedDateProvider);
    final currency = ref.watch(currencyTypeProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Nouvelle transaction'),
        titleTextStyle: context.textTheme.headlineSmall!.copyWith(
          color: context.colorScheme.onSurface
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
          
              //--------------segemented button---------------
              Text('Type de transaction', style: context.textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold
              ),),
              SizedBox(height: 10,),
                SegmentedButton<TransactionType>(

                  expandedInsets: EdgeInsets.all(8),
                  showSelectedIcon: false,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith<Color?>(
                        (Set<WidgetState> states){
                          if(states.contains(WidgetState.selected)){
                          if(currentCategoryTypeSelection == TransactionType.expense){
                          return const Color.fromARGB(150, 244, 67, 54);
                          }else{
                            return const Color.fromARGB(255, 120, 238, 126);
                          }
                          }
                          return null;
                        }
                    ),
                    shape: WidgetStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(9))
                    )
                  ),
                  segments: <ButtonSegment<TransactionType>>[

                    ButtonSegment(
                      value: TransactionType.expense,
                     // icon: Icon(Icons.arrow_downward_rounded),
                      label: Text('Dépenses', style: context.textTheme.bodySmall, textAlign: TextAlign.center,),

                      ),
          
                      ButtonSegment(

                      value: TransactionType.income,
                      //icon: Icon(Icons.arrow_upward_rounded),
                      label: Text('Revenus', style: context.textTheme.bodySmall, textAlign: TextAlign.center,)
                      )
                ], 
                selected: <TransactionType>{currentCategoryTypeSelection},
                onSelectionChanged: (Set<TransactionType> newSelection) {
                  ref.read(transactionTypeProvider.notifier).state = newSelection.first;
                  // if (newSelection.first == TransactionType.income) {
                  //   ref.read(wichCategoryToLoadFilter.notifier).state = CategoryFilter.income;
                  // }else if (newSelection.first == TransactionType.expense){
                  // ref.read(wichCategoryToLoadFilter.notifier).state = CategoryFilter.expense;
                  // }
                  
                },
                ),
          
                SizedBox(height: 17,),
          
                //---------------amount textfield------------
                Text('Montant', style: context.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 10,),
                TextField(
                  controller: _amountController,
                  keyboardType:TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    hintText: '${currency.values.first} 0.00',
                    hintStyle: context.textTheme.bodyLarge
                  ),
                ),
              SizedBox(height: 10,),
                //-------categorie selection---------
                 Text('Catégorie', style: context.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 10,),
                asyncCategories.when(
                  data: (categories){
                    if (categories.isEmpty) {
                      return Center(child: Text('Rien a afficher ici'),);
                    }else{
                      return CategoryGridWidget(categories: categories).animate(key: ValueKey(currentCategoryTypeSelection)).fadeIn(duration: 700.ms);
                    }
                  },
                   error: (e,s)=> Center(child: Text('oops something went wrong'),),
                    loading: ()=> Center(child: CircularProgressIndicator(),)),
                    //----------date picker-----------
                    SizedBox(height: 10,),
                    Text('Date', style: context.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold
                ),),
                    ListTile(
                      tileColor: context.colorScheme.surface,
                      onTap: (){
                        onSelectDate();
                      },
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(color: Colors.grey.shade400)),
                      leading: Icon(Icons.calendar_today, color: context.colorScheme.primary,),
                      title: selectedDate == null ? Text('Sélectionner une date') : Text('${selectedDate.day}/${selectedDate.month}/${selectedDate.year}'),
                      trailing: Icon(Icons.arrow_drop_down),
                    ),
                    SizedBox(height: 10,),
                  //-------note textfield------
                  Text('Note(optionnel)', style: context.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 10,),
                TextField(
                  controller: _noteController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade400)),
                    hintText: 'Ajouter une note...',
                    hintStyle: context.textTheme.bodyLarge
                  ),
                ),
          
                  SizedBox(height: 30,),
                    //-----------confirm button--------
                    ElevatedButton(onPressed: (){
                      final amount = double.tryParse(_amountController.text)?.roundToDouble();
  final categoryId = selectedCategory?.categoryId;
  _onValidate(amount: amount, categoryId: categoryId, note: _noteController.text, date: selectedDate);
                    }, child: Text('Confirmer'))
            ],
          ),
        ),
      )
    ).animate(key: ValueKey(currentCategoryTypeSelection)).fadeIn(duration: 700.ms);
  }
}
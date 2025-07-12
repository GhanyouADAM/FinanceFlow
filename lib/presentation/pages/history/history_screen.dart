import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_app/core/utils/async_value_widget.dart';
import 'package:the_app/presentation/pages/history/widgets/category_provider.dart';
import 'package:the_app/presentation/pages/history/widgets/filter_screen.dart';
import 'package:the_app/presentation/pages/history/widgets/history_transaction_list.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final transactions = ref.watch(transactionsProvider);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 2,
                    child: SearchBar(
                      leading: Icon(Icons.search),
                      controller: _controller,
                      onChanged: (value) {
                        ref.read(searchTermProvider.notifier).state = value;
                        },
                      
                      hintText: 'Rechercher une transaction',
                    ),
                  ),
                  IconButton(onPressed: (){
                    showModalBottomSheet(
        
                      context: context, builder: (ctx)=> SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(11.0),
                          child: FilterScreen(function: (){Navigator.of(ctx).pop();}),
                        ),
                      ));
                  }, icon: Icon(Icons.filter_list_outlined))
                ],
              ),
            ),
            SizedBox(height: 17,),
            Flexible(
              flex: 2,
              child: AsyncValueWidget(value: transactions,
               data: (data){
                if(data.isEmpty) return Center(child: Text('Aucune transaction trouvée'),);
                return HistoryTransactionList(transactions: data);
               },
               loading: Center(child: Text('Rien a afficher ici'),),
               error: Center(child: Text('oops une erreur est survenue'),),
               ),
            ),
          ],
        ),
      ),
    );
  }
}

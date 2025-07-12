import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:the_app/core/theme/build_extension.dart';
import 'package:the_app/domain/entities/account.dart';
import 'package:the_app/presentation/providers/account/account_provider.dart';

class AccountDetailsScreen extends ConsumerWidget {
  const AccountDetailsScreen({super.key, required this.account});
  final Account account;

  
// Method to delete account
 void _onDeleteAccount(WidgetRef ref, Account account, BuildContext context){
  
    showDialog(context: context, builder: (ctx)=> AlertDialog(
      title: Text('Supprimer ce compte ?'),
      content: Text('Vous serez rediriger vers la page d\'accueil. '),
      actions: [
        // button to cancel account deletion
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: context.colorScheme.surface
          ),
          onPressed: (){ctx.pop();}, child: Text('Non', style: TextStyle(color: Colors.red),)),

        //button to confirm account deletion
        ElevatedButton(
           style: ElevatedButton.styleFrom(
            backgroundColor: context.colorScheme.surface
          ),
          onPressed: (){
          //deletion logic
          ref.read(accountViewModelProvider.notifier).deleteAnAccount(account.accountId!);
          context.go('/');
        }, child:  Text('Oui', style: TextStyle(color: Colors.green)))
      ],
    ));
 }
  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details du compte'),
        titleTextStyle: context.textTheme.headlineSmall!.copyWith(
          color: context.colorScheme.onPrimary
        ),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 77,),
          CircleAvatar(
            radius: 37,
            child: Icon(Icons.person),
          ),
          SizedBox(height: 7,),
          Text(account.name, style: context.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold
          ),),
          SizedBox(height: 37,),
          TextButton(onPressed: (){}, child: Text('Modifier le nom')),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 64),
            child: const Divider(),
          ),
          TextButton.icon(onPressed: (){
            _onDeleteAccount(ref, account, context);
          }, label: Text('Supprimer le compte', style: TextStyle(color: context.colorScheme.errorContainer),),  icon: Icon(Icons.delete, color: context.colorScheme.error,),)
        ],
      ),
    );
  }
}
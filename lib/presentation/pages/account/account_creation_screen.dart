// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:the_app/core/provider/account_provider.dart';
import 'package:the_app/core/theme/build_extension.dart';
import 'package:the_app/presentation/providers/account/account_provider.dart';

class AccountCreationScreen extends ConsumerStatefulWidget {
  const AccountCreationScreen({super.key});

  @override
  ConsumerState<AccountCreationScreen> createState() => _AccountCreationScreenState();
}

class _AccountCreationScreenState extends ConsumerState<AccountCreationScreen> {
final TextEditingController _nameController = TextEditingController();
 @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: context.colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
              Center(
                child: Image.asset(
                  
                  'assets/icons/new_logo2.png',
                  
                  color: context.colorScheme.surface,
                  colorBlendMode: BlendMode.colorBurn,
                height: 170,
                ),
              ),
        
              Text('Finance FLow', style: context.textTheme.headlineSmall!.copyWith(
                color: context.colorScheme.primary,
                fontWeight: FontWeight.bold
              ),),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 1,
                      color:  Colors.grey.shade300,
                      offset: Offset(1, 2)
                    )
                  ]
                ),
                 child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    focusColor: context.colorScheme.primary,
                    prefixIcon: Icon(Icons.person),
                    prefixIconColor: context.colorScheme.primary,
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    hintText: 'Entrer votre nom...'
                  ),
                 ),
               ),
             ),
             SizedBox(height: 37,),
             ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 7,
                foregroundColor: context.colorScheme.primary,
                padding: EdgeInsets.symmetric(horizontal: 33)
              ),
              onPressed: (){
                if (_nameController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: Durations.long3,
                    backgroundColor: context.colorScheme.errorContainer,
                    content: Text('Veuiller renseigner un nom !', style: TextStyle(color: context.colorScheme.onErrorContainer),)));
                }else{
                  //-----confirmation dialog
                   showDialog(context: context, builder: (ctx)=>AlertDialog(
                    title: Text('Confirmation'),
                    content: Text('Confirmez-vous ${_nameController.text.trim()} comme nom de compte ?'),
                    actions: [
                      //-------------no proposition----------------
                      MaterialButton(onPressed: (){Navigator.of(ctx).pop();}, child: Text('non', style: TextStyle(color: context.colorScheme.error),),),
        
                      //------------yes proposition-----------
                       MaterialButton(onPressed: () async{
                        //-----------validation logic----------
                        final account = await ref.read(accountViewModelProvider.notifier).addNewAccount(_nameController.text.trim());
                        ref.read(currentAccountProvider.notifier).state =account;
                        Navigator.of(ctx).pop();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        duration: Durations.long3,
                        backgroundColor: context.colorScheme.secondary,
                        behavior: SnackBarBehavior.floating,
        
                          content: Text('Compte créer avec succès', style: TextStyle(color: context.colorScheme.onPrimary),)));
                           
                          //------load the freshly created account
                            context.go('/home', extra: account);
                       }, child: Text('oui', style: TextStyle(color: context.colorScheme.secondary),),)
                    ],
                   ));
                }
              }, child: Text('continuer',))
          ],
        ),
      ),
    );
  }
}
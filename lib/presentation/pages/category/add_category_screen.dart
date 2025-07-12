import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:the_app/core/provider/account_provider.dart';
import 'package:the_app/core/theme/build_extension.dart';
import 'package:the_app/domain/entities/category.dart';
import 'package:the_app/domain/entities/transaction.dart';
import 'package:the_app/presentation/pages/category/widget/category_selection.dart';
import 'package:the_app/presentation/pages/category/widget/color_picker.dart';
import 'package:the_app/presentation/pages/category/widget/icon_picker.dart';
import 'package:the_app/presentation/providers/category/category_provider.dart';
import 'package:the_app/presentation/providers/transaction/transaction_provider.dart';

class AddCategoryScreen extends ConsumerStatefulWidget {
  const AddCategoryScreen({super.key});
  @override
  ConsumerState<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends ConsumerState<AddCategoryScreen> {
final TextEditingController _categoryNameController = TextEditingController();
 IconData? selectedIcon;
 TransactionType selectedType = TransactionType.expense;
 Color? selectedColor;
@override
  void dispose() {
    _categoryNameController.dispose();
      super.dispose();
  }
 //validate the form
   void _onValidate ({TransactionType? type, String? name, IconData? icon, Color? color, int? accountId, VoidCallback? onCancel}){
      if (name != null && type != null && icon != null && color != null && accountId != null) {
        if (name.length >=2) {
          TransactionCategory category = TransactionCategory(type: type, name: name, icon: icon, color: color, accountId: accountId);
          ref.read(categoryViewModelProvider.notifier).addCategoryCase(
            category
          );
          //-------reset state to refresh the screen -------
          ref.invalidate(categoryViewModelProvider);
          ref.invalidate(categoryGridItemProvider);
          //--------validation snackbar-------------
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: context.colorScheme.secondary,
            content: Text('Catégorie ajoutée avec succès')
            ));
            onCancel;
           context.pop();
           //-------reset user's previous choices for color and icon------
           ref.read(categoryColorProvider.notifier).state =null;
           ref.read(categoryIconProvider.notifier).state = null;
        }
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Veuiller renseigner toutes les informations : Nom, icône, couleur....')));
      }

   }

    // Available icons for selection
    final icons = [
      Icons.shopping_cart,
      Icons.fastfood,
      Icons.local_cafe,
      Icons.restaurant,
      Icons.directions_car,
      Icons.directions_bus,
      Icons.home,
      Icons.house,
      Icons.weekend,
      Icons.hotel,
      Icons.local_hospital,
      Icons.medical_services,
      Icons.movie,
      Icons.music_note,
      Icons.sports_esports,
      Icons.sports_basketball,
      Icons.flight,
      Icons.beach_access,
      Icons.shopping_bag,
      Icons.store,
      Icons.school,
      Icons.book,
      Icons.work,
      Icons.business_center,
      Icons.card_giftcard,
      Icons.cake,
      Icons.attach_money,
      Icons.savings,
      Icons.account_balance,
      Icons.trending_up,
      Icons.credit_card,
      Icons.receipt,
      Icons.more_horiz,
    ];


    // Available colors for selection
    final colors = [
      Colors.red,
      Colors.pink,
      Colors.purple,
      Colors.deepPurple,
      Colors.indigo,
      Colors.blue,
      Colors.lightBlue,
      Colors.cyan,
      Colors.teal,
      Colors.green,
      Colors.lightGreen,
      Colors.lime,
      Colors.yellow,
      Colors.amber,
      Colors.orange,
      Colors.deepOrange,
      Colors.brown,
      Colors.grey,
      Colors.blueGrey,
    ];
  @override
  Widget build(BuildContext context) {

    // final currentCategoryTypeSelection = ref.watch(categoryTypeProvider);
    final account = ref.watch(currentAccountProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Nouvelle Catégorie'),
        titleTextStyle: context.textTheme.headlineSmall!.copyWith(
          color: context.colorScheme.onSurface
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              //-----------TextField--------
             TextField(
              controller: _categoryNameController,
              decoration: InputDecoration(
                hintText: 'Nouvelle catégorie',
              ),
             ),
        
             SizedBox(height: 21,),
        
             //----------------segmentedButton----------
             CategorySelection(currentCategoryTypeSelection: selectedType, onTypeSelected: (value) => setState(()=>selectedType = value),),
        
              SizedBox(height: 21,),
        
              //--------iconpicker------------------
             Text('Icône', style: context.textTheme.bodyLarge!.copyWith(
               fontWeight: FontWeight.bold
             ),),
              SizedBox(height: 7,),
                 Container(
                  height: 330,
                   decoration: BoxDecoration(
                     color: context.colorScheme.surface,
                     border: Border.all(color: Colors.grey.shade400),
                     borderRadius: BorderRadius.circular(7)
                   ),
                   child: IconPicker(icons: icons, selectedColor: selectedColor,selectedIcon: selectedIcon , onSelectedIcon: (icon)=>setState(()=> selectedIcon = icon),)),
        
                SizedBox(height: 21,),
        
                //------------colorpicker-----------------
                Text('Couleur', style: context.textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold
                ),),
              SizedBox(height: 7,),
             Container(
              height: 170,
              width: double.infinity,
               decoration: BoxDecoration(
                 color: context.colorScheme.surface,
                 boxShadow: [
                   BoxShadow(
                     spreadRadius: 2,
                     offset: Offset(0, 2),
                     color: Colors.grey.shade300
                   )
                 ],
                 border: Border.all(color: Colors.grey.shade400),
                 borderRadius: BorderRadius.circular(7)
               ),
               child: ColorPicker(colors: colors, selectedColor: selectedColor, onSelectedColor: (color) => setState(()=>selectedColor = color),)),
        
                SizedBox(height: 57,),
        
          //------------validation button ------------
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 17, horizontal: 55),
                    elevation: 7
                  ),
                  onPressed: (){
                    if (_categoryNameController.text.isNotEmpty &&  selectedIcon != null && selectedColor != null && account!.accountId != null) {
                      final category= TransactionCategory(accountId: account.accountId!, type: selectedType , name: _categoryNameController.text, icon: selectedIcon!, color: selectedColor!);
                   showDialog(context: context, builder: (ctx)=> AlertDialog(
                    title: Text('Confirmation'),
                    content : Text('Vous êtes sur le point d\'ajouter cette nouvelle catégorie'),
                    actions: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
        height: 70,
        width: double.infinity,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                spreadRadius: 0.5,
                color: Colors.grey,
                offset: Offset(0, 2)
              )
            ]
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: category.color.withValues(alpha: 0.3),
              child: Icon(category.icon, color: category.color,)),
            SizedBox(width: 10),
            Text(category.name, style: context.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold
            ),)
          ],
        ),
      ).animate().fadeIn(duration: 1000.ms).shimmer(duration: 700.ms, color: category.color)),
      SizedBox(height: 20,),
                          Flexible(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                   style: ElevatedButton.styleFrom(
            backgroundColor: context.colorScheme.surface
          ),
                                  onPressed: (){
                                  Navigator.of(ctx).pop();
                                }, child: Text('Annuler', style: TextStyle(color: Colors.red),)),
                                ElevatedButton(
                                   style: ElevatedButton.styleFrom(
            backgroundColor: context.colorScheme.surface
          ),
                                  onPressed: (){
                                   _onValidate(color: selectedColor, icon: selectedIcon, type: selectedType, name: _categoryNameController.text, accountId: account.accountId, onCancel: (){Navigator.of(ctx).pop();});
                                  context.pop();
                                }, child: Text('confirmer', style: TextStyle(color: Colors.green),))
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                   ));
                    } else {
                      return;
                    }
                  },
                   child: Text('Confirmer'))
            ],
          ),
        ),
      ),
    );
  }
}
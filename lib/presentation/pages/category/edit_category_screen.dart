import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_app/core/theme/build_extension.dart';
import 'package:the_app/presentation/pages/category/widget/category_selection.dart';
import 'package:the_app/presentation/pages/category/widget/color_picker.dart';
import 'package:the_app/presentation/pages/category/widget/icon_picker.dart';
import 'package:the_app/presentation/providers/transaction/transaction_provider.dart';

import '../../../core/provider/account_provider.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/entities/transaction.dart';
import '../../providers/category/category_provider.dart';

class EditCategoryScreen extends ConsumerStatefulWidget {
  const EditCategoryScreen({super.key, required this.category, required this.onCancel});
  final TransactionCategory category;
  final VoidCallback onCancel;
  // final  void Function({TransactionType? type, String? name, IconData? icon, Color? color, int? accountId}) toEdit;
  @override
  ConsumerState<EditCategoryScreen> createState() => _EditCategoryScreenState();
}
class _EditCategoryScreenState extends ConsumerState<EditCategoryScreen> {

  final TextEditingController _categoryNameController = TextEditingController();
 late IconData? selectedIcon;
 late Color? selectedColor;
 late TransactionType? selectedType;
  @override
  void initState() {
    super.initState();
    _categoryNameController.text = widget.category.name;
      selectedColor = widget.category.color;
      selectedIcon = widget.category.icon;
      selectedType = widget.category.type;
    
  }
  @override
  void dispose() {
    _categoryNameController.dispose();
    super.dispose();
  }
//validate the form
  void _onEdit ({TransactionType? type, String? name, IconData? icon, Color? color, int? accountId}){
    if (name != null && type != null && icon != null && color != null && accountId != null) {
      if (name.length >=2) {
        TransactionCategory category = TransactionCategory(
          categoryId: widget.category.categoryId,
          type: type, name: name, icon: icon, color: color, accountId: accountId);
        ref.read(categoryViewModelProvider.notifier).updateCategory(category);
        //-------reset state to refresh the screen ------
        ref.invalidate(categoryGridItemProvider);
        //--------validation snackbar-------------
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: context.colorScheme.secondary,
            content: Text('Catégorie Modifiée avec succès'),
        ));
        //--------------cancel the modal bottom sheet--------
          widget.onCancel();
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
  
    final currentCategoryTypeSelection = ref.watch(categoryTypeProvider);
    final account = ref.watch(currentAccountProvider);
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Modifier une catégorie', style: context.textTheme.headlineSmall,),
      //-----------TextField--------
      TextField(
      controller: _categoryNameController,
      decoration: InputDecoration(
      hintText: 'Nouvelle catégorie',
      ),
      ),
      
      SizedBox(height: 21,),
      
      //----------------segmentedButton----------
      CategorySelection(currentCategoryTypeSelection: selectedType ?? currentCategoryTypeSelection, onTypeSelected: (value)=>setState(()=>selectedType =value),),
      
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
      child: IconPicker(icons: icons, selectedIcon: selectedIcon, selectedColor: selectedColor,  onSelectedIcon: (icon) => setState(() => selectedIcon = icon),)),
      
      SizedBox(height: 21,),
      
      //------------colorpicker-----------------
      Text('Couleur', style: context.textTheme.bodyLarge!.copyWith(
      fontWeight: FontWeight.bold
      ),),
      SizedBox(height: 7,),
      Container(
        height: 170,
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
      child: ColorPicker(colors: colors, selectedColor: selectedColor, onSelectedColor: (color)=>setState(()=>selectedColor = color),)),
      
      SizedBox(height: 57,),
      
      //------------validation button ------------
      Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: context.colorScheme.surface,
         // padding: EdgeInsets.symmetric(vertical: 13, horizontal: 55),
          elevation: 7,
          foregroundColor: Colors.red

          ),
          onPressed: widget.onCancel,
          child: Text('Annuler')),
          SizedBox(width: 30,),
          ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: context.colorScheme.surface,
          //padding: EdgeInsets.symmetric(vertical: 13, horizontal: 55),
          elevation: 7,
          foregroundColor: Colors.green
          ),
          onPressed: (){
           _onEdit(color: selectedColor, icon: selectedIcon, type: selectedType, name: _categoryNameController.text, accountId: account!.accountId);
          },
          child: Text('Editer')),
        ],
      )
      ],
      ),),
    );
  }
}

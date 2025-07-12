import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_app/core/theme/build_extension.dart';
import 'package:the_app/core/utils/async_value_widget.dart';
import 'package:the_app/presentation/pages/history/widgets/category_provider.dart';


class FilterScreen extends ConsumerStatefulWidget {
  const FilterScreen({super.key, required this.function});
 final VoidCallback function;
  @override
  ConsumerState<FilterScreen> createState() => _FilterScreenState();
}


class _FilterScreenState extends ConsumerState<FilterScreen> {
  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(categoryProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    // final loadingType = ref.watch(transactionsLoadingTypeProvider);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.filter_list_outlined),
            title: Text('Filtrer les transactions'),
            titleTextStyle: context.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 17
            ),
            trailing: IconButton(onPressed: widget.function , icon: Icon(Icons.close)),
          ),
          SizedBox(height: 1,),
          const Divider(),
          // Text('Types de transactions', style: context.textTheme.bodyLarge,),
          // SizedBox(height: 7,),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: List.generate(TransactionsLoadingType.values.length, (int index){
          //     final l = TransactionsLoadingType.values[index];
          //     return Padding(
          //       padding: const EdgeInsets.all(3.0),
          //       child: ChoiceChip(
          //         showCheckmark: false,
          //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          //         side: BorderSide(color: l !=loadingType ?  Colors.grey.shade400 : context.colorScheme.primary),
          //         label: Text(l.name), 
          //         selectedColor: context.colorScheme.primary.withValues(alpha: 0.1),
          //         labelStyle: TextStyle(color: l == loadingType ? context.colorScheme.primary : context.colorScheme.onSurface),
          //         selected: l == loadingType,
          //         onSelected: (bool selected){
          //           ref.read(transactionsLoadingTypeProvider.notifier).state = selected ? l : null;
          //         },
          //         ),
          //     );
          //   }),
          // ),
          SizedBox(height: 9,),
          Text('Catégorie de transactions', style: context.textTheme.bodyLarge,),
          SizedBox(height: 7,),
          AsyncValueWidget(
            value: categories, data: (data) => Wrap(
              runSpacing: 3,
              spacing: 3,
              children: List.generate(data.length, (int index){
                final category = data[index];
                return ChoiceChip(
                  checkmarkColor: category.color,
                  selectedColor: context.colorScheme.primary.withValues(alpha: 0.7),
                  side: BorderSide(color: Colors.grey.shade400),
                  showCheckmark: false,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  avatar: CircleColor(color: category.color, circleSize: 17),
                  label: Text(category.name),
                  labelStyle: TextStyle(color: category== selectedCategory ? context.colorScheme.onPrimary : context.colorScheme.onSurface),
                   selected: selectedCategory == category ,
                   onSelected: (bool selected){
                     ref.read(selectedCategoryProvider.notifier).state = selected ? category : null;
                   },
                   );
              })
            )),
            SizedBox(height: 7,),
          //   Text('Periode', style: context.textTheme.bodyLarge,),
          // SizedBox(height: 7,),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Container(
          //       padding: EdgeInsets.symmetric(horizontal: 21, vertical: 11),
          //       decoration: BoxDecoration(
          //         border: Border.all(color: Colors.grey.shade400),
          //         borderRadius: BorderRadius.circular(8)
          //       ),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text('Debut', style: context.textTheme.bodySmall!.copyWith(
          //             color: Colors.grey
          //           ),),
          //           Text('Non sélectionné')
          //         ],
          //       ),
          //     ),
          //       Container(
          //         padding: EdgeInsets.symmetric(horizontal: 21, vertical: 11),
          //       decoration: BoxDecoration(
          //         border: Border.all(color: Colors.grey.shade400),
          //         borderRadius: BorderRadius.circular(8)
          //       ),
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text('Fin', style: context.textTheme.bodySmall!.copyWith(
          //             color: Colors.grey
          //           )),
          //           Text('Non sélectionné')
          //         ],
          //       ),
          //     )
          //   ],
          // ),
          // SizedBox(height: 7,),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     MaterialButton(onPressed: (){},
          //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11), side: BorderSide(color: context.colorScheme.primary)),
          //     textColor: context.colorScheme.primary,
          //     child: Text('Reinitialiser'),
          //     ),
          //     MaterialButton(
          //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11,)),
          //       color: context.colorScheme.primary,
          //     textColor: context.colorScheme.onPrimary,
          //       onPressed: (){},
          //     child: Text('Appliquer'),)
          //   ],
          // )
        ],
      ),
    );
  }
}
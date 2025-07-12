import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_app/core/provider/theme_provider.dart';
import 'package:the_app/core/theme/build_extension.dart';
class BigCardResume extends ConsumerWidget {
  const BigCardResume({super.key, required this.budget, required this.incomeBudget, required this.expenseBudget});
  final double budget;
  final double incomeBudget;
  final double expenseBudget;
  @override
  Widget build(BuildContext context, ref) {
    final currency = ref.watch(currencyTypeProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(8),
        width: double.infinity,
        height: 135,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
              context.colorScheme.primary,
              context.colorScheme.primary.withValues(alpha: 0.7),
              context.colorScheme.primary.withValues(alpha: 0.6)
          ]),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              spreadRadius: 2,
              blurRadius: 1,
              color: Colors.grey,
              offset: Offset(0, 1)
            )
          ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Solde actuel', style: context.textTheme.bodyLarge!.copyWith(
              color: context.colorScheme.onPrimary,
              fontWeight: FontWeight.w500
            ),),
            SizedBox(height: 3,),
            Text('${budget.roundToDouble()} ${currency.values.first}', style: context.textTheme.bodyLarge!.copyWith(
              color: context.colorScheme.onPrimary,
              fontSize: 21,
              fontWeight: FontWeight.w700
            ),),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //---income-----
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.arrow_upward_rounded, size: 17, color: context.colorScheme.onPrimary,),
                        SizedBox(width: 10,),
                        Text('Revenus', style: context.textTheme.bodyMedium!.copyWith(
                          color: context.colorScheme.onPrimary,
                        ),)
                      ],
                    ),
                   SizedBox(height: 5),
                    Text('${incomeBudget.roundToDouble()} ${currency.values.first}', style: context.textTheme.bodyLarge!.copyWith(
                                  color: context.colorScheme.onPrimary,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700
                                ),),
                  ],
                ),
                //-----expense----
                   Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.arrow_downward_rounded, size: 17, color: context.colorScheme.onPrimary,),
                        SizedBox(width: 10,),
                        Text('Dépenses', style: context.textTheme.bodyMedium!.copyWith(
                          color: context.colorScheme.onPrimary,
                        ),)
                      ],
                    ),
                   SizedBox(height: 5),
                    Text('${expenseBudget.roundToDouble()} ${currency.values.first}', style: context.textTheme.bodyLarge!.copyWith(
                                  color: context.colorScheme.onPrimary,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700
                                ),),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
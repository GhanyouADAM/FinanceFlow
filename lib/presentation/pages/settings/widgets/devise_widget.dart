import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_app/core/provider/theme_provider.dart';
import 'package:the_app/core/theme/build_extension.dart';

class DeviseWidget extends ConsumerStatefulWidget {
  const DeviseWidget({super.key});

  @override
  ConsumerState<DeviseWidget> createState() => _DeviseWidgetState();
}

final Map<Currencies, Map<String, String>> type = {
  Currencies.cfa : {'Franc CFA' : 'FCFA'},
  Currencies.livre : {'Livre Sterling' : '£'},
  Currencies.yen : {'Yen japonais' : '¥'},
  Currencies.euro : {'Euro': '€'},
  Currencies.dollar : {'Dollar americain' : r'$'}
};

class _DeviseWidgetState extends ConsumerState<DeviseWidget> {
  @override
  Widget build(BuildContext context) {
    final selectedCurrencyAsync =  ref.watch(currencyProvider);
    final selectedCurrency = selectedCurrencyAsync.value ?? Currencies.cfa;
    return Container(
      padding: EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            spreadRadius: 2,
            color: Colors.grey.shade300,
            offset: Offset(1, 2)
          )
        ]
      ),
      child: Column(
        children: List.generate(type.length, (int index){
          final currency = type.entries.toList()[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              onTap: () async {
                await ref.read(currencyProvider.notifier).setCurrency(currency.key);
              },
              leading: Container(
                height: 57,
                width: 57,
                padding: EdgeInsets.all(3),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selectedCurrency == currency.key ? context.colorScheme.primary.withValues(alpha: 0.3) : context.colorScheme.surface,
                  shape: BoxShape.circle,
                  border: Border.all(color : selectedCurrency == currency.key ? context.colorScheme.primary :  Colors.grey.shade400)
                ),
                child: Text( currency.value.values.first, style: context.textTheme.bodyLarge!.copyWith(
                  color: selectedCurrency == currency.key ? context.colorScheme.primary : context.colorScheme.onSurface,
                  fontWeight: FontWeight.bold
                ),),
              ),
              title: Text(currency.value.keys.first),
              trailing: selectedCurrency == currency.key ? Icon(Icons.check_circle, color: context.colorScheme.primary,) : null,
            ),
          );
        })
        ,
      ),
    );
  }
}
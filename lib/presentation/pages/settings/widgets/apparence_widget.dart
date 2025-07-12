import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_app/core/provider/theme_provider.dart';
import 'package:the_app/core/theme/build_extension.dart';
enum ThemeSetting{
    clair,
    sombre,
    system,
  }
class ApparenceWidget extends ConsumerStatefulWidget {
  const ApparenceWidget({super.key});

  @override
  ConsumerState<ApparenceWidget> createState() => _ApparenceWidgetState();
}

class _ApparenceWidgetState extends ConsumerState<ApparenceWidget> {

  @override
  Widget build(BuildContext context) {
    final themeAsync = ref.watch(themeModeProvider);
    final theme = themeAsync.value ?? ThemeMode.light;
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            spreadRadius: 2,
            offset: Offset(1, 2),
            color: Colors.grey.shade300
          )
        ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.sunny),
            title: Text('Thème clair'),
            trailing: Radio<ThemeMode>(
               activeColor: context.colorScheme.primary,
              value: ThemeMode.light,
               groupValue: theme,
                onChanged: (ThemeMode? value) async {
                  await ref.read(themeModeProvider.notifier).setThemeMode(value!);
                }),
          ),
          SizedBox(height: 3,),
           ListTile(
            leading: Icon(Icons.nightlight_round_outlined),
            title: Text('Thème sombre'),
            trailing: Radio<ThemeMode>(
                activeColor: context.colorScheme.primary,
              value: ThemeMode.dark,
               groupValue: theme,
                onChanged: (ThemeMode? value) async {
                 await ref.read(themeModeProvider.notifier).setThemeMode(value!);
                }),
          ),
          SizedBox(height: 3,),
           ListTile(
            leading: Icon(Icons.contrast),
            title: Text('Sytème'),
            subtitle: Text('Utlise le thème de votre appareil'),
            subtitleTextStyle: context.textTheme.bodySmall,
            trailing: Radio<ThemeMode>(
              activeColor: context.colorScheme.primary,
              value: ThemeMode.system,
               groupValue: theme,
                onChanged: (ThemeMode? value) async {
                  await ref.read(themeModeProvider.notifier).setThemeMode(value!);
                }),
          )
        ],
      ),
    );
  }
}
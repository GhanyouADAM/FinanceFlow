import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_app/core/services/theme_color_service.dart';
import 'package:the_app/core/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
final themeColorServiceProvider = Provider<ThemeColorService>((ref)=>ThemeColorService());

final initialColorProvider = FutureProvider<Color>((ref) async{
  final service = ref.read(themeColorServiceProvider);
  return await service.getSavedColor();
});

final colorProvider = StateNotifierProvider<ColorNotifier, Color>((ref){
  final initialColorAsync = ref.watch(initialColorProvider);
  final service = ref.read(themeColorServiceProvider);
  //use a default color if the saved one hasn't load yet
  final initialColor = initialColorAsync.value ??  Color.fromARGB(255, 179, 38, 197);
  return ColorNotifier(initialColor, service);
});

//class that watch changes of color
class ColorNotifier extends StateNotifier<Color> {
  final ThemeColorService _service;

  ColorNotifier(Color initialColor, this._service) : super(initialColor);

  // Method to change color
  void changeColor(Color newColor) {
    state = newColor;
    _service.saveColor(newColor); // Save the color
  }
}

// AsyncNotifier for ThemeMode persistence
class ThemeModeNotifier extends AsyncNotifier<ThemeMode> {
  static const _key = 'theme_mode';

  @override
  Future<ThemeMode> build() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_key);
    if (value == 'dark') return ThemeMode.dark;
    if (value == 'light') return ThemeMode.light;
    if (value == 'system') return ThemeMode.system;
    return ThemeMode.light;
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = AsyncValue.data(mode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, mode.name);
  }
}

final themeModeProvider = AsyncNotifierProvider<ThemeModeNotifier, ThemeMode>(ThemeModeNotifier.new);

final appThemeProvider = Provider<ThemeData>((ref) {
  final mode = ref.watch(themeModeProvider).value ?? ThemeMode.light;
  return mode == ThemeMode.dark ? AppTheme.darkTheme : AppTheme.lightTheme;
});

enum Currencies {
  cfa,
  livre,
  yen,
  euro,
  dollar
}

// AsyncNotifier for Currency persistence
class CurrencyNotifier extends AsyncNotifier<Currencies> {
  static const _key = 'currency';

  @override
  Future<Currencies> build() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(_key);
    return Currencies.values.firstWhere(
      (e) => e.name == value,
      orElse: () => Currencies.cfa,
    );
  }

  Future<void> setCurrency(Currencies currency) async {
    state = AsyncValue.data(currency);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, currency.name);
  }
}

final currencyProvider = AsyncNotifierProvider<CurrencyNotifier, Currencies>(CurrencyNotifier.new);

final currencyTypeProvider = Provider<Map<String, String>>((ref) {
  final currency = ref.watch(currencyProvider).value ?? Currencies.cfa;
  switch (currency) {
    case Currencies.cfa:
      return {'Franc CFA': 'FCFA'};
    case Currencies.livre:
      return {'Livre Sterling': '£'};
    case Currencies.yen:
      return {'Yen japonais': '¥'};
    case Currencies.euro:
      return {'Euro': '€'};
    case Currencies.dollar:
      return {'Dollar americain': r'$'};
  }
});
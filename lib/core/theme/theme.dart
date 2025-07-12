import 'package:flutter/material.dart';

class AppTheme {
  // Méthode statique qui génère un thème clair basé sur une couleur primaire
  static ThemeData getLightTheme(Color primaryColor) {
    return ThemeData.light().copyWith(
      primaryColor: primaryColor,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: primaryColor.withValues(alpha: 0.7),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
        ),
      ),
      // TODO: Ajouter d'autres personnalisations basées sur la couleur primaire ici
    );
  }

  // Méthode statique qui génère un thème sombre basé sur une couleur primaire
  static ThemeData getDarkTheme(Color primaryColor) {
    return ThemeData.dark().copyWith(
      primaryColor: primaryColor,
      colorScheme: ColorScheme.dark(
        primary: primaryColor,
        secondary: primaryColor.withValues(alpha : 0.7),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[900],
        iconTheme: IconThemeData(color: primaryColor),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
        ),
      ),
      //TODO: Ajouterd'autres personnalisations basées sur la couleur primaire ici
    );
  }

  // Pour la compatibilité avec le code existant
  static ThemeData get lightTheme => getLightTheme(Colors.purple);
  static ThemeData get darkTheme => getDarkTheme(Colors.purple);
}
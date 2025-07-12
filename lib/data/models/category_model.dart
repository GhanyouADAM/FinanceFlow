import 'package:flutter/material.dart';
import 'package:the_app/domain/entities/category.dart';
import 'package:the_app/domain/entities/transaction.dart';

class CategoryModel {
  final int? mCategoryId;
  final int mAccountId; // <-- Ajout de la clé étrangère
  final String mCategoryType;
  final String mCategoryName;
  final String mCategoryIcon;
  final String mCategoryColor;

  CategoryModel({
    this.mCategoryId,
    required this.mAccountId,
    required this.mCategoryType ,
    required this.mCategoryName,
    required this.mCategoryIcon,
    required this.mCategoryColor,
  });

  // to add model to database
  Map<String, dynamic> toMap() {
    return {
      if (mCategoryId != null) 'categoryId': mCategoryId,
      'accountId': mAccountId,
      'categoryType' : mCategoryType,
      'categoryName': mCategoryName,
      'categoryIcon': mCategoryIcon,
      'categoryColor': mCategoryColor,
    };
  }

  //to retrieve data from database
  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      mCategoryId: map['categoryId'],
      mAccountId: map['accountId'],
      mCategoryType: map['categoryType'] as String,
      mCategoryName: map['categoryName'] as String,
      mCategoryIcon: map['categoryIcon'] as String,
      mCategoryColor: map['categoryColor'] as String,
    );
  }

  //to transform into an entity
  TransactionCategory toEntity() {
    return TransactionCategory(
      categoryId: mCategoryId,
      accountId: mAccountId,
      type: mCategoryType == 'income' ? TransactionType.income : TransactionType.expense,
      name: mCategoryName,
      icon: CategoryModel.stringToIconData(mCategoryIcon),
      color: Color(int.parse(mCategoryColor, radix: 16)),
    );
  }

  //convert an entity to a model
  factory CategoryModel.fromEntity(TransactionCategory category) {
    return CategoryModel(
      mCategoryId: category.categoryId,
      mAccountId: category.accountId,
      mCategoryType: category.type.name,
      mCategoryName: category.name,
      mCategoryIcon: iconDataToString(category.icon),
      mCategoryColor: _convertColorToString(category.color),
    );
  }

  /// Convertit un IconData en String pour le stockage en base de données.
  /// Le format de la chaîne est "codePoint|fontFamily|fontPackage|matchTextDirection".
  /// "null" est utilisé comme placeholder pour les valeurs nulles de fontFamily ou fontPackage.
  static String iconDataToString(IconData iconData) {
    final codePoint = iconData.codePoint;
    final fontFamily = iconData.fontFamily ?? "null"; // Utilise "null" si null
    final fontPackage = iconData.fontPackage ?? "null"; // Utilise "null" si null
    final matchTextDirection = iconData.matchTextDirection.toString(); // "true" ou "false"

    return "$codePoint|$fontFamily|$fontPackage|$matchTextDirection";
  }

  /// Convertit une String (au format généré par iconDataToString) en IconData.
  /// Lance une FormatException si la chaîne n'est pas au format attendu.
  static IconData stringToIconData(String iconString) {
    try {
      final parts = iconString.split('|');
      if (parts.length != 4) {
        throw FormatException("Invalid icon string format: Expected 4 parts separated by '|'");
      }

      final codePoint = int.parse(parts[0]);
      final fontFamily = parts[1] == "null" ? null : parts[1]; // Convertit "null" en null
      final fontPackage = parts[2] == "null" ? null : parts[2]; // Convertit "null" en null
      final matchTextDirection = bool.parse(parts[3]);

      return IconData(
        codePoint,
        fontFamily: fontFamily,
        fontPackage: fontPackage,
        matchTextDirection: matchTextDirection,
      );
    } catch (e) {
      // Capture les erreurs de parsing (int.parse, bool.parse) ou le format incorrect
      throw FormatException("Failed to parse icon string '$iconString': $e");
    }
  }

  //convert color to string for database
  static _convertColorToString(Color color) {
    return color.value.toRadixString(16).padLeft(8, '0');
  }

  // //convert string back to color
  // static _convertStringToColor(String colorCode) {
  //   try {
  //     return Color(int.parse(colorCode, radix: 16));
  //   } catch (e) {
  //     return Colors.grey;
  //   }
  // }
}

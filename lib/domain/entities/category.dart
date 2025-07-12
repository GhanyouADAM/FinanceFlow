import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:the_app/domain/entities/transaction.dart';
class TransactionCategory extends Equatable{
  final int? categoryId;
  final int accountId; // <-- Ajout de la clé étrangère
  final String name;
  final TransactionType type;
  final IconData icon;
  final Color color;

  const TransactionCategory({
    this.categoryId,
    required this.accountId,
    required this.type,
    required this.name,
    required this.icon,
    required this.color,
  });

  TransactionCategory copyWith({
    int? categoryId,
    int? accountId,
    TransactionType? type,
    String? name,
    IconData? icon,
    Color? color,
  }) {
    return TransactionCategory(
      categoryId: categoryId ?? this.categoryId,
      accountId: accountId ?? this.accountId,
      type: type ?? this.type,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
    );
  }

@override
List<Object?> get props => [categoryId, accountId, type, name, icon, color];
}

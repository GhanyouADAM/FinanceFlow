import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_app/domain/entities/account.dart';

/// Provider global pour l'account courant sélectionné dans l'app
final currentAccountProvider = StateProvider<Account?>((ref) => null);
final authStateProvider = StateProvider<bool>((ref)=>false);
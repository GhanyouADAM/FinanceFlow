import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_app/core/provider/db_provider.dart';
import 'package:the_app/data/repositories/account_repository_impl.dart';
import 'package:the_app/domain/entities/account.dart';
import 'package:the_app/domain/repositories/account_repository.dart';
import 'package:the_app/presentation/providers/account/usecases/account_usecases_provider.dart';

import '../../viewmodels/account_viewmodel.dart';

final accountRepositoryProvider = Provider<AccountRepository>((ref){
  final source = ref.watch(localSourceProvider);
  return AccountRepositoryImpl(source);
});

// final asyncAccountProvider = FutureProvider<Account?>((ref) async {
// final accountLoader = ref.watch(getAccountByIdCaseProvider);
// return  accountLoader.call();
// });

// final accountProvider = Provider<Account?>((ref){
//   final asyncValue = ref.watch(asyncAccountProvider);
//   Account? account;
//   if(asyncValue.hasValue){
//     if (asyncValue.value != null) {
//       account = asyncValue.value!;
//     }
//   }else{
//     account = null;
//   }
//   return account;
// });
final selectedAccount = StateProvider<int>((ref)=>0);
final accountViewModelProvider = StateNotifierProvider<AccountViewModel, AsyncValue<Account?>>((ref){
  final addAccount = ref.watch(addAccountCaseProvider);
  final updateAccount = ref.watch(updateAccountCaseProvider);
  final deleteAccount = ref.watch(deleteAccountCaseProvider);
  final getAccountById = ref.watch(getAccountByIdCaseProvider);
return AccountViewModel(addAccount, updateAccount, deleteAccount, getAccountById);
});
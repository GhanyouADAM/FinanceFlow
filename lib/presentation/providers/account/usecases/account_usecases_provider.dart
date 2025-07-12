
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_app/domain/usescases/account_usecases/add_account_case.dart';
import 'package:the_app/domain/usescases/account_usecases/delete_account_case.dart';
import 'package:the_app/domain/usescases/account_usecases/get_account_by_id_case.dart';
import 'package:the_app/domain/usescases/account_usecases/update_account_case.dart';
import 'package:the_app/presentation/providers/account/account_provider.dart';

final addAccountCaseProvider = Provider<AddAccountCase>((ref){
  final accountRepository = ref.watch(accountRepositoryProvider);
  return AddAccountCase(accountRepository);
});

final updateAccountCaseProvider = Provider<UpdateAccountCase>((ref){
  final accountRepository = ref.watch(accountRepositoryProvider);
  return UpdateAccountCase(accountRepository);
});

final deleteAccountCaseProvider = Provider<DeleteAccountCase>((ref){
  final accountRepository = ref.watch(accountRepositoryProvider);
  return DeleteAccountCase(accountRepository);
});

final getAccountByIdCaseProvider = Provider<GetAccountByIdCase>((ref){
  final accountRepository = ref.watch(accountRepositoryProvider);
  return GetAccountByIdCase(accountRepository);
});

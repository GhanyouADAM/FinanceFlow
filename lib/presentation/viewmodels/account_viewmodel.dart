



import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_app/domain/entities/account.dart';
import 'package:the_app/domain/usescases/account_usecases/add_account_case.dart';
import 'package:the_app/domain/usescases/account_usecases/delete_account_case.dart';
import 'package:the_app/domain/usescases/account_usecases/get_account_by_id_case.dart';

import 'package:the_app/domain/usescases/account_usecases/update_account_case.dart';

class AccountViewModel extends StateNotifier<AsyncValue<Account?>>{
  final AddAccountCase _addAccount;
  final UpdateAccountCase _updateAccountCase;
  final DeleteAccountCase _deleteAccount;
  final GetAccountByIdCase _getAccountById;
  AccountViewModel(this._addAccount, this._updateAccountCase, this._deleteAccount, this._getAccountById): super(const AsyncValue.loading()){
    _loadAccounts();
  }

  Future<void> _loadAccounts() async {
    state = const AsyncValue.loading();
    try{
      final Account? account = await _getAccountById();
      ///Removing this exception sovle an issue with the router. 
      ///I'm using the async value of account to control which screen to display. 
      ///The Exception where restraining the state somehow to access the value retrieved form the db.
      
      /* if (account == null) {
      /   throw Exception('No account yet');
       }*/
      
      state = AsyncValue.data(account);
    }catch(e, s){
        state =AsyncValue.error(e, s);
    }
  }
// ancienne version de la methode
//  Future<void> addNewAccount(String name) async {
//     state = const AsyncValue.loading();
//     try{
//       await _addAccount(name);
//       _loadAccounts();
//     }catch(e, s){
//         state = AsyncValue.error(e, s);
//     }
//   }
  Future<Account?> addNewAccount(String name) async {
    state = const AsyncValue.loading();
    try{
      await _addAccount(name);
      final account = await _getAccountById();
      state = AsyncValue.data(account);
      if (account != null) {
        return account;
      }else{
        return null;
      }
    }catch(e, s){
        state = AsyncValue.error(e, s);
        rethrow;
    }
  }

  Future<void> updateAnAccount(Account account) async {
    state = const AsyncValue.loading();
    try{
      await _updateAccountCase(account);
      _loadAccounts();
    }catch(e,s){
        state = AsyncValue.error(e, s);
    }
  }

  Future<void> deleteAnAccount(int accountId) async {
    state = const AsyncLoading();
    try{
      await _deleteAccount(accountId);
      _loadAccounts();
    }catch(e, s){
      state = AsyncValue.error(e, s);
    }
  }

}
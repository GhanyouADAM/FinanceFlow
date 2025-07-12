

import 'package:the_app/data/datasource/database_helper.dart';
import 'package:the_app/data/models/account_model.dart';
import 'package:the_app/domain/entities/account.dart';
import 'package:the_app/domain/repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  final DatabaseHelper _source;
  AccountRepositoryImpl(this._source);
  @override
  Future<void> addAccount(String name) async {
    final account = Account(name: name);
    final model = AccountModel.fromEntity(account);
      await _source.addAccount(model);

  }

  @override
  Future<void> deleteAccount(int id) async{
    await _source.deleteAccount(id);
  }

  @override
  Future<Account?> getAccount() async{
    final model = await _source.getAccount();
    final account = model?.toAccount();
    return account;
  }

  @override
  Future<void> updateAccount(Account account) async {
   final model = AccountModel.fromEntity(account);
   await _source.updateAccount(model);
  }

}
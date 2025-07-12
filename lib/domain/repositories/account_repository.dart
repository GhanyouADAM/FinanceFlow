import 'package:the_app/domain/entities/account.dart';

abstract class AccountRepository {
 // Future<List<Account>> getAccounts();

  Future<Account?> getAccount();

  Future<void> addAccount(String name);

  Future<void> updateAccount(Account account);

  Future<void> deleteAccount(int id);


}

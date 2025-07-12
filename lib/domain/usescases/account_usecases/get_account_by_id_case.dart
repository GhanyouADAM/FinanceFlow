import 'package:the_app/domain/repositories/account_repository.dart';

import '../../entities/account.dart';

class GetAccountByIdCase {
  final AccountRepository _accRepository;

  GetAccountByIdCase(this._accRepository);

  Future<Account?> call() async =>
      await _accRepository.getAccount();
}

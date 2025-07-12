import 'package:the_app/domain/repositories/account_repository.dart';

import '../../entities/account.dart';

class UpdateAccountCase {
  final AccountRepository _accRepository;

  UpdateAccountCase(this._accRepository);

  Future<void> call(Account account) async =>
      await _accRepository.updateAccount(account);
}

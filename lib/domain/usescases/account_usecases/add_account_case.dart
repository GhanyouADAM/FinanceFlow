import 'package:the_app/domain/repositories/account_repository.dart';

class AddAccountCase {
  final AccountRepository _accRepository;

  AddAccountCase(this._accRepository);

  Future<void> call(String name) async => await _accRepository.addAccount(name);
}

import 'package:the_app/domain/repositories/account_repository.dart';

class DeleteAccountCase {
  final AccountRepository _accRepository;

  DeleteAccountCase(this._accRepository);

  Future<void> call(int id) async => await _accRepository.deleteAccount(id);
}

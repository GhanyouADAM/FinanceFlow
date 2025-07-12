

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_app/core/provider/account_provider.dart';
import 'package:the_app/presentation/providers/transaction/usecases/transaction_usecases_provider.dart';

final summaryAsyncProvider = FutureProvider<Map<String, double>>((ref) async{
final account = ref.watch(currentAccountProvider);
final loader = ref.watch(getSummaryCaseProvider);
if (account == null) {
  throw Exception('account not available for summary');
}
return await loader.call(account.accountId!);
});


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:the_app/core/provider/account_provider.dart';
import 'package:the_app/presentation/pages/utils/error_screen.dart';
import 'package:the_app/presentation/pages/utils/loading_screen.dart';
import 'package:the_app/presentation/providers/account/account_provider.dart';


class LaunchScreen extends ConsumerStatefulWidget {
  const LaunchScreen({super.key});

  @override
  ConsumerState<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends ConsumerState<LaunchScreen> {
  @override
  Widget build(BuildContext context) {
    final account = ref.watch(accountViewModelProvider);
    return  account.when(
        data: (account){
         WidgetsBinding.instance.addPostFrameCallback((_){
           if (account == null) {
            context.go('/create-account');
          }else{
            ref.read(currentAccountProvider.notifier).state =account;
            ref.read(authStateProvider.notifier).state = true;
            context.go('/home', extra: account);
          }
         });
         return LoadingScreen();
        },
         error: (e, s)=> ErrorScreen(error: e.toString()),
          loading: ()=> LoadingScreen());
  }
}
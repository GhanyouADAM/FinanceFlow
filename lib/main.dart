import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_app/core/provider/account_provider.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:the_app/core/provider/theme_provider.dart';
import 'package:the_app/core/services/version_service.dart';
import 'package:the_app/core/theme/theme.dart';
import 'package:the_app/presentation/pages/widgets/welcome_dialog.dart';
import 'package:the_app/presentation/providers/go_router_provider.dart';
import 'package:intl/date_symbol_data_local.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('fr_FR', null);
  // sqfliteFfiInit();
  // databaseFactory = databaseFactoryFfi;
  runApp(ProviderScope(child: const BudgetBuddyApp()));
}
class BudgetBuddyApp extends ConsumerStatefulWidget {
  const BudgetBuddyApp({super.key});
  @override
  ConsumerState<BudgetBuddyApp> createState() => _BudgetBuddyAppState();
}
class _BudgetBuddyAppState extends ConsumerState<BudgetBuddyApp> {
  final VersionService _versionService = VersionService();
@override
  void initState() {
    super.initState();
    //Quicly check the app's version after the launch
  WidgetsBinding.instance.addPostFrameCallback((_){
        _checkAppVersion();
  });
  }
  
  Future<void> _checkAppVersion() async {
    final prefs = await SharedPreferences.getInstance();
    final hasShownDialogThisSession = prefs.getBool('shown_dialog_this_session') ?? false;
  //to avoid showing it a second time
    if(!hasShownDialogThisSession){
      final isFirstLaunch = await _versionService.isFirstLaunch();
      final isUpdated = await _versionService.isAppUpdated();

      //check weather  it's first launch or an update
      if(isFirstLaunch || isUpdated){
        final packageInfo = await PackageInfo.fromPlatform();

        //wait for the navigation system to be initalized
        Future.delayed(Duration(seconds: 2), (){
          if(mounted){
            _showWelcomeDialog(isFirstLaunch, packageInfo.version);
            prefs.setBool('shown_dialog_this_session', true);
          }
        });
      }
    }
  }
 void _showWelcomeDialog(bool isFirstLaunch, String version) {
  showDialog(
      context: context,
      builder: (context) => WelcomeDialog(isFirstLaunch: isFirstLaunch, appVersion: version)
  );
 }


  @override
  Widget build(BuildContext context) {
  final selectedColor = ref.watch(colorProvider);
    final themeModeAsync = ref.watch(themeModeProvider);
    final themeMode = themeModeAsync.value ?? ThemeMode.light;
    final router = ref.watch(goRouterProvider);
      ref.listen<bool>(authStateProvider, (previous, current){
            //if user just connected(changing state from false to true)
            if(previous == false && current  == true){
            _checkAppVersion();
            }
          });
    
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: AppTheme.getLightTheme(selectedColor).copyWith(
        primaryColor: selectedColor,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      darkTheme: AppTheme.getDarkTheme(selectedColor).copyWith(
        textTheme: GoogleFonts.poppinsTextTheme().copyWith(
          headlineSmall: TextStyle(color: Colors.white60),
          bodyLarge: TextStyle(color: Colors.white60),
          bodyMedium: TextStyle(color: Colors.white60),
          bodySmall: TextStyle(color: Colors.white60),
        ),
      ),
      themeMode: themeMode,
    );
  }
}
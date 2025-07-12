import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:the_app/core/provider/account_provider.dart';
import 'package:the_app/core/theme/build_extension.dart';
import 'package:the_app/domain/entities/account.dart';
import 'package:the_app/presentation/pages/account/account_screen.dart';
import 'package:the_app/presentation/pages/account/account_creation_screen.dart';
import 'package:the_app/presentation/pages/category/add_category_screen.dart';
import 'package:the_app/presentation/pages/category/category_screen.dart';
import 'package:the_app/presentation/pages/history/history_screen.dart';
import 'package:the_app/presentation/pages/home/home_screen.dart';
import 'package:the_app/presentation/pages/launch_screen.dart';
import 'package:the_app/presentation/pages/settings/settings_screen.dart';
import 'package:the_app/presentation/pages/transactions/add_transaction.dart';



//the molder screen
class ScreenMolder extends StatefulWidget{
  const ScreenMolder({
    Key? key,
    required this.navigationShell
  }) : super (
    key: key ?? const ValueKey<String>('screenMolder')
  );

  final StatefulNavigationShell navigationShell;

  @override
  State<ScreenMolder> createState() => _ScreenMolderState();
}

class _ScreenMolderState extends State<ScreenMolder> {
  int _previousIndex = 0;

  @override
  Widget build(context){
    final int currentIndex = widget.navigationShell.currentIndex;
    final double direction = currentIndex > _previousIndex ? 1 : -1;
    _previousIndex = currentIndex;
    return Scaffold(
      body: widget.navigationShell.animate(
        key: ValueKey(currentIndex)
      ).slideX(begin: direction),
      bottomNavigationBar: CurvedNavigationBar(
        color: context.colorScheme.surface,
        backgroundColor: context.colorScheme.primary,
        items: [
          CurvedNavigationBarItem(
            child: Icon(Icons.home_outlined),
            // label: 'Accueil',
            // labelStyle: context.textTheme.bodySmall
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.history),
            // label: 'Historique',
            //  labelStyle: context.textTheme.bodySmall
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.add),
            // label: 'Transactions',
            //  labelStyle: context.textTheme.bodySmall
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.category_rounded),
            // label: 'Catégories',
            //  labelStyle: context.textTheme.bodySmall
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.settings),
            // label: 'Paramètres',
            //  labelStyle: context.textTheme.bodySmall
          ),
        ],
        onTap: (index) {
           widget.navigationShell.goBranch(
                    index,
                    initialLocation: index == widget.navigationShell.currentIndex
                );
        },
      ),


      // bottomNavigationBar: GNav(
        
      //   selectedIndex: 2,
      //   padding: EdgeInsets.symmetric(horizontal: 13, vertical: 17),
      //     onTabChange: (index){
      //       navigationShell.goBranch(
      //           index,
      //           initialLocation: index == navigationShell.currentIndex
      //       );
      //     },
      //     tabs: [
      //   GButton(icon: Icons.home, text: 'Accueil',),
      //   GButton(icon: Icons.history, text: 'Historique',),
      //   GButton(icon: Icons.add, text: 'Transaction',),
      //   GButton(icon: Icons.category, text: 'Categories',),
      //   GButton(icon: Icons.settings, text: 'Paramètres',)
      // ]),
    );
  }
}

// these keys helps maintain the state of each sections of the bottom navbar
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellHomeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final GlobalKey<NavigatorState> _shellHistoryNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'history');
final GlobalKey<NavigatorState> _shellTransactionNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'transaction');
final GlobalKey<NavigatorState> _shellCategoryNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'category');
final GlobalKey<NavigatorState> _shellSettingsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'settings');

final goRouterProvider =  Provider<GoRouter>((ref){
  return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/',
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
            path: '/',
            name: 'launcher',
            builder: (context, state) => const LaunchScreen(),
        ),
        GoRoute(
          path: '/create-account',
          builder: (context, state) => const AccountCreationScreen(),
        ),
        StatefulShellRoute.indexedStack(
            builder: (context, state, navigationShell){
              return ScreenMolder(navigationShell: navigationShell);
            },
            branches: [
              //-----------home section----------
              StatefulShellBranch(
                  navigatorKey: _shellHomeNavigatorKey,
                  routes: [
                    GoRoute(
                        path: '/home',
                        name: 'home',
                        builder: (context, state) {
                          final account = ref.watch(currentAccountProvider);
                          if (account == null) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return HomeScreen(currentAccount: account);
                        },
                        routes: [
                          GoRoute(
                            path: 'accountDetails',
                            name: 'account_details',
                            pageBuilder: (context, state) {
                              final account = state.extra as Account;
                              return CustomTransitionPage(
                                key: state.pageKey,
                                child: AccountDetailsScreen(account: account),
                                transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                                  FadeTransition(opacity: animation, child: child),
                              );
                            },
                          )
                        ]
                    )
                  ]),
              //--------history section-----------
              StatefulShellBranch(
                  navigatorKey: _shellHistoryNavigatorKey,
                  routes: [
                  GoRoute(
                      path: '/history',
                      name: 'history',
                      builder: (context, state) => const HistoryScreen(),
                  )
              ]),
              //--------transaction section ---------------
              StatefulShellBranch(
                  navigatorKey: _shellTransactionNavigatorKey,
                  routes: [
                    GoRoute(
                      path: '/transaction',
                      name: 'transaction',
                      builder: (context, state) => const AddTransaction(),
                    )
                  ]),
              //--------------category section--------
              StatefulShellBranch(
                  navigatorKey: _shellCategoryNavigatorKey,
                  routes: [
                    GoRoute(
                        path: '/category',
                        name: 'category',
                        builder: (context, state) => const CategoryScreen(),
                        routes: [
                          GoRoute(
                              path: 'addCategory',
                              name: 'new_category',
                              builder: (context, state)=> const AddCategoryScreen(),
                          )
                        ]
                    )
                  ]),
              //------------settings section -------
              StatefulShellBranch(
                  navigatorKey: _shellSettingsNavigatorKey,
                  routes: [
                GoRoute(
                    path: '/settings',
                  name: 'settings',
                  builder: (context, state) => const SettingsScreen(),
                )
              ])
            ])
      ]);
});
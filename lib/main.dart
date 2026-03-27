import 'package:flutter/material.dart';
import 'package:sub_rosa/ui/translate.dart';
import 'package:go_router/go_router.dart';
import 'package:sub_rosa/ui/settings.dart';
import 'package:provider/provider.dart';
import 'package:sub_rosa/storage/storage.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppTheme())
      ],
      child: Rosa()
    )
  );
}

class Rosa extends StatelessWidget {
  const Rosa({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,   
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/translate',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainScaffold(navigationShell: navigationShell);
      },
      branches: [
        
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/translate',
              builder: (context, state) => const Center(child: Translate()),
            ),
          ],
        ),
       
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/history',
              builder: (context, state) => const Center(child: Settings()),
            ),
          ],
        ),
        
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => const Center(child: Text('Settings Screen')),
            ),
          ],
        ),
      ],
    ),
  ],
);

class MainScaffold extends StatelessWidget {
  const MainScaffold({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {

    final theme = context.watch<AppTheme>();

    return Scaffold(
      body: navigationShell, 
      backgroundColor: theme.isDarkMode ? const Color.fromARGB(255, 2, 3, 71) : Colors.white,
      appBar: AppBar(
        title: Text("Sub Rosa"),
        backgroundColor: theme.isDarkMode ? const Color.fromARGB(255, 3, 5, 105) : Color.fromARGB(255, 238, 181, 181),
        actions: [
          IconButton(
            onPressed: () {context.read<AppTheme>().changeTheme();
          }, 
            icon: Icon(Icons.dark_mode)    
          )
        ]
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: theme.isDarkMode ? const Color.fromARGB(255, 3, 5, 105) : Color.fromARGB(255, 238, 181, 181),
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (int index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.translate), label: 'Translate'),
          NavigationDestination(icon: Icon(Icons.history), label: 'History'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
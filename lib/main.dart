import 'package:flutter/material.dart';
import 'package:sub_rosa/ui/translate.dart';
import 'package:go_router/go_router.dart';
import 'package:sub_rosa/ui/settings.dart';


void main() {
  runApp(Rosa());
}

class Rosa extends StatelessWidget {
  const Rosa({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
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
    return Scaffold(
      body: navigationShell, 
      bottomNavigationBar: NavigationBar(
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
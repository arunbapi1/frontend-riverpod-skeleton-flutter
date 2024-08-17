import 'package:architecture_demo/Screens/another_screen.dart';
import 'package:architecture_demo/Screens/screen_one.dart';
import 'package:architecture_demo/provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final auth = ref.watch(authProvider);

  return GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => CounterScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => AnotherScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => auth ? CounterScreen() : AnotherScreen(),
      ),
    ],
  );
});

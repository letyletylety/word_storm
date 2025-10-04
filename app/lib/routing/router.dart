import 'package:app/ui/game/widgets/game_screen.dart';
import 'package:app/ui/main/main_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const MainScreen()),
    GoRoute(path: '/game', builder: (context, state) => const GameScreen()),
  ],
);

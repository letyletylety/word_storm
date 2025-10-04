import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Word Storm')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                context.go('/game');
              },
              child: const Text('New Game'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // context.go('/high_scores');
              },
              child: const Text('High Scores'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // context.go('/settings');
              },
              child: const Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}

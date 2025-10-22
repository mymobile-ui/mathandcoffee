import 'package:flutter/material.dart';

import 'angle_quiz_screen.dart';

class TrigSubtopicsScreen extends StatelessWidget {
  const TrigSubtopicsScreen({super.key});

  static const routeName = 'trig-subtopics';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trigonometri Alt Konuları'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.change_history),
            title: const Text('Açılar'),
            subtitle: const Text('Açılarla ilgili çalışmaları başlatın.'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const AnglesQuizScreen(),
                settings: const RouteSettings(name: AnglesQuizScreen.routeName),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'trig_subtopics_screen.dart';

class AytTopicsScreen extends StatelessWidget {
  const AytTopicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AYT Konuları'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.calculate_outlined),
            title: const Text('Trigonometri'),
            subtitle: const Text('Trigonometri alt konularını keşfedin.'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const TrigSubtopicsScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

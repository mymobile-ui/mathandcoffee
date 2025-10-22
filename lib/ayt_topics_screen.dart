import 'package:flutter/material.dart';

import 'trig_subtopics_screen.dart';

class AytTopicsScreen extends StatelessWidget {
  const AytTopicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('AYT Konuları'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: colorScheme.secondaryContainer,
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListTile(
              leading: Icon(
                Icons.calculate_outlined,
                color: colorScheme.secondary,
              ),
              title: Text(
                'Trigonometri',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: colorScheme.onSecondaryContainer,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                'Trigonometri alt konularını keşfedin.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSecondaryContainer.withOpacity(0.8),
                ),
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: colorScheme.onSecondaryContainer,
              ),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const TrigSubtopicsScreen(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

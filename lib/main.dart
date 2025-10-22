import 'package:flutter/material.dart';

import 'track_select_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const pastelIndigo = Color(0xFF5C6BC0);
    const pastelTeal = Color(0xFF4DB6AC);

    final baseScheme = ColorScheme.fromSeed(
      seedColor: pastelIndigo,
      brightness: Brightness.light,
    );

    final colorScheme = baseScheme.copyWith(
      secondary: pastelTeal,
      onSecondary: Colors.white,
      secondaryContainer: const Color(0xFFD0F2EE),
      onSecondaryContainer: const Color(0xFF0F4F4B),
      tertiary: const Color(0xFF80CBC4),
      onTertiary: const Color(0xFF003E36),
      tertiaryContainer: const Color(0xFFCDEAE7),
      onTertiaryContainer: const Color(0xFF0C3C36),
    );

    return MaterialApp(
      title: 'Math & Coffee',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: colorScheme.surface,
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.primaryContainer,
          foregroundColor: colorScheme.onPrimaryContainer,
          centerTitle: true,
          elevation: 0,
        ),
      ),
      home: const TrackSelectScreen(),
    );
  }
}

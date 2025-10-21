import 'package:flutter/material.dart';

class TrackSelectScreen extends StatelessWidget {
  const TrackSelectScreen({super.key});

  static final List<_TrackOption> _tracks = [
    _TrackOption(
      title: 'AYT',
      subtitle: 'Sınava hazırlığa başlayın.',
      icon: Icons.calculate,
      isAvailable: true,
    ),
    _TrackOption(
      title: 'IB',
      subtitle: '(Bu seviye yakında)',
      icon: Icons.public,
      isAvailable: false,
    ),
    _TrackOption(
      title: 'IGCSE',
      subtitle: '(Bu seviye yakında)',
      icon: Icons.language,
      isAvailable: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceVariant.withOpacity(0.2),
      appBar: AppBar(
        title: const Text('Programını Seç'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth >= 900
                ? 4
                : constraints.maxWidth >= 600
                    ? 3
                    : 2;

            return GridView.builder(
              itemCount: _tracks.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 4 / 3,
              ),
              itemBuilder: (context, index) {
                final track = _tracks[index];
                final onTap = track.isAvailable
                    ? () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const _AytTrackScreen(),
                          ),
                        )
                    : null;

                return _TrackCard(track: track, onTap: onTap);
              },
            );
          },
        ),
      ),
    );
  }
}

class _TrackOption {
  const _TrackOption({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isAvailable,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool isAvailable;
}

class _TrackCard extends StatelessWidget {
  const _TrackCard({required this.track, required this.onTap});

  final _TrackOption track;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final backgroundColor = track.isAvailable
        ? colorScheme.surface
        : colorScheme.surfaceVariant.withOpacity(0.6);
    final foregroundColor = track.isAvailable
        ? colorScheme.onSurface
        : colorScheme.onSurfaceVariant;

    return Material(
      color: backgroundColor,
      elevation: track.isAvailable ? 2 : 0,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                track.icon,
                size: 52,
                color: track.isAvailable
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 18),
              Text(
                track.title,
                style: theme.textTheme.titleLarge?.copyWith(
                  color: foregroundColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                track.subtitle,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: foregroundColor.withOpacity(0.8),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AytTrackScreen extends StatelessWidget {
  const _AytTrackScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AYT Akışı'),
      ),
      body: const Center(
        child: Text('AYT akışı burada başlayacak.'),
      ),
    );
  }
}

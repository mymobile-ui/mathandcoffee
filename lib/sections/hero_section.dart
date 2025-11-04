import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/common.dart';

/// Hero banner introducing the brand and highlighting the main CTA.
class HeroSection extends StatelessWidget {
  const HeroSection({super.key, required this.onCtaTap});

  final VoidCallback onCtaTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 800;
        final Widget introColumn = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'mathandcoffe — Matematik Özel Ders',
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.w800,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Analitik düşünme, sınav stratejisi ve kişiye göre uyarlanan matematik programları ile TYT/AYT ve okul derslerinde hedeflerinize ulaşın.',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
            Wrap(
              spacing: 16,
              runSpacing: 12,
              children: [
                PrimaryButton(
                  label: 'WhatsApp’tan Yaz',
                  icon: FontAwesomeIcons.whatsapp,
                  onPressed: onCtaTap,
                ),
                OutlinedButton(
                  onPressed: onCtaTap,
                  child: const Text('Seviyeni Konuşalım'),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: const [
                TagChip(label: 'Kişiselleştirilmiş plan'),
                TagChip(label: 'Güncel soru tarzları'),
                TagChip(label: 'Dijital takip'),
              ],
            ),
          ],
        );

        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 32,
            vertical: isMobile ? 32 : 48,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.primary.withOpacity(0.1),
                theme.colorScheme.primary.withOpacity(0.04),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isMobile)
                introColumn
              else
                Expanded(
                  flex: 2,
                  child: introColumn,
                ),
              if (!isMobile) const SizedBox(width: 48),
              if (isMobile)
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: _HeroDetailsCard(theme: theme),
                )
              else
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: _HeroDetailsCard(theme: theme),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

/// Supplementary card that lists differentiators alongside the hero text.
class _HeroDetailsCard extends StatelessWidget {
  const _HeroDetailsCard({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Neden mathandcoffe?',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            const _HeroBullet(
              icon: FontAwesomeIcons.lightbulb,
              text:
                  'Konuları kavratan, hızlı tekrar ve deneme analizleri ile süre yönetimi kazandıran ders akışı.',
            ),
            const SizedBox(height: 12),
            const _HeroBullet(
              icon: FontAwesomeIcons.chartSimple,
              text:
                  'Tüm sınıf seviyeleri için veri takipli soru bankası yönlendirmeleri ve haftalık raporlar.',
            ),
            const SizedBox(height: 12),
            const _HeroBullet(
              icon: FontAwesomeIcons.userCheck,
              text: 'Öğrencinin motivasyonunu yüksek tutan mentorluk ve sınav psikolojisi desteği.',
            ),
          ],
        ),
      ),
    );
  }
}

/// A single highlight row with icon used inside the hero details card.
class _HeroBullet extends StatelessWidget {
  const _HeroBullet({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: theme.colorScheme.primary, size: 18),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            text,
            style: theme.textTheme.bodyLarge?.copyWith(height: 1.5),
          ),
        ),
      ],
    );
  }
}

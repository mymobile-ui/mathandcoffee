import 'package:flutter/material.dart';

import '../widgets/common.dart';

/// Lists lise sınıfları ve kişiselleştirilmiş matematik planlarını özetler.
class HighSchoolSection extends StatelessWidget {
  const HighSchoolSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Map<String, List<String>> classTopics = {
      '9. Sınıf': ['Temel Kavramlar', 'Kümeler', 'Denklemler', 'Oran-Orantı'],
      '10. Sınıf': ['Fonksiyonlar', 'Trigonometri', 'Polinomlar', 'İkinci Dereceden Denklemler'],
      '11. Sınıf': ['Türev', 'Limit', 'Logaritma', 'Diziler'],
      '12. Sınıf': ['İntegral', 'Türev Uygulamaları', 'Analitik Geometri', 'Olasılık'],
    };

    final plans = [
      const InfoCard(
        icon: Icons.schedule_outlined,
        title: 'Haftalık 2 Oturum',
        description: 'Her derste konu anlatımı + soru çözümü ve dijital ödev takibi.',
      ),
      const InfoCard(
        icon: Icons.group_outlined,
        title: 'Okul Sınav Desteği',
        description: 'Sınav öncelerinde ders programı uyarlaması ve hedef odaklı tekrar.',
      ),
      const InfoCard(
        icon: Icons.laptop_mac_outlined,
        title: 'Canlı Çözümler',
        description: 'Online platform üzerinden interaktif soru çözümü ve geri bildirim.',
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeading(
            title: 'Lise Matematik',
            subtitle: '9-12. sınıflar için konu takibi, yazılı hazırlık ve sınav geçiş planlaması.',
          ),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 900;
              final gradeWrap = Wrap(
                spacing: 16,
                runSpacing: 16,
                children: classTopics.entries
                    .map(
                      (entry) => _ClassCard(
                        title: entry.key,
                        topics: entry.value,
                      ),
                    )
                    .toList(),
              );

              final planColumn = Padding(
                padding: EdgeInsets.only(top: isNarrow ? 24 : 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kişiselleştirilmiş lise programı',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Okul müfredatını ve sınav takviminizi baz alan çalışma planı ile eksik kaldığınız başlıkları hızla tamamlıyoruz.',
                      style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
                    ),
                    const SizedBox(height: 24),
                    ...plans.map((plan) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: plan,
                        )),
                  ],
                ),
              );

              return Flex(
                direction: isNarrow ? Axis.vertical : Axis.horizontal,
                crossAxisAlignment:
                    isNarrow ? CrossAxisAlignment.start : CrossAxisAlignment.stretch,
                children: [
                  if (isNarrow)
                    gradeWrap
                  else
                    Expanded(flex: 2, child: gradeWrap),
                  if (!isNarrow) const SizedBox(width: 32),
                  if (isNarrow)
                    planColumn
                  else
                    Expanded(child: planColumn),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Visualizes konu başlıkları for a single high school grade.
class _ClassCard extends StatelessWidget {
  const _ClassCard({required this.title, required this.topics});

  final String title;
  final List<String> topics;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 260,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: theme.colorScheme.primary.withOpacity(0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          ...topics.map(
            (topic) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      topic,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

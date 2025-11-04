import 'package:flutter/material.dart';

import '../widgets/common.dart';

class TYTAYTSection extends StatelessWidget {
  const TYTAYTSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final topics = [
      'Sayılar',
      'Fonksiyonlar',
      'Trigonometri',
      'Limit',
      'Türev',
      'İntegral',
      'Analitik Geometri',
      'Olasılık',
    ];

    final advantages = [
      const InfoCard(
        icon: Icons.timer_outlined,
        title: 'Deneme Analizi',
        description:
            'Her denemeden sonra süre ve net analizi yaparak eksik konuları hızlıca kapatıyoruz.',
      ),
      const InfoCard(
        icon: Icons.psychology_alt_outlined,
        title: 'Soru Tipi Kampı',
        description:
            'Güncel ÖSYM tarzı sorularla konu başına kısa, odaklı kamp setleri oluşturuyoruz.',
      ),
      const InfoCard(
        icon: Icons.auto_graph_outlined,
        title: 'İlerleme Grafikleri',
        description:
            'Haftalık hedef takibi ve dijital raporlarla gelişiminizi net şekilde görüyorsunuz.',
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeading(
            title: 'TYT/AYT Matematik',
            subtitle:
                'Temelden sona kadar konu hakimiyeti, problem çözme stratejileri ve sınav temposu.',
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: topics.map((topic) => TagChip(label: topic)).toList(),
          ),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 800;
              return Wrap(
                spacing: 24,
                runSpacing: 24,
                children: advantages
                    .map(
                      (card) => SizedBox(
                        width: isMobile
                            ? double.infinity
                            : (constraints.maxWidth - 48) / 3,
                        child: card,
                      ),
                    )
                    .toList(),
              );
            },
          ),
          const SizedBox(height: 24),
          Text(
            'Programda düzenli TYT-AYT geçişi ile temel kavramları pekiştirip ileri matematik sorularını hızla çözer hale gelmenizi hedefliyoruz.',
            style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
          ),
        ],
      ),
    );
  }
}

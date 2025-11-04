import 'package:flutter/material.dart';

import '../widgets/common.dart';

class MiddleSchoolSection extends StatelessWidget {
  const MiddleSchoolSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final topics = [
      'Doğal Sayılar',
      'Kesirler',
      'Ondalık Gösterim',
      'Oran Orantı',
      'Yüzdeler',
      'Temel Geometri',
      'Çember ve Çokgenler',
      'Veri Analizi',
      'Eşitlik ve Denklem',
    ];

    final highlights = [
      const InfoCard(
        icon: Icons.school_outlined,
        title: 'Temel Pekiştirme',
        description:
            'Soru çözümünde kullanılan yöntemleri modelleyerek kavramların kalıcı olmasını sağlıyoruz.',
      ),
      const InfoCard(
        icon: Icons.extension_outlined,
        title: 'Oyunlaştırılmış Alıştırma',
        description:
            'Seviyeye göre seçilen etkinliklerle matematiği eğlenceli hale getiriyoruz.',
      ),
      const InfoCard(
        icon: Icons.auto_fix_high_outlined,
        title: 'Sınavlara Hazırlık',
        description: 'LGS ve okul yazılılarına yönelik tarama testleri ile motivasyonu artırıyoruz.',
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeading(
            title: 'Ortaokul Matematik',
            subtitle:
                '5-8. sınıflar için temel becerileri geliştiren, merak uyandıran ve seviyeye göre ilerleyen dersler.',
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
              final isMobile = constraints.maxWidth < 780;
              return Wrap(
                spacing: 24,
                runSpacing: 24,
                children: highlights
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
            'Matematiği keşfederek öğrenmeleri için birebir motivasyon, düzenli velî bilgilendirmesi ve oyun temelli tekrarlarla öğrencilerimizin özgüvenini yükseltiyoruz.',
            style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
          ),
        ],
      ),
    );
  }
}

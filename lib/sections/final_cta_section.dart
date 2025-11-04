import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/common.dart';

/// Final communication band encouraging visitors to reach out via WhatsApp.
class FinalCTASection extends StatelessWidget {
  const FinalCTASection({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withOpacity(0.12),
            theme.colorScheme.primary.withOpacity(0.04),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(32),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 720;
          return Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment:
                      isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Seviyenize göre plan çıkaralım',
                      textAlign: isMobile ? TextAlign.center : TextAlign.start,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Matematikte hangi seviyede olursanız olun, hedefinize uygun kişisel rota için hemen WhatsApp’tan yazın.',
                      textAlign: isMobile ? TextAlign.center : TextAlign.start,
                      style: theme.textTheme.bodyLarge?.copyWith(height: 1.6),
                    ),
                  ],
                ),
              ),
              SizedBox(height: isMobile ? 24 : 0, width: isMobile ? 0 : 32),
              PrimaryButton(
                label: 'WhatsApp’tan Yazın',
                icon: FontAwesomeIcons.whatsapp,
                onPressed: onTap,
              ),
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'sections/final_cta_section.dart';
import 'sections/hero_section.dart';
import 'sections/highschool_section.dart';
import 'sections/middleschool_section.dart';
import 'sections/tyt_ayt_section.dart';
import 'site.dart';
import 'theme.dart';
import 'widgets/common.dart';

class MathAndCoffeApp extends StatelessWidget {
  const MathAndCoffeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'mathandcoffe — Matematik Özel Ders',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
          PointerDeviceKind.stylus,
          PointerDeviceKind.invertedStylus,
        },
      ),
      home: const _LandingPage(),
    );
  }
}

class _LandingPage extends StatefulWidget {
  const _LandingPage();

  @override
  State<_LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<_LandingPage> {
  // Controls animated jumps between sections triggered from the navigation.
  final ScrollController _scrollController = ScrollController();

  // Each section uses a dedicated GlobalKey so we can calculate its offset.
  final GlobalKey _scrollViewKey = GlobalKey(debugLabel: 'landing-scroll-view');
  final GlobalKey _tytKey = GlobalKey(debugLabel: 'tyt-ayt-section');
  final GlobalKey _highSchoolKey = GlobalKey(debugLabel: 'highschool-section');
  final GlobalKey _middleSchoolKey = GlobalKey(debugLabel: 'middleschool-section');

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _openWhatsApp() async {
    final uri = Uri.parse(SiteInfo.whatsappUrl);
    if (!await launchUrl(uri,
        mode: LaunchMode.externalApplication, webOnlyWindowName: '_blank')) {
      debugPrint('WhatsApp link açılırken bir sorun oluştu: $uri');
    }
  }

  // Smoothly animate the viewport so the requested section is aligned.
  void _scrollTo(GlobalKey key) {
    final BuildContext? targetContext = key.currentContext;
    final BuildContext? scrollContext = _scrollViewKey.currentContext;
    if (targetContext == null || scrollContext == null) {
      return;
    }
    if (!_scrollController.hasClients) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollTo(key));
      return;
    }

    final RenderObject? targetRenderObject = targetContext.findRenderObject();
    final RenderObject? scrollRenderObject = scrollContext.findRenderObject();
    if (targetRenderObject is! RenderBox || scrollRenderObject is! RenderBox) {
      return;
    }
    final RenderBox targetBox = targetRenderObject;
    final RenderBox scrollBox = scrollRenderObject;
    final double targetOffset = _scrollController.offset +
        targetBox.localToGlobal(Offset.zero, ancestor: scrollBox).dy;

    final double clampedOffset = targetOffset
        .clamp(0, _scrollController.position.maxScrollExtent)
        .toDouble();

    _scrollController.animateTo(
      clampedOffset,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool isMobile = constraints.maxWidth < 900;
        final EdgeInsets bodyPadding = EdgeInsets.symmetric(
          horizontal: isMobile ? 20 : 80,
          vertical: isMobile ? 24 : 40,
        );

        // Keep navigation order aligned with design brief: TYT/AYT, Lise, Ortaokul.
        final navigationItems = [
          _NavItem(
            label: 'TYT/AYT',
            onTap: () => _scrollTo(_tytKey),
          ),
          _NavItem(
            label: '9 10 11 12. Sınıf',
            onTap: () => _scrollTo(_highSchoolKey),
          ),
          _NavItem(
            label: '5 6 7 8. Sınıf',
            onTap: () => _scrollTo(_middleSchoolKey),
          ),
        ];

        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Theme.of(context).colorScheme.background,
            surfaceTintColor: Colors.transparent,
            title: Text(
              SiteInfo.brandName,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            centerTitle: false,
            actions: isMobile
                ? [
                    Builder(
                      builder: (context) => IconButton(
                        icon: const Icon(Icons.menu_rounded),
                        onPressed: () => Scaffold.of(context).openEndDrawer(),
                        tooltip: 'Menüyü aç',
                      ),
                    ),
                  ]
                : [
                    ...navigationItems.map(
                      (item) => TextButton(
                        onPressed: item.onTap,
                        child: Text(item.label),
                      ),
                    ),
                    const SizedBox(width: 12),
                    PrimaryButton(
                      label: 'WhatsApp’tan Yaz',
                      onPressed: _openWhatsApp,
                    ),
                    const SizedBox(width: 24),
                  ],
          ),
          endDrawer: isMobile
              ? Drawer(
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                              SiteInfo.brandName,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Divider(),
                          ...navigationItems.map(
                            (item) => ListTile(
                              title: Text(item.label),
                              onTap: () {
                                Navigator.of(context).maybePop();
                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  item.onTap();
                                });
                              },
                            ),
                          ),
                          const Spacer(),
                          PrimaryButton(
                            label: 'WhatsApp’tan Yaz',
                            onPressed: () {
                              Navigator.of(context).maybePop();
                              _openWhatsApp();
                            },
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                )
              : null,
          body: SafeArea(
            child: SingleChildScrollView(
              key: _scrollViewKey,
              controller: _scrollController,
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: bodyPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    HeroSection(onCtaTap: _openWhatsApp),
                    const SizedBox(height: 72),
                    SectionContainer(
                      key: _tytKey,
                      child: const TYTAYTSection(),
                    ),
                    const SizedBox(height: 72),
                    SectionContainer(
                      key: _highSchoolKey,
                      child: const HighSchoolSection(),
                    ),
                    const SizedBox(height: 72),
                    SectionContainer(
                      key: _middleSchoolKey,
                      child: const MiddleSchoolSection(),
                    ),
                    const SizedBox(height: 72),
                    FinalCTASection(onTap: _openWhatsApp),
                    const SizedBox(height: 48),
                    _Footer(onWhatsAppTap: _openWhatsApp),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NavItem {
  const _NavItem({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;
}

class _Footer extends StatelessWidget {
  const _Footer({required this.onWhatsAppTap});

  final VoidCallback onWhatsAppTap;

  @override
  Widget build(BuildContext context) {
    final int currentYear = DateTime.now().year;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Divider(),
        const SizedBox(height: 24),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 24,
          runSpacing: 16,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${SiteInfo.brandName} — Matematik özel ders',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  '© $currentYear mathandcoffe. Tüm hakları saklıdır.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            Wrap(
              spacing: 16,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text('Gizlilik Politikası'),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Aydınlatma Metni'),
                ),
                SocialIcons(
                  icons: const [
                    FontAwesomeIcons.instagram,
                    FontAwesomeIcons.youtube,
                    FontAwesomeIcons.xTwitter,
                  ],
                  links: const [
                    SiteInfo.instagramUrl,
                    SiteInfo.youtubeUrl,
                    SiteInfo.twitterUrl,
                  ],
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 24),
        Align(
          alignment: Alignment.centerRight,
          child: OutlinedButton.icon(
            onPressed: onWhatsAppTap,
            icon: const Icon(FontAwesomeIcons.whatsapp),
            label: const Text('Hemen WhatsApp’tan Yaz'),
          ),
        ),
      ],
    );
  }
}

/// A container with default padding to keep sections aligned and consistent.
class SectionContainer extends StatelessWidget {
  const SectionContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 18,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: child,
    );
  }
}

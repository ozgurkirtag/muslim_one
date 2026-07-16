import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<_HomeFeature> _features = [
    _HomeFeature(
      title: 'Digital Tasbih',
      subtitle: 'Count your dhikr with ease',
      icon: Icons.touch_app_rounded,
    ),
    _HomeFeature(
      title: 'What Should I Recite?',
      subtitle: 'Find a dhikr program for your need',
      icon: Icons.favorite_rounded,
    ),
    _HomeFeature(
      title: 'Prayer Times',
      subtitle: 'Prayer times anywhere in the world',
      icon: Icons.schedule_rounded,
    ),
    _HomeFeature(
      title: 'Qibla Finder',
      subtitle: 'Find the direction of the Kaaba',
      icon: Icons.explore_rounded,
    ),
    _HomeFeature(
      title: 'Asma ul Husna',
      subtitle: 'Discover the 99 names of Allah',
      icon: Icons.auto_awesome_rounded,
    ),
    _HomeFeature(
      title: 'Daily Dhikr',
      subtitle: 'A meaningful reminder for today',
      icon: Icons.menu_book_rounded,
    ),
    _HomeFeature(
      title: 'Settings',
      subtitle: 'Language, sound and preferences',
      icon: Icons.settings_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverPadding(
              padding: EdgeInsets.fromLTRB(20, 22, 20, 12),
              sliver: SliverToBoxAdapter(child: _Header()),
            ),
            const SliverPadding(
              padding: EdgeInsets.fromLTRB(20, 8, 20, 16),
              sliver: SliverToBoxAdapter(child: _DailyReminderCard()),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
              sliver: SliverList.separated(
                itemCount: _features.length,
                itemBuilder: (context, index) {
                  return _FeatureCard(feature: _features[index]);
                },
                separatorBuilder: (_, _) => const SizedBox(height: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.surfaceSoft, AppColors.surface],
        ),
        border: Border.all(color: AppColors.goldDark, width: 1),
      ),
      child: const Row(
        children: [
          _LogoMark(),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.appName,
                  style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  AppStrings.tagline,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.35,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LogoMark extends StatelessWidget {
  const _LogoMark();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.gold, width: 1.5),
        color: AppColors.background,
      ),
      child: const Icon(
        Icons.nightlight_round,
        color: AppColors.goldLight,
        size: 31,
      ),
    );
  }
}

class _DailyReminderCard extends StatelessWidget {
  const _DailyReminderCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.goldDark, width: 0.8),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.auto_awesome_rounded,
                color: AppColors.goldLight,
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                "Today's Reminder",
                style: TextStyle(
                  color: AppColors.goldLight,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          SizedBox(height: 14),
          Text(
            'Indeed, with hardship comes ease.',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Quran 94:6',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({required this.feature});

  final _HomeFeature feature;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: () {
          if (feature.title == 'Digital Tasbih') {
            Navigator.of(context).pushNamed(AppRoutes.digitalTasbih);
            return;
          }

          if (feature.title == 'What Should I Recite?') {
            Navigator.of(context).pushNamed(AppRoutes.recitePrograms);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: AppColors.gold.withValues(alpha: 0.11),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.goldDark, width: 0.8),
                ),
                child: Icon(feature.icon, color: AppColors.goldLight, size: 27),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feature.title,
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge?.copyWith(fontSize: 17),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      feature.subtitle,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 13,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.chevron_right_rounded, color: AppColors.gold),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeFeature {
  const _HomeFeature({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;
}

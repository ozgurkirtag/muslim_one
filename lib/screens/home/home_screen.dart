import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<_HomeFeature> _features = [
    _HomeFeature(
      title: 'Digital Tasbih',
      subtitle: 'Count your dhikr with ease',
      icon: Icons.touch_app_rounded,
    ),
    _HomeFeature(
      title: 'Dhikr Guide',
      subtitle: 'Choose a program for your need',
      icon: Icons.favorite_rounded,
    ),
    _HomeFeature(
      title: 'Prayer Times',
      subtitle: 'Daily prayer times worldwide',
      icon: Icons.mosque_rounded,
    ),
    _HomeFeature(
      title: 'Qibla Finder',
      subtitle: 'Find the direction of the Kaaba',
      icon: Icons.explore_rounded,
    ),
    _HomeFeature(
      title: 'Asma ul Husna',
      subtitle: 'Learn the 99 names of Allah',
      icon: Icons.auto_awesome_rounded,
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
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
              sliver: SliverToBoxAdapter(child: _Header()),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _FeatureCard(feature: _features[index]),
                  childCount: _features.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 14,
                  childAspectRatio: 0.92,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.surfaceSoft, AppColors.surface],
        ),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.22)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.appName,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 8),
          Text(
            AppStrings.tagline,
            style: TextStyle(
              fontSize: 15,
              height: 1.4,
              color: AppColors.textSecondary,
            ),
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
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  feature.icon,
                  color: AppColors.primarySoft,
                  size: 27,
                ),
              ),
              const Spacer(),
              Text(
                feature.title,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontSize: 18),
              ),
              const SizedBox(height: 6),
              Text(
                feature.subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontSize: 13, height: 1.35),
              ),
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

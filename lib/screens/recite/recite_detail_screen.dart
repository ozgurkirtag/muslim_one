import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/localization/app_localization.dart';
import '../../models/dhikr_program.dart';
import '../digital_tasbih/digital_tasbih_screen.dart';

class ReciteDetailScreen extends StatelessWidget {
  const ReciteDetailScreen({required this.program, super.key});

  final DhikrProgram program;

  @override
  Widget build(BuildContext context) {
    final isRtl = AppLocalization.isRtl(context);
    final content = program.content;

    // Kısa zikirler sayaçla tekrar edilebilir.
    // Uzun dualar yalnızca okuma ekranında gösterilir.
    final pronunciation = content.pronunciation.resolve(context).trim();
    final isShortDhikr =
        content.arabic.trim().length <= 55 &&
        pronunciation.length <= 65;

    return Directionality(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(title: Text(program.title.resolve(context))),
        bottomNavigationBar: isShortDhikr
            ? SafeArea(
          minimum: const EdgeInsets.fromLTRB(20, 8, 20, 18),
          child: FilledButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => DigitalTasbihScreen(
                    initialDhikrName: content.name.resolve(context),
                    initialTarget: content.target,
                    startFresh: true,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.touch_app_rounded),
            label: Text(
              AppLocalization.text(context, AppLocalization.startDhikr),
            ),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(56),
              backgroundColor: AppColors.gold,
              foregroundColor: Colors.black,
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17),
              ),
            ),
          ),
        )
            : null,
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
          children: [
            _HeaderCard(program: program),
            const SizedBox(height: 14),
            _InfoCard(
              title: AppLocalization.text(context, AppLocalization.arabicText),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  content.arabic,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.goldLight,
                    fontSize: 29,
                    height: 1.85,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _InfoCard(
              title: AppLocalization.text(
                context,
                AppLocalization.pronunciation,
              ),
              child: Text(
                content.pronunciation.resolve(context),
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  height: 1.6,
                ),
              ),
            ),
            const SizedBox(height: 12),
            _InfoCard(
              title: AppLocalization.text(context, AppLocalization.meaning),
              child: Text(
                content.meaning.resolve(context),
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  height: 1.55,
                ),
              ),
            ),
            const SizedBox(height: 12),
            _InfoCard(
              title: AppLocalization.text(context, AppLocalization.source),
              child: Text(
                content.source.resolve(context),
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 12),
            if (isShortDhikr)
              _TargetCard(target: content.target),
          ],
        ),
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({required this.program});

  final DhikrProgram program;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: AppColors.goldDark),
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.gold.withValues(alpha: 0.13),
              border: Border.all(color: AppColors.goldDark),
            ),
            child: Icon(program.icon, color: AppColors.goldLight, size: 32),
          ),
          const SizedBox(height: 15),
          Text(
            program.title.resolve(context),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 23,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 9),
          Text(
            program.description.resolve(context),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalization.text(context, AppLocalization.recommendedDhikr),
            style: const TextStyle(
              color: AppColors.goldLight,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            program.content.name.resolve(context),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.goldDark.withValues(alpha: 0.72)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              color: AppColors.goldLight,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 11),
          child,
        ],
      ),
    );
  }
}

class _TargetCard extends StatelessWidget {
  const _TargetCard({required this.target});

  final int target;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(19),
      decoration: BoxDecoration(
        color: AppColors.surfaceSoft,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.goldDark),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.track_changes_rounded,
                color: AppColors.goldLight,
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Text(
                  AppLocalization.text(
                    context,
                    AppLocalization.suggestedTarget,
                  ),
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                '$target',
                style: const TextStyle(
                  color: AppColors.goldLight,
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            AppLocalization.text(context, AppLocalization.countNote),
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11.5,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/localization/app_localization.dart';
import '../../data/dhikr_programs.dart';
import '../../models/dhikr_program.dart';
import '../digital_tasbih/digital_tasbih_screen.dart';

class DailyDhikrScreen extends StatelessWidget {
  const DailyDhikrScreen({super.key});

  static const Map<String, String> _titles = {
    'tr': 'Günlük Zikir',
    'en': 'Daily Dhikr',
    'ar': 'الذكر اليومي',
    'fr': 'Dhikr quotidien',
    'de': 'Täglicher Dhikr',
    'es': 'Dhikr diario',
    'id': 'Zikir Harian',
    'ms': 'Zikir Harian',
    'ur': 'روزانہ ذکر',
    'ru': 'Ежедневный зикр',
  };

  static const Map<String, String> _subtitles = {
    'tr': 'Bugünün manevi hatırlatması',
    'en': 'Today’s spiritual reminder',
    'ar': 'تذكيرك الروحي لهذا اليوم',
    'fr': 'Votre rappel spirituel du jour',
    'de': 'Deine spirituelle Erinnerung für heute',
    'es': 'Tu recordatorio espiritual de hoy',
    'id': 'Pengingat rohani hari ini',
    'ms': 'Peringatan rohani hari ini',
    'ur': 'آج کی روحانی یاد دہانی',
    'ru': 'Духовное напоминание на сегодня',
  };

  static const Map<String, String> _today = {
    'tr': 'BUGÜNÜN ZİKRİ',
    'en': 'TODAY’S DHIKR',
    'ar': 'ذِكْرُ الْيَوْم',
    'fr': 'DHIKR DU JOUR',
    'de': 'DHIKR DES TAGES',
    'es': 'DHIKR DEL DÍA',
    'id': 'ZIKIR HARI INI',
    'ms': 'ZIKIR HARI INI',
    'ur': 'آج کا ذکر',
    'ru': 'ЗИКР ДНЯ',
  };

  static const Map<String, String> _start = {
    'tr': 'Bugünün Zikrini Başlat',
    'en': 'Start Today’s Dhikr',
    'ar': 'ابدأ ذكر اليوم',
    'fr': 'Commencer le dhikr du jour',
    'de': 'Heutigen Dhikr beginnen',
    'es': 'Comenzar el dhikr de hoy',
    'id': 'Mulai Zikir Hari Ini',
    'ms': 'Mulakan Zikir Hari Ini',
    'ur': 'آج کا ذکر شروع کریں',
    'ru': 'Начать зикр дня',
  };

  String _text(BuildContext context, Map<String, String> values) {
    return AppLocalization.text(context, values);
  }

  DhikrProgram _programForToday() {
    final now = DateTime.now();
    final dayNumber = now.difference(DateTime(now.year, 1, 1)).inDays;
    return dhikrPrograms[dayNumber % dhikrPrograms.length];
  }

  @override
  Widget build(BuildContext context) {
    final program = _programForToday();
    final content = program.content;
    final isRtl = AppLocalization.isRtl(context);

    return Directionality(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_text(context, _titles)),
        ),
        bottomNavigationBar: SafeArea(
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
            label: Text(_text(context, _start)),
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(56),
              backgroundColor: AppColors.gold,
              foregroundColor: Colors.black,
              textStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17),
              ),
            ),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.surfaceSoft,
                    AppColors.surface,
                  ],
                ),
                borderRadius: BorderRadius.circular(26),
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
                    child: const Icon(
                      Icons.menu_book_rounded,
                      color: AppColors.goldLight,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _text(context, _titles),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    _text(context, _subtitles),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.goldDark),
              ),
              child: Column(
                children: [
                  Text(
                    _text(context, _today),
                    style: const TextStyle(
                      color: AppColors.goldLight,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.3,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    program.title.resolve(context),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    program.description.resolve(context),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 22),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      content.arabic,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.goldLight,
                        fontSize: 31,
                        height: 1.8,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    content.pronunciation.resolve(context),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 17,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    content.meaning.resolve(context),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 11,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.gold.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.goldDark),
                    ),
                    child: Text(
                      '${AppLocalization.text(context, AppLocalization.suggestedTarget)}: ${content.target}',
                      style: const TextStyle(
                        color: AppColors.goldLight,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

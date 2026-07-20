import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/localization/app_localization.dart';
import '../../models/asma_name.dart';
import '../digital_tasbih/digital_tasbih_screen.dart';

import '../../widgets/banner_ad_widget.dart';
class AsmaNameDetailScreen extends StatelessWidget {
  const AsmaNameDetailScreen({required this.name, super.key});
  final AsmaName name;

  static const _meaningLabel = {
    'tr': 'Anlamı',
    'en': 'Meaning',
    'ar': 'المعنى',
    'fr': 'Signification',
    'de': 'Bedeutung',
    'es': 'Significado',
    'id': 'Arti',
    'ms': 'Maksud',
    'ur': 'معنی',
    'ru': 'Значение',
  };
  static const _recommendedCountLabel = {
    'tr': 'Önerilen Zikir Adedi',
    'en': 'Suggested Dhikr Count',
    'ar': 'عدد الذكر المقترح',
    'fr': 'Nombre de dhikr suggéré',
    'de': 'Empfohlene Dhikr-Anzahl',
    'es': 'Cantidad de dhikr sugerida',
    'id': 'Jumlah Dzikir yang Disarankan',
    'ms': 'Bilangan Zikir yang Dicadangkan',
    'ur': 'تجویز کردہ ذکر کی تعداد',
    'ru': 'Рекомендуемое число зикра',
  };

  static const _defaultTargetLabel = {
    'tr': 'Uygulama hedefi',
    'en': 'App target',
    'ar': 'هدف التطبيق',
    'fr': 'Objectif de l’application',
    'de': 'App-Ziel',
    'es': 'Objetivo de la aplicación',
    'id': 'Target aplikasi',
    'ms': 'Sasaran aplikasi',
    'ur': 'ایپ کا ہدف',
    'ru': 'Цель приложения',
  };

  static const _pronunciationLabel = {
    'tr': 'Okunuş',
    'en': 'Pronunciation',
    'ar': 'النطق بالحروف اللاتينية',
    'fr': 'Prononciation',
    'de': 'Aussprache',
    'es': 'Pronunciación',
    'id': 'Pelafalan',
    'ms': 'Sebutan',
    'ur': 'لاطینی تلفظ',
    'ru': 'Произношение',
  };
  static const _startLabel = {
    'tr': 'Bu İsimle Zikir Çek',
    'en': 'Count Dhikr with This Name',
    'ar': 'ابدأ الذكر بهذا الاسم',
    'fr': 'Faire le dhikr avec ce nom',
    'de': 'Dhikr mit diesem Namen',
    'es': 'Hacer dhikr con este nombre',
    'id': 'Berzikir dengan Nama Ini',
    'ms': 'Berzikir dengan Nama Ini',
    'ur': 'اس نام کے ساتھ ذکر کریں',
    'ru': 'Начать зикр с этим именем',
  };
  static const _note = {
    'tr':
        'Gösterilen sayılar geleneksel kullanım veya uygulama hedefidir; dini bir zorunluluk değildir.',
    'en':
        'Displayed counts are traditional-use or app targets and are not religious obligations.',
    'ar':
        'العدد 99 اقتراح تنظيمي داخل التطبيق، وليس ادعاءً بوجود عدد واجب خاص بهذا الاسم.',
    'fr':
        'L’objectif de 99 est une suggestion de l’application, et non un nombre prescrit pour ce nom.',
    'de':
        'Das Ziel 99 ist nur ein App-Vorschlag und keine vorgeschriebene Anzahl für diesen Namen.',
    'es':
        'El objetivo de 99 es una sugerencia de la aplicación, no una cantidad prescrita para este nombre.',
    'id':
        'Target 99 adalah saran aplikasi, bukan klaim jumlah khusus yang diwajibkan untuk nama ini.',
    'ms':
        'Sasaran 99 ialah cadangan aplikasi, bukan dakwaan jumlah khusus yang diwajibkan untuk nama ini.',
    'ur':
        '99 کا ہدف صرف ایپ کی تجویز ہے، اس نام کے لیے کسی لازمی مخصوص تعداد کا دعویٰ نہیں۔',
    'ru':
        'Цель 99 — лишь рекомендация приложения, а не утверждение о предписанном числе для этого имени.',
  };

  String _t(BuildContext context, Map<String, String> values) {
    final code = AppLocalization.languageCode(context);
    return values[code] ?? values['en']!;
  }

  @override
  Widget build(BuildContext context) {
    final code = AppLocalization.languageCode(context);
    final isRtl = code == 'ar' || code == 'ur';

    return Directionality(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(title: Text(name.displayName(context))),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SafeArea(
          minimum: const EdgeInsets.fromLTRB(20, 8, 20, 18),
          child: FilledButton.icon(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => DigitalTasbihScreen(
                  initialDhikrName: name.dhikrText(context),
                  initialTarget: name.recommendedCount ?? 99,
                  startFresh: true,
                ),
              ),
            ),
            icon: const Icon(Icons.touch_app_rounded),
            label: Text(_t(context, _startLabel)),
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
            const BannerAdWidget(),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(22, 26, 22, 25),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(26),
                border: Border.all(color: AppColors.goldDark),
              ),
              child: Column(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.gold.withValues(alpha: 0.13),
                      border: Border.all(color: AppColors.goldDark),
                    ),
                    child: name.isFeatured
                        ? const Icon(
                            Icons.star_rounded,
                            color: AppColors.goldLight,
                            size: 22,
                          )
                        : Text(
                            '${name.number}',
                            style: const TextStyle(
                              color: AppColors.goldLight,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                  ),
                  const SizedBox(height: 20),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text(
                      name.arabic,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.goldLight,
                        fontSize: 42,
                        height: 1.6,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    name.displayName(context),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 23,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            _InfoCard(
              title: _t(context, _pronunciationLabel),
              value: name.displayName(context),
            ),
            const SizedBox(height: 12),
            _InfoCard(
              title: _t(context, _recommendedCountLabel),
              value: name.recommendedCount != null
                  ? '${name.recommendedCount}'
                  : '99 (${_t(context, _defaultTargetLabel)})',
            ),
            const SizedBox(height: 12),
            _InfoCard(
              title: _t(context, _meaningLabel),
              value: name.meaning(context),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.surfaceSoft,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.goldDark),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.info_outline_rounded,
                    color: AppColors.goldLight,
                    size: 21,
                  ),
                  const SizedBox(width: 11),
                  Expanded(
                    child: Text(
                      _t(context, _note),
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        height: 1.5,
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

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 17,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

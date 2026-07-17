import 'package:flutter/material.dart';

import '../../controllers/app_locale_controller.dart';
import '../../core/constants/app_colors.dart';
import '../../core/localization/app_localization.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  static const Map<String, String> _titles = {
    'tr': 'Ayarlar',
    'en': 'Settings',
    'ar': 'الإعدادات',
    'fr': 'Paramètres',
    'de': 'Einstellungen',
    'es': 'Ajustes',
    'id': 'Pengaturan',
    'ms': 'Tetapan',
    'ur': 'ترتیبات',
    'ru': 'Настройки',
  };

  static const Map<String, String> _language = {
    'tr': 'Uygulama Dili',
    'en': 'App Language',
    'ar': 'لغة التطبيق',
    'fr': 'Langue de l’application',
    'de': 'App-Sprache',
    'es': 'Idioma de la aplicación',
    'id': 'Bahasa Aplikasi',
    'ms': 'Bahasa Aplikasi',
    'ur': 'ایپ کی زبان',
    'ru': 'Язык приложения',
  };

  static const Map<String, String> _systemLanguage = {
    'tr': 'Telefon dilini kullan',
    'en': 'Use phone language',
    'ar': 'استخدام لغة الهاتف',
    'fr': 'Utiliser la langue du téléphone',
    'de': 'Telefonsprache verwenden',
    'es': 'Usar idioma del teléfono',
    'id': 'Gunakan bahasa ponsel',
    'ms': 'Gunakan bahasa telefon',
    'ur': 'فون کی زبان استعمال کریں',
    'ru': 'Использовать язык телефона',
  };

  static const Map<String, String> _languageInfo = {
    'tr': 'Değişiklik anında uygulanır.',
    'en': 'The change is applied immediately.',
    'ar': 'يتم تطبيق التغيير فورًا.',
    'fr': 'Le changement est appliqué immédiatement.',
    'de': 'Die Änderung wird sofort angewendet.',
    'es': 'El cambio se aplica inmediatamente.',
    'id': 'Perubahan diterapkan langsung.',
    'ms': 'Perubahan digunakan serta-merta.',
    'ur': 'تبدیلی فوراً لاگو ہو جاتی ہے۔',
    'ru': 'Изменение применяется сразу.',
  };

  static const List<(String, String)> _languages = [
    ('tr', 'Türkçe'),
    ('en', 'English'),
    ('ar', 'العربية'),
    ('fr', 'Français'),
    ('de', 'Deutsch'),
    ('es', 'Español'),
    ('id', 'Bahasa Indonesia'),
    ('ms', 'Bahasa Melayu'),
    ('ur', 'اردو'),
    ('ru', 'Русский'),
  ];

  String _text(BuildContext context, Map<String, String> values) {
    return AppLocalization.text(context, values);
  }

  @override
  Widget build(BuildContext context) {
    final selectedCode = AppLocaleController.instance.locale?.languageCode;
    final isRtl = AppLocalization.isRtl(context);

    return Directionality(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(title: Text(_text(context, _titles))),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 30),
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.goldDark),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.language_rounded,
                    color: AppColors.goldLight,
                    size: 34,
                  ),
                  const SizedBox(height: 14),
                  Text(
                    _text(context, _language),
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    _text(context, _languageInfo),
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            RadioGroup<String?>(
              groupValue: selectedCode,
              onChanged: (value) {
                AppLocaleController.instance.setLocale(value);
              },
              child: Column(
                children: [
                  _LanguageTile(
                    value: null,
                    title: _text(context, _systemLanguage),
                    icon: Icons.phone_android_rounded,
                  ),
                  const SizedBox(height: 10),
                  ..._languages.map(
                    (language) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: _LanguageTile(
                        value: language.$1,
                        title: language.$2,
                        icon: Icons.translate_rounded,
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

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.value,
    required this.title,
    required this.icon,
  });

  final String? value;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.goldDark.withValues(alpha: 0.72)),
      ),
      child: RadioListTile<String?>(
        value: value,
        activeColor: AppColors.gold,
        secondary: Icon(icon, color: AppColors.goldLight),
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

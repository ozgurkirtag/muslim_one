import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/localization/app_localization.dart';
import '../../core/routes/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  String _text(BuildContext context, Map<String, String> values) {
    return AppLocalization.text(context, values);
  }

  @override
  Widget build(BuildContext context) {
    final isRtl = AppLocalization.isRtl(context);

    final features = [
      _HomeFeature(
        id: 'tasbih',
        title: _text(context, const {
          'tr': 'Dijital Zikirmatik',
          'en': 'Digital Tasbih',
          'ar': 'المسبحة الرقمية',
          'fr': 'Tasbih numérique',
          'de': 'Digitaler Tasbih',
          'es': 'Tasbih digital',
          'id': 'Tasbih Digital',
          'ms': 'Tasbih Digital',
          'ur': 'ڈیجیٹل تسبیح',
          'ru': 'Цифровой тасбих',
        }),
        subtitle: _text(context, const {
          'tr': 'Zikirlerini kolayca say',
          'en': 'Count your dhikr with ease',
          'ar': 'احسب أذكارك بسهولة',
          'fr': 'Comptez facilement vos dhikrs',
          'de': 'Zähle deinen Dhikr ganz einfach',
          'es': 'Cuenta tu dhikr fácilmente',
          'id': 'Hitung zikir dengan mudah',
          'ms': 'Kira zikir dengan mudah',
          'ur': 'اپنا ذکر آسانی سے شمار کریں',
          'ru': 'Легко считайте свой зикр',
        }),
        icon: Icons.touch_app_rounded,
      ),
      _HomeFeature(
        id: 'recite',
        title: _text(context, AppLocalization.pageTitle),
        subtitle: _text(context, const {
          'tr': 'İhtiyacına uygun zikir programını bul',
          'en': 'Find a dhikr program for your need',
          'ar': 'اعثر على ذكر يناسب حاجتك',
          'fr': 'Trouvez un dhikr adapté à votre besoin',
          'de': 'Finde einen passenden Dhikr',
          'es': 'Encuentra un dhikr para tu necesidad',
          'id': 'Temukan zikir sesuai kebutuhanmu',
          'ms': 'Cari zikir yang sesuai dengan keperluan anda',
          'ur': 'اپنی ضرورت کے مطابق ذکر تلاش کریں',
          'ru': 'Найдите зикр для своей ситуации',
        }),
        icon: Icons.favorite_rounded,
      ),
      _HomeFeature(
        id: 'prayer',
        title: _text(context, const {
          'tr': 'Namaz Vakitleri',
          'en': 'Prayer Times',
          'ar': 'مواقيت الصلاة',
          'fr': 'Horaires de prière',
          'de': 'Gebetszeiten',
          'es': 'Horarios de oración',
          'id': 'Waktu Salat',
          'ms': 'Waktu Solat',
          'ur': 'نماز کے اوقات',
          'ru': 'Время молитв',
        }),
        subtitle: _text(context, const {
          'tr': 'Dünyanın her yerinde namaz vakitleri',
          'en': 'Prayer times anywhere in the world',
          'ar': 'مواقيت الصلاة في جميع أنحاء العالم',
          'fr': 'Horaires de prière partout dans le monde',
          'de': 'Gebetszeiten überall auf der Welt',
          'es': 'Horarios de oración en todo el mundo',
          'id': 'Waktu salat di seluruh dunia',
          'ms': 'Waktu solat di seluruh dunia',
          'ur': 'دنیا بھر میں نماز کے اوقات',
          'ru': 'Время молитв в любой точке мира',
        }),
        icon: Icons.schedule_rounded,
      ),
      _HomeFeature(
        id: 'qibla',
        title: _text(context, const {
          'tr': 'Kıble Bulucu',
          'en': 'Qibla Finder',
          'ar': 'محدد القبلة',
          'fr': 'Direction de la Qibla',
          'de': 'Qibla-Finder',
          'es': 'Buscador de Qibla',
          'id': 'Penunjuk Kiblat',
          'ms': 'Penentu Kiblat',
          'ur': 'قبلہ نما',
          'ru': 'Определение Киблы',
        }),
        subtitle: _text(context, const {
          'tr': 'Kâbe yönünü bul',
          'en': 'Find the direction of the Kaaba',
          'ar': 'اعثر على اتجاه الكعبة',
          'fr': 'Trouvez la direction de la Kaaba',
          'de': 'Finde die Richtung der Kaaba',
          'es': 'Encuentra la dirección de la Kaaba',
          'id': 'Temukan arah Ka’bah',
          'ms': 'Cari arah Kaabah',
          'ur': 'کعبہ کی سمت معلوم کریں',
          'ru': 'Найдите направление на Каабу',
        }),
        icon: Icons.explore_rounded,
      ),
      _HomeFeature(
        id: 'asma',
        title: _text(context, const {
          'tr': 'Esmaül Hüsna',
          'en': 'Asma ul Husna',
          'ar': 'أسماء الله الحسنى',
          'fr': 'Les beaux noms d’Allah',
          'de': 'Allahs schönste Namen',
          'es': 'Los bellos nombres de Allah',
          'id': 'Asmaul Husna',
          'ms': 'Asmaul Husna',
          'ur': 'اسمائے حسنیٰ',
          'ru': 'Прекрасные имена Аллаха',
        }),
        subtitle: _text(context, const {
          'tr': 'Allah’ın 99 güzel ismini keşfet',
          'en': 'Discover the 99 names of Allah',
          'ar': 'تعرّف على أسماء الله الحسنى',
          'fr': 'Découvrez les 99 noms d’Allah',
          'de': 'Entdecke die 99 Namen Allahs',
          'es': 'Descubre los 99 nombres de Allah',
          'id': 'Pelajari 99 nama Allah',
          'ms': 'Kenali 99 nama Allah',
          'ur': 'اللہ کے 99 خوبصورت نام جانیے',
          'ru': 'Откройте 99 имён Аллаха',
        }),
        icon: Icons.auto_awesome_rounded,
      ),
      _HomeFeature(
        id: 'daily',
        title: _text(context, const {
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
        }),
        subtitle: _text(context, const {
          'tr': 'Bugün için anlamlı bir hatırlatma',
          'en': 'A meaningful reminder for today',
          'ar': 'تذكير روحاني لهذا اليوم',
          'fr': 'Un rappel spirituel pour aujourd’hui',
          'de': 'Eine spirituelle Erinnerung für heute',
          'es': 'Un recordatorio espiritual para hoy',
          'id': 'Pengingat bermakna untuk hari ini',
          'ms': 'Peringatan bermakna untuk hari ini',
          'ur': 'آج کے لیے ایک بامعنی یاد دہانی',
          'ru': 'Духовное напоминание на сегодня',
        }),
        icon: Icons.menu_book_rounded,
      ),
      _HomeFeature(
        id: 'settings',
        title: _text(context, const {
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
        }),
        subtitle: _text(context, const {
          'tr': 'Dil, ses ve tercihler',
          'en': 'Language, sound and preferences',
          'ar': 'اللغة والصوت والتفضيلات',
          'fr': 'Langue, son et préférences',
          'de': 'Sprache, Ton und Einstellungen',
          'es': 'Idioma, sonido y preferencias',
          'id': 'Bahasa, suara, dan preferensi',
          'ms': 'Bahasa, bunyi dan pilihan',
          'ur': 'زبان، آواز اور ترجیحات',
          'ru': 'Язык, звук и предпочтения',
        }),
        icon: Icons.settings_rounded,
      ),
    ];

    return Directionality(
      textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              const SliverPadding(
                padding: EdgeInsets.fromLTRB(20, 22, 20, 12),
                sliver: SliverToBoxAdapter(child: _Header()),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                sliver: SliverToBoxAdapter(
                  child: _DailyReminderCard(
                    title: _text(context, const {
                      'tr': 'Bugünün Hatırlatması',
                      'en': 'Today’s Reminder',
                      'ar': 'تذكير اليوم',
                      'fr': 'Rappel du jour',
                      'de': 'Heutige Erinnerung',
                      'es': 'Recordatorio de hoy',
                      'id': 'Pengingat Hari Ini',
                      'ms': 'Peringatan Hari Ini',
                      'ur': 'آج کی یاد دہانی',
                      'ru': 'Напоминание дня',
                    }),
                    reminder: _text(context, const {
                      'tr': 'Şüphesiz güçlükle beraber bir kolaylık vardır.',
                      'en': 'Indeed, with hardship comes ease.',
                      'ar': 'فَإِنَّ مَعَ الْعُسْرِ يُسْرًا',
                      'fr': 'Avec la difficulté vient certes la facilité.',
                      'de': 'Mit der Erschwernis kommt Erleichterung.',
                      'es': 'Con la dificultad viene la facilidad.',
                      'id': 'Sesungguhnya bersama kesulitan ada kemudahan.',
                      'ms': 'Sesungguhnya bersama kesukaran ada kemudahan.',
                      'ur': 'بے شک مشکل کے ساتھ آسانی ہے۔',
                      'ru': 'Воистину, за тягостью приходит облегчение.',
                    }),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
                sliver: SliverList.separated(
                  itemCount: features.length,
                  itemBuilder: (context, index) {
                    return _FeatureCard(feature: features[index]);
                  },
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final tagline = AppLocalization.text(context, const {
      'tr': 'Bir Müslümanın ihtiyaç duyduğu her şey tek uygulamada.',
      'en': 'Everything a Muslim needs in one app.',
      'ar': 'كل ما يحتاجه المسلم في تطبيق واحد.',
      'fr': 'Tout ce dont un musulman a besoin dans une seule application.',
      'de': 'Alles, was ein Muslim braucht, in einer App.',
      'es': 'Todo lo que un musulmán necesita en una sola aplicación.',
      'id': 'Semua kebutuhan Muslim dalam satu aplikasi.',
      'ms': 'Segala keperluan Muslim dalam satu aplikasi.',
      'ur': 'مسلمان کی ہر ضرورت ایک ہی ایپ میں۔',
      'ru': 'Всё необходимое мусульманину в одном приложении.',
    });

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.surfaceSoft, AppColors.surface],
        ),
        border: Border.all(color: AppColors.goldDark),
      ),
      child: Row(
        children: [
          const _LogoMark(),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  AppStrings.appName,
                  style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  tagline,
                  style: const TextStyle(
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
  const _DailyReminderCard({required this.title, required this.reminder});

  final String title;
  final String reminder;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.goldDark, width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.auto_awesome_rounded,
                color: AppColors.goldLight,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.goldLight,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            reminder,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
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
          switch (feature.id) {
            case 'tasbih':
              Navigator.of(context).pushNamed(AppRoutes.digitalTasbih);
            case 'recite':
              Navigator.of(context).pushNamed(AppRoutes.recitePrograms);
            case 'prayer':
              Navigator.of(context).pushNamed(AppRoutes.prayerTimes);
            case 'qibla':
              Navigator.of(context).pushNamed(AppRoutes.qibla);
            case 'asma':
              Navigator.of(context).pushNamed(AppRoutes.asmaNames);
            case 'daily':
              Navigator.of(context).pushNamed(AppRoutes.dailyDhikr);
            case 'settings':
              Navigator.of(context).pushNamed(AppRoutes.settings);
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
                  border: Border.all(color: AppColors.goldDark),
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
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
}

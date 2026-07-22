import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/localization/app_localization.dart';
import '../../core/routes/app_routes.dart';

import '../../widgets/banner_ad_widget.dart';

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
        bottomNavigationBar: const SafeArea(
          top: false,
          child: BannerAdWidget(),
        ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              const SliverPadding(
                padding: EdgeInsets.fromLTRB(20, 22, 20, 12),
                sliver: SliverToBoxAdapter(child: _HomeGreetingCard()),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                sliver: SliverToBoxAdapter(child: const _DailyVerseCard()),
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

class _HomeGreetingCard extends StatelessWidget {
  const _HomeGreetingCard();

  String _text(BuildContext context, Map<String, String> values) {
    return AppLocalization.text(context, values);
  }

  @override
  Widget build(BuildContext context) {
    final greeting = _text(context, const {
      'tr': 'Selamün Aleyküm',
      'en': 'Assalamu Alaikum',
      'ar': 'السلام عليكم',
      'fr': 'Assalamu Alaikum',
      'de': 'Assalamu Alaikum',
      'es': 'Assalamu Alaikum',
      'id': 'Assalamu Alaikum',
      'ms': 'Assalamualaikum',
      'ur': 'السلام علیکم',
      'ru': 'Ассаляму алейкум',
    });

    final message = _text(context, const {
      'tr': 'Allah ibadetlerinizi kabul etsin.',
      'en': 'May Allah accept your worship.',
      'ar': 'تقبل الله طاعاتكم',
      'fr': 'Qu’Allah accepte vos adorations.',
      'de': 'Möge Allah deine Gebete annehmen.',
      'es': 'Que Allah acepte tus actos de adoración.',
      'id': 'Semoga Allah menerima ibadahmu.',
      'ms': 'Semoga Allah menerima ibadah anda.',
      'ur': 'اللہ آپ کی عبادات قبول فرمائے۔',
      'ru': 'Пусть Аллах примет ваше поклонение.',
    });

    final prayerTimes = _text(context, const {
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
    });

    final action = _text(context, const {
      'tr': 'Bugünün namaz vakitlerini görüntüle',
      'en': 'View today’s prayer times',
      'ar': 'عرض مواقيت الصلاة لليوم',
      'fr': 'Voir les horaires de prière du jour',
      'de': 'Heutige Gebetszeiten anzeigen',
      'es': 'Ver los horarios de oración de hoy',
      'id': 'Lihat waktu salat hari ini',
      'ms': 'Lihat waktu solat hari ini',
      'ur': 'آج کے نماز کے اوقات دیکھیں',
      'ru': 'Посмотреть время молитв на сегодня',
    });

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed(AppRoutes.prayerTimes),
        borderRadius: BorderRadius.circular(28),
        child: Ink(
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
          child: Column(
            children: [
              Container(
                width: 62,
                height: 62,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.background,
                  border: Border.all(color: AppColors.gold, width: 1.4),
                ),
                child: const Icon(
                  Icons.nightlight_round,
                  color: AppColors.goldLight,
                  size: 34,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                greeting,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 7),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 19),
              Container(
                height: 1,
                color: AppColors.goldDark.withValues(alpha: 0.7),
              ),
              const SizedBox(height: 17),
              Row(
                children: [
                  Container(
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                      color: AppColors.gold.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.goldDark),
                    ),
                    child: const Icon(
                      Icons.schedule_rounded,
                      color: AppColors.goldLight,
                    ),
                  ),
                  const SizedBox(width: 13),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          prayerTimes,
                          style: const TextStyle(
                            color: AppColors.goldLight,
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          action,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12.5,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.gold,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DailyVerseCard extends StatelessWidget {
  const _DailyVerseCard();

  static const List<_DailyVerse> _verses = [
    _DailyVerse(
      arabic: 'فَإِنَّ مَعَ الْعُسْرِ يُسْرًا',
      reference: '94:6',
      translations: {
        'tr': 'Şüphesiz güçlükle beraber bir kolaylık vardır.',
        'en': 'Indeed, with hardship comes ease.',
        'ar': 'فَإِنَّ مَعَ الْعُسْرِ يُسْرًا',
        'fr': 'Avec la difficulté vient certes la facilité.',
        'de': 'Wahrlich, mit der Erschwernis kommt Erleichterung.',
        'es': 'Ciertamente, con la dificultad viene la facilidad.',
        'id': 'Sesungguhnya bersama kesulitan ada kemudahan.',
        'ms': 'Sesungguhnya bersama kesukaran ada kemudahan.',
        'ur': 'بے شک مشکل کے ساتھ آسانی ہے۔',
        'ru': 'Воистину, с тягостью приходит облегчение.',
      },
    ),
    _DailyVerse(
      arabic: 'فَاذْكُرُونِي أَذْكُرْكُمْ',
      reference: '2:152',
      translations: {
        'tr': 'Beni anın ki ben de sizi anayım.',
        'en': 'Remember Me; I will remember you.',
        'ar': 'فَاذْكُرُونِي أَذْكُرْكُمْ',
        'fr': 'Souvenez-vous de Moi, Je Me souviendrai de vous.',
        'de': 'Gedenkt Meiner, dann gedenke Ich eurer.',
        'es': 'Recordadme y Yo os recordaré.',
        'id': 'Ingatlah kepada-Ku, niscaya Aku ingat kepadamu.',
        'ms': 'Ingatlah kepada-Ku, nescaya Aku mengingati kamu.',
        'ur': 'تم مجھے یاد کرو، میں تمہیں یاد کروں گا۔',
        'ru': 'Поминайте Меня, и Я буду помнить о вас.',
      },
    ),
    _DailyVerse(
      arabic: 'إِنَّ اللَّهَ مَعَ الصَّابِرِينَ',
      reference: '2:153',
      translations: {
        'tr': 'Şüphesiz Allah sabredenlerle beraberdir.',
        'en': 'Indeed, Allah is with the patient.',
        'ar': 'إِنَّ اللَّهَ مَعَ الصَّابِرِينَ',
        'fr': 'Allah est avec ceux qui patientent.',
        'de': 'Gewiss, Allah ist mit den Geduldigen.',
        'es': 'Ciertamente, Allah está con los pacientes.',
        'id': 'Sesungguhnya Allah bersama orang-orang yang sabar.',
        'ms': 'Sesungguhnya Allah bersama orang-orang yang sabar.',
        'ur': 'بے شک اللہ صبر کرنے والوں کے ساتھ ہے۔',
        'ru': 'Воистину, Аллах — с терпеливыми.',
      },
    ),
    _DailyVerse(
      arabic: 'لَا تَقْنَطُوا مِن رَّحْمَةِ اللَّهِ',
      reference: '39:53',
      translations: {
        'tr': 'Allah’ın rahmetinden ümit kesmeyin.',
        'en': 'Do not lose hope in the mercy of Allah.',
        'ar': 'لَا تَقْنَطُوا مِن رَّحْمَةِ اللَّهِ',
        'fr': 'Ne désespérez pas de la miséricorde d’Allah.',
        'de': 'Verliert nicht die Hoffnung auf Allahs Barmherzigkeit.',
        'es': 'No desesperéis de la misericordia de Allah.',
        'id': 'Janganlah berputus asa dari rahmat Allah.',
        'ms': 'Janganlah berputus asa daripada rahmat Allah.',
        'ur': 'اللہ کی رحمت سے ناامید نہ ہو۔',
        'ru': 'Не отчаивайтесь в милости Аллаха.',
      },
    ),
    _DailyVerse(
      arabic: 'أَلَا بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ',
      reference: '13:28',
      translations: {
        'tr': 'Kalpler ancak Allah’ı anmakla huzur bulur.',
        'en': 'Surely, hearts find comfort in the remembrance of Allah.',
        'ar': 'أَلَا بِذِكْرِ اللَّهِ تَطْمَئِنُّ الْقُلُوبُ',
        'fr': 'Les cœurs se tranquillisent par l’évocation d’Allah.',
        'de': 'Im Gedenken Allahs finden die Herzen Ruhe.',
        'es': 'Los corazones encuentran sosiego en el recuerdo de Allah.',
        'id': 'Hanya dengan mengingat Allah hati menjadi tenteram.',
        'ms': 'Dengan mengingati Allah, hati menjadi tenteram.',
        'ur': 'اللہ کے ذکر سے دلوں کو اطمینان ملتا ہے۔',
        'ru': 'Поминанием Аллаха утешаются сердца.',
      },
    ),
    _DailyVerse(
      arabic: 'وَمَن يَتَوَكَّلْ عَلَى اللَّهِ فَهُوَ حَسْبُهُ',
      reference: '65:3',
      translations: {
        'tr': 'Kim Allah’a tevekkül ederse O, ona yeter.',
        'en': 'Whoever relies upon Allah, He is sufficient for them.',
        'ar': 'وَمَن يَتَوَكَّلْ عَلَى اللَّهِ فَهُوَ حَسْبُهُ',
        'fr': 'Quiconque place sa confiance en Allah, Il lui suffit.',
        'de': 'Wer auf Allah vertraut, dem ist Er genug.',
        'es': 'A quien confía en Allah, Él le basta.',
        'id': 'Barang siapa bertawakal kepada Allah, Dia akan mencukupinya.',
        'ms': 'Sesiapa bertawakal kepada Allah, Dia mencukupinya.',
        'ur': 'جو اللہ پر بھروسہ کرے تو وہ اس کے لیے کافی ہے۔',
        'ru': 'Тому, кто уповает на Аллаха, достаточно Его.',
      },
    ),
    _DailyVerse(
      arabic: 'إِنَّ رَبِّي قَرِيبٌ مُّجِيبٌ',
      reference: '11:61',
      translations: {
        'tr': 'Şüphesiz Rabbim yakındır, dualara cevap verendir.',
        'en': 'Indeed, my Lord is near and responsive.',
        'ar': 'إِنَّ رَبِّي قَرِيبٌ مُّجِيبٌ',
        'fr': 'Mon Seigneur est proche et Il répond.',
        'de': 'Mein Herr ist nahe und erhört die Gebete.',
        'es': 'Mi Señor está cerca y responde.',
        'id': 'Sesungguhnya Tuhanku dekat dan mengabulkan doa.',
        'ms': 'Sesungguhnya Tuhanku dekat dan memperkenankan doa.',
        'ur': 'بے شک میرا رب قریب اور دعا قبول کرنے والا ہے۔',
        'ru': 'Воистину, мой Господь близок и отвечает.',
      },
    ),
    _DailyVerse(
      arabic: 'وَقُل رَّبِّ زِدْنِي عِلْمًا',
      reference: '20:114',
      translations: {
        'tr': 'Rabbim, ilmimi artır de.',
        'en': 'My Lord, increase me in knowledge.',
        'ar': 'وَقُل رَّبِّ زِدْنِي عِلْمًا',
        'fr': 'Seigneur, augmente-moi en savoir.',
        'de': 'Mein Herr, mehre mein Wissen.',
        'es': 'Señor mío, aumenta mi conocimiento.',
        'id': 'Ya Tuhanku, tambahkanlah ilmu kepadaku.',
        'ms': 'Wahai Tuhanku, tambahkanlah ilmuku.',
        'ur': 'اے میرے رب، میرے علم میں اضافہ فرما۔',
        'ru': 'Господи, приумножь мои знания.',
      },
    ),
    _DailyVerse(
      arabic: 'إِنَّ اللَّهَ يُحِبُّ الْمُتَوَكِّلِينَ',
      reference: '3:159',
      translations: {
        'tr': 'Şüphesiz Allah tevekkül edenleri sever.',
        'en': 'Indeed, Allah loves those who rely upon Him.',
        'ar': 'إِنَّ اللَّهَ يُحِبُّ الْمُتَوَكِّلِينَ',
        'fr': 'Allah aime ceux qui placent leur confiance en Lui.',
        'de': 'Allah liebt diejenigen, die auf Ihn vertrauen.',
        'es': 'Allah ama a quienes confían en Él.',
        'id': 'Sesungguhnya Allah mencintai orang-orang yang bertawakal.',
        'ms': 'Sesungguhnya Allah mengasihi orang-orang yang bertawakal.',
        'ur': 'بے شک اللہ توکل کرنے والوں سے محبت کرتا ہے۔',
        'ru': 'Воистину, Аллах любит уповающих.',
      },
    ),
    _DailyVerse(
      arabic: 'وَاللَّهُ خَيْرُ الْحَافِظِينَ',
      reference: '12:64',
      translations: {
        'tr': 'Allah koruyanların en hayırlısıdır.',
        'en': 'Allah is the best guardian.',
        'ar': 'وَاللَّهُ خَيْرُ الْحَافِظِينَ',
        'fr': 'Allah est le meilleur gardien.',
        'de': 'Allah ist der beste Beschützer.',
        'es': 'Allah es el mejor protector.',
        'id': 'Allah adalah penjaga yang terbaik.',
        'ms': 'Allah ialah sebaik-baik penjaga.',
        'ur': 'اللہ سب سے بہتر حفاظت کرنے والا ہے۔',
        'ru': 'Аллах — лучший Хранитель.',
      },
    ),
  ];

  String _text(BuildContext context, Map<String, String> values) {
    return AppLocalization.text(context, values);
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final dayOfYear = now.difference(DateTime(now.year, 1, 1)).inDays;
    final verse = _verses[dayOfYear % _verses.length];

    final title = _text(context, const {
      'tr': 'Günün Ayeti',
      'en': 'Verse of the Day',
      'ar': 'آية اليوم',
      'fr': 'Verset du jour',
      'de': 'Vers des Tages',
      'es': 'Versículo del día',
      'id': 'Ayat Hari Ini',
      'ms': 'Ayat Hari Ini',
      'ur': 'آج کی آیت',
      'ru': 'Аят дня',
    });

    final quran = _text(context, const {
      'tr': 'Kur’an',
      'en': 'Quran',
      'ar': 'القرآن',
      'fr': 'Coran',
      'de': 'Koran',
      'es': 'Corán',
      'id': 'Al-Quran',
      'ms': 'Al-Quran',
      'ur': 'قرآن',
      'ru': 'Коран',
    });

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.goldDark, width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const Icon(
                Icons.menu_book_rounded,
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
          const SizedBox(height: 17),
          Text(
            verse.arabic,
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: const TextStyle(
              color: AppColors.goldLight,
              fontSize: 23,
              fontWeight: FontWeight.w600,
              height: 1.8,
            ),
          ),
          const SizedBox(height: 13),
          Text(
            _text(context, verse.translations),
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 17,
              fontWeight: FontWeight.w600,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 11),
          Text(
            '$quran ${verse.reference}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _DailyVerse {
  const _DailyVerse({
    required this.arabic,
    required this.reference,
    required this.translations,
  });

  final String arabic;
  final String reference;
  final Map<String, String> translations;
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

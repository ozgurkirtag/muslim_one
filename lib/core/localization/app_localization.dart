import 'package:flutter/material.dart';

abstract final class AppLocalization {
  static const List<Locale> supportedLocales = [
    Locale('tr'),
    Locale('en'),
    Locale('ar'),
    Locale('fr'),
    Locale('de'),
    Locale('es'),
    Locale('id'),
    Locale('ms'),
    Locale('ur'),
    Locale('ru'),
  ];

  static const Set<String> supportedCodes = {
    'tr',
    'en',
    'ar',
    'fr',
    'de',
    'es',
    'id',
    'ms',
    'ur',
    'ru',
  };

  static String languageCode(BuildContext context) {
    final code = Localizations.localeOf(context).languageCode.toLowerCase();
    return supportedCodes.contains(code) ? code : 'en';
  }

  static bool isRtl(BuildContext context) {
    final code = languageCode(context);
    return code == 'ar' || code == 'ur';
  }

  static String text(BuildContext context, Map<String, String> values) {
    final code = languageCode(context);
    return values[code] ?? values['en'] ?? values.values.first;
  }

  static const Map<String, String> pageTitle = {
    'tr': 'Ne Okumalıyım?',
    'en': 'What Should I Recite?',
    'ar': 'ماذا أقرأ؟',
    'fr': 'Que dois-je réciter ?',
    'de': 'Was soll ich rezitieren?',
    'es': '¿Qué debo recitar?',
    'id': 'Apa yang Harus Saya Baca?',
    'ms': 'Apa yang Patut Saya Baca?',
    'ur': 'مجھے کیا پڑھنا چاہیے؟',
    'ru': 'Что мне читать?',
  };

  static const Map<String, String> pageSubtitle = {
    'tr': 'İçinde bulunduğun durumu seç',
    'en': 'Choose your current situation',
    'ar': 'اختر حالتك الحالية',
    'fr': 'Choisissez votre situation actuelle',
    'de': 'Wähle deine aktuelle Situation',
    'es': 'Elige tu situación actual',
    'id': 'Pilih keadaanmu saat ini',
    'ms': 'Pilih keadaan anda sekarang',
    'ur': 'اپنی موجودہ کیفیت منتخب کریں',
    'ru': 'Выберите свою текущую ситуацию',
  };

  static const Map<String, String> gentleNote = {
    'tr':
        'Bu öneriler manevi hatırlatma niteliğindedir; kesin sonuç vaadi değildir.',
    'en':
        'These suggestions are spiritual reminders, not guarantees of a result.',
    'ar': 'هذه الاقتراحات تذكير روحي وليست ضمانًا لنتيجة محددة.',
    'fr':
        'Ces suggestions sont des rappels spirituels et non des garanties de résultat.',
    'de':
        'Diese Vorschläge sind spirituelle Erinnerungen und keine Erfolgsgarantie.',
    'es':
        'Estas sugerencias son recordatorios espirituales, no garantías de resultados.',
    'id': 'Saran ini adalah pengingat rohani, bukan jaminan hasil tertentu.',
    'ms': 'Cadangan ini ialah peringatan rohani, bukan jaminan hasil tertentu.',
    'ur': 'یہ تجاویز روحانی یاد دہانیاں ہیں، کسی نتیجے کی ضمانت نہیں۔',
    'ru':
        'Эти рекомендации являются духовным напоминанием, а не гарантией результата.',
  };

  static const Map<String, String> recommendedDhikr = {
    'tr': 'Önerilen Zikir',
    'en': 'Recommended Dhikr',
    'ar': 'الذكر المقترح',
    'fr': 'Dhikr recommandé',
    'de': 'Empfohlener Dhikr',
    'es': 'Dhikr recomendado',
    'id': 'Zikir yang Disarankan',
    'ms': 'Zikir yang Disyorkan',
    'ur': 'تجویز کردہ ذکر',
    'ru': 'Рекомендуемый зикр',
  };

  static const Map<String, String> arabicText = {
    'tr': 'Arapça',
    'en': 'Arabic',
    'ar': 'النص العربي',
    'fr': 'Arabe',
    'de': 'Arabisch',
    'es': 'Árabe',
    'id': 'Bahasa Arab',
    'ms': 'Bahasa Arab',
    'ur': 'عربی متن',
    'ru': 'Арабский текст',
  };

  static const Map<String, String> pronunciation = {
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

  static const Map<String, String> meaning = {
    'tr': 'Anlam',
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

  static const Map<String, String> source = {
    'tr': 'Kaynak',
    'en': 'Source',
    'ar': 'المصدر',
    'fr': 'Source',
    'de': 'Quelle',
    'es': 'Fuente',
    'id': 'Sumber',
    'ms': 'Sumber',
    'ur': 'حوالہ',
    'ru': 'Источник',
  };

  static const Map<String, String> suggestedTarget = {
    'tr': 'Önerilen hedef',
    'en': 'Suggested target',
    'ar': 'العدد المقترح',
    'fr': 'Objectif suggéré',
    'de': 'Empfohlenes Ziel',
    'es': 'Objetivo sugerido',
    'id': 'Target yang disarankan',
    'ms': 'Sasaran yang disyorkan',
    'ur': 'تجویز کردہ ہدف',
    'ru': 'Рекомендуемая цель',
  };

  static const Map<String, String> startDhikr = {
    'tr': 'Zikri Başlat',
    'en': 'Start Dhikr',
    'ar': 'ابدأ الذكر',
    'fr': 'Commencer le dhikr',
    'de': 'Dhikr beginnen',
    'es': 'Comenzar el dhikr',
    'id': 'Mulai Zikir',
    'ms': 'Mulakan Zikir',
    'ur': 'ذکر شروع کریں',
    'ru': 'Начать зикр',
  };

  static const Map<String, String> countNote = {
    'tr':
        'Kaynakta özel bir sayı belirtilmemişse hedef, düzenli kullanım için uygulama önerisidir.',
    'en':
        'Where no specific number is stated in the source, the target is an app suggestion for regular practice.',
    'ar':
        'إذا لم يرد عدد محدد في المصدر، فالعدد المقترح هو تنظيم اختياري داخل التطبيق.',
    'fr':
        'Lorsqu’aucun nombre précis n’est cité, l’objectif est une suggestion de pratique de l’application.',
    'de':
        'Wenn keine bestimmte Anzahl überliefert ist, ist das Ziel lediglich ein Vorschlag der App.',
    'es':
        'Cuando la fuente no indica una cantidad concreta, el objetivo es una sugerencia de la aplicación.',
    'id':
        'Jika sumber tidak menyebut jumlah tertentu, target adalah saran aplikasi untuk latihan teratur.',
    'ms':
        'Jika sumber tidak menyatakan jumlah tertentu, sasaran ialah cadangan aplikasi untuk amalan teratur.',
    'ur':
        'جہاں ماخذ میں مخصوص تعداد نہیں، وہاں ہدف صرف باقاعدہ عمل کے لیے ایپ کی تجویز ہے۔',
    'ru':
        'Если в источнике не указано точное число, цель является лишь рекомендацией приложения.',
  };


  static const Map<String, String> digitalTasbihTitle = {
    'tr': 'Dijital Tesbih',
    'en': 'Digital Tasbih',
    'ar': 'المسبحة الرقمية',
    'fr': 'Tasbih numérique',
    'de': 'Digitaler Tasbih',
    'es': 'Tasbih digital',
    'id': 'Tasbih Digital',
    'ms': 'Tasbih Digital',
    'ur': 'ڈیجیٹل تسبیح',
    'ru': 'Цифровой тасбих',
  };

  static const Map<String, String> currentDhikr = {
    'tr': 'MEVCUT ZİKİR',
    'en': 'CURRENT DHIKR',
    'ar': 'الذكر الحالي',
    'fr': 'DHIKR ACTUEL',
    'de': 'AKTUELLER DHIKR',
    'es': 'DHIKR ACTUAL',
    'id': 'ZIKIR SAAT INI',
    'ms': 'ZIKIR SEMASA',
    'ur': 'موجودہ ذکر',
    'ru': 'ТЕКУЩИЙ ЗИКР',
  };

  static const Map<String, String> tasbihCount = {
    'tr': 'SAYAÇ',
    'en': 'COUNT',
    'ar': 'العدد',
    'fr': 'COMPTEUR',
    'de': 'ZÄHLER',
    'es': 'CONTADOR',
    'id': 'HITUNGAN',
    'ms': 'KIRAAN',
    'ur': 'تعداد',
    'ru': 'СЧЁТЧИК',
  };

  static const Map<String, String> selectTarget = {
    'tr': 'HEDEF SEÇ',
    'en': 'SELECT TARGET',
    'ar': 'اختر الهدف',
    'fr': 'CHOISIR L’OBJECTIF',
    'de': 'ZIEL AUSWÄHLEN',
    'es': 'SELECCIONAR OBJETIVO',
    'id': 'PILIH TARGET',
    'ms': 'PILIH SASARAN',
    'ur': 'ہدف منتخب کریں',
    'ru': 'ВЫБЕРИТЕ ЦЕЛЬ',
  };

  static const Map<String, String> customTarget = {
    'tr': 'Özel',
    'en': 'Custom',
    'ar': 'مخصص',
    'fr': 'Personnalisé',
    'de': 'Benutzerdefiniert',
    'es': 'Personalizado',
    'id': 'Khusus',
    'ms': 'Tersuai',
    'ur': 'حسب ضرورت',
    'ru': 'Другое',
  };

  static const Map<String, String> tap = {
    'tr': 'DOKUN',
    'en': 'TAP',
    'ar': 'اضغط',
    'fr': 'APPUYEZ',
    'de': 'TIPPEN',
    'es': 'TOCA',
    'id': 'KETUK',
    'ms': 'KETIK',
    'ur': 'دبائیں',
    'ru': 'НАЖМИТЕ',
  };

  static const Map<String, String> toCount = {
    'tr': 'saymak için',
    'en': 'to count',
    'ar': 'للعد',
    'fr': 'pour compter',
    'de': 'zum Zählen',
    'es': 'para contar',
    'id': 'untuk menghitung',
    'ms': 'untuk mengira',
    'ur': 'گننے کے لیے',
    'ru': 'для подсчёта',
  };

  static const Map<String, String> vibration = {
    'tr': 'Titreşim',
    'en': 'Vibration',
    'ar': 'الاهتزاز',
    'fr': 'Vibration',
    'de': 'Vibration',
    'es': 'Vibración',
    'id': 'Getaran',
    'ms': 'Getaran',
    'ur': 'وائبریشن',
    'ru': 'Вибрация',
  };

  static const Map<String, String> sound = {
    'tr': 'Ses',
    'en': 'Sound',
    'ar': 'الصوت',
    'fr': 'Son',
    'de': 'Ton',
    'es': 'Sonido',
    'id': 'Suara',
    'ms': 'Bunyi',
    'ur': 'آواز',
    'ru': 'Звук',
  };

  static const Map<String, String> reset = {
    'tr': 'Sıfırla',
    'en': 'Reset',
    'ar': 'إعادة ضبط',
    'fr': 'Réinitialiser',
    'de': 'Zurücksetzen',
    'es': 'Reiniciar',
    'id': 'Atur Ulang',
    'ms': 'Tetapkan Semula',
    'ur': 'دوبارہ ترتیب دیں',
    'ru': 'Сбросить',
  };

  static const Map<String, String> continueAction = {
    'tr': 'Devam Et',
    'en': 'Continue',
    'ar': 'متابعة',
    'fr': 'Continuer',
    'de': 'Weiter',
    'es': 'Continuar',
    'id': 'Lanjutkan',
    'ms': 'Teruskan',
    'ur': 'جاری رکھیں',
    'ru': 'Продолжить',
  };

  static const Map<String, String> target = {
    'tr': 'Hedef',
    'en': 'Target',
    'ar': 'الهدف',
    'fr': 'Objectif',
    'de': 'Ziel',
    'es': 'Objetivo',
    'id': 'Target',
    'ms': 'Sasaran',
    'ur': 'ہدف',
    'ru': 'Цель',
  };

  static const Map<String, String> remaining = {
    'tr': 'Kalan',
    'en': 'Remaining',
    'ar': 'المتبقي',
    'fr': 'Restant',
    'de': 'Verbleibend',
    'es': 'Restante',
    'id': 'Tersisa',
    'ms': 'Baki',
    'ur': 'باقی',
    'ru': 'Осталось',
  };

}

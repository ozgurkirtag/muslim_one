import 'package:flutter/material.dart';

import '../models/dhikr_program.dart';

const LocalizedValue _reflectionDescription = LocalizedValue({
  'tr': 'Bu zikri sakin bir şekilde, anlamını düşünerek tekrar et.',
  'en': 'Repeat this remembrance calmly while reflecting on its meaning.',
  'ar': 'ردد هذا الذكر بهدوء مع التأمل في معناه.',
  'fr': 'Répétez ce rappel calmement en méditant sur son sens.',
  'de': 'Wiederhole diesen Dhikr ruhig und denke über seine Bedeutung nach.',
  'es': 'Repite este recuerdo con calma y reflexiona sobre su significado.',
  'id': 'Ulangi zikir ini dengan tenang sambil merenungkan maknanya.',
  'ms': 'Ulangi zikir ini dengan tenang sambil menghayati maknanya.',
  'ur': 'اس ذکر کو سکون سے پڑھیں اور اس کے معنی پر غور کریں۔',
  'ru': 'Повторяйте этот зикр спокойно, размышляя о его смысле.',
});

const LocalizedValue _duaDescription = LocalizedValue({
  'tr': 'Bu duayı samimiyetle oku ve ihtiyacını Allah’a arz et.',
  'en': 'Recite this supplication sincerely and present your need to Allah.',
  'ar': 'اقرأ هذا الدعاء بإخلاص واعرض حاجتك على الله.',
  'fr':
      'Récitez cette invocation avec sincérité et confiez votre besoin à Allah.',
  'de': 'Sprich dieses Bittgebet aufrichtig und trage Allah dein Anliegen vor.',
  'es': 'Recita esta súplica con sinceridad y presenta tu necesidad a Allah.',
  'id': 'Bacalah doa ini dengan tulus dan sampaikan kebutuhanmu kepada Allah.',
  'ms':
      'Bacalah doa ini dengan ikhlas dan serahkan keperluan anda kepada Allah.',
  'ur': 'یہ دعا اخلاص سے پڑھیں اور اپنی ضرورت اللہ کے سامنے رکھیں۔',
  'ru': 'Читайте эту мольбу искренне и обращайтесь со своей нуждой к Аллаху.',
});

const LocalizedValue _gratitudeDescription = LocalizedValue({
  'tr': 'Sahip olduğun nimetleri hatırla ve şükrünü dile getir.',
  'en': 'Remember the blessings you have and express your gratitude.',
  'ar': 'تذكر نعم الله عليك وعبّر عن شكرك.',
  'fr': 'Rappelez-vous vos bienfaits et exprimez votre gratitude.',
  'de':
      'Erinnere dich an deine Segnungen und bringe deine Dankbarkeit zum Ausdruck.',
  'es': 'Recuerda tus bendiciones y expresa tu gratitud.',
  'id': 'Ingatlah nikmat yang kamu miliki dan ungkapkan rasa syukur.',
  'ms': 'Ingatlah nikmat yang anda miliki dan nyatakan kesyukuran.',
  'ur': 'اپنی نعمتوں کو یاد کریں اور شکر ادا کریں۔',
  'ru': 'Вспомните свои блага и выразите благодарность.',
});

const LocalizedValue _morningEveningDescription = LocalizedValue({
  'tr': 'Güne veya geceye Allah’ı anarak sakin bir başlangıç yap.',
  'en': 'Begin this part of the day calmly with the remembrance of Allah.',
  'ar': 'ابدأ هذا الوقت من يومك بهدوء مع ذكر الله.',
  'fr': 'Commencez ce moment de la journée calmement par le rappel d’Allah.',
  'de': 'Beginne diesen Tagesabschnitt ruhig mit dem Gedenken Allahs.',
  'es': 'Comienza este momento del día con calma y con el recuerdo de Allah.',
  'id': 'Mulailah bagian hari ini dengan tenang melalui mengingat Allah.',
  'ms': 'Mulakan waktu ini dengan tenang melalui mengingati Allah.',
  'ur': 'دن کے اس حصے کا آغاز اللہ کے ذکر سے سکون کے ساتھ کریں۔',
  'ru': 'Начните эту часть дня спокойно, поминая Аллаха.',
});

const DhikrContent _hasbunallah = DhikrContent(
  name: LocalizedValue({
    'tr': 'Hasbunallahu ve ni’mel vekîl',
    'en': 'Hasbunallahu wa ni’mal wakeel',
    'ar': 'حسبنا الله ونعم الوكيل',
    'fr': 'Hasbunallahu wa ni‘mal wakil',
    'de': 'Hasbunallahu wa ni’mal Wakil',
    'es': 'Hasbunallahu wa ni’mal wakil',
    'id': 'Hasbunallahu wa ni’mal wakil',
    'ms': 'Hasbunallahu wa ni’mal wakil',
    'ur': 'حسبنا اللہ ونعم الوکیل',
    'ru': 'Хасбуналлаху ва ни‘маль-вакиль',
  }),
  arabic: 'حَسْبُنَا اللَّهُ وَنِعْمَ الْوَكِيلُ',
  pronunciation: LocalizedValue({
    'tr': 'Hasbunallâhu ve ni’mel vekîl',
    'en': 'Hasbunallahu wa ni‘mal wakeel',
    'ar': 'Hasbunallahu wa ni‘mal wakeel',
    'fr': 'Hasbounallâhou wa ni‘mal wakîl',
    'de': 'Hasbunallahu wa ni’mal Wakil',
    'es': 'Hasbunallahu wa ni’mal wakil',
    'id': 'Hasbunallahu wa ni’mal wakil',
    'ms': 'Hasbunallahu wa ni’mal wakil',
    'ur': 'Hasbunallahu wa ni‘mal wakeel',
    'ru': 'Хасбуналлаху ва ни‘маль-вакиль',
  }),
  meaning: LocalizedValue({
    'tr': 'Allah bize yeter. O ne güzel vekildir.',
    'en': 'Allah is sufficient for us, and He is the best disposer of affairs.',
    'ar': 'الله كافينا، وهو نعم الوكيل.',
    'fr': 'Allah nous suffit, et Il est le meilleur garant.',
    'de': 'Allah genügt uns, und Er ist der beste Sachwalter.',
    'es': 'Allah es suficiente para nosotros y es el mejor protector.',
    'id': 'Allah cukup bagi kami dan Dia sebaik-baik pelindung.',
    'ms': 'Allah mencukupi bagi kami dan Dia sebaik-baik pelindung.',
    'ur': 'اللہ ہمارے لیے کافی ہے اور وہ بہترین کارساز ہے۔',
    'ru': 'Нам достаточно Аллаха, и Он — лучший Покровитель.',
  }),
  source: LocalizedValue({
    'tr': 'Kur’an, Âl-i İmrân 3:173',
    'en': 'Quran, Ali ‘Imran 3:173',
    'ar': 'القرآن، آل عمران 3:173',
    'fr': 'Coran, Âl ‘Imrân 3:173',
    'de': 'Koran, Āl ʿImrān 3:173',
    'es': 'Corán, Ali ‘Imran 3:173',
    'id': 'Al-Qur’an, Ali Imran 3:173',
    'ms': 'Al-Quran, Ali ‘Imran 3:173',
    'ur': 'قرآن، آل عمران 3:173',
    'ru': 'Коран, Аль Имран 3:173',
  }),
  target: 33,
);

const DhikrContent _anxietyDua = DhikrContent(
  name: LocalizedValue({
    'tr': 'Kaygı ve Üzüntü Duası',
    'en': 'Supplication for Worry and Grief',
    'ar': 'دعاء الهم والحزن',
    'fr': 'Invocation contre l’inquiétude',
    'de': 'Bittgebet gegen Sorge und Trauer',
    'es': 'Súplica contra la preocupación',
    'id': 'Doa untuk Kecemasan dan Kesedihan',
    'ms': 'Doa untuk Keresahan dan Kesedihan',
    'ur': 'فکر اور غم کی دعا',
    'ru': 'Мольба от тревоги и печали',
  }),
  arabic:
      'اللَّهُمَّ إِنِّي أَعُوذُ بِكَ مِنَ الْهَمِّ وَالْحَزَنِ، وَالْعَجْزِ وَالْكَسَلِ، وَالْبُخْلِ وَالْجُبْنِ، وَضَلَعِ الدَّيْنِ وَغَلَبَةِ الرِّجَالِ',
  pronunciation: LocalizedValue({
    'tr':
        'Allahümme innî eûzü bike minel hemmi vel hazen, vel aczi vel kesel, vel buhli vel cübn, ve dala’id-deyni ve galebetir-ricâl.',
    'en':
        'Allahumma inni a‘udhu bika minal-hammi wal-hazan, wal-‘ajzi wal-kasal, wal-bukhli wal-jubn, wa dala‘id-dayni wa ghalabatir-rijal.',
    'ar':
        'Allahumma inni a‘udhu bika minal-hammi wal-hazan, wal-‘ajzi wal-kasal, wal-bukhli wal-jubn, wa dala‘id-dayni wa ghalabatir-rijal.',
    'fr':
        'Allahoumma innî a‘oudhou bika minal-hammi wal-hazan, wal-‘ajzi wal-kasal, wal-boukhli wal-joubn, wa dala‘id-dayni wa ghalabatir-rijâl.',
    'de':
        'Allahumma inni a‘udhu bika minal-hammi wal-hazan, wal-‘ajzi wal-kasal, wal-bukhli wal-jubn, wa dala‘id-dayni wa ghalabatir-ridschal.',
    'es':
        'Allahumma inni a‘udhu bika minal-hammi wal-hazan, wal-‘ajzi wal-kasal, wal-bukhli wal-yubn, wa dala‘id-dayni wa ghalabatir-riyal.',
    'id':
        'Allahumma inni a‘udzu bika minal-hammi wal-hazan, wal-‘ajzi wal-kasal, wal-bukhli wal-jubn, wa dala‘id-dayni wa ghalabatir-rijal.',
    'ms':
        'Allahumma inni a‘uzu bika minal-hammi wal-hazan, wal-‘ajzi wal-kasal, wal-bukhli wal-jubn, wa dala‘id-dayni wa ghalabatir-rijal.',
    'ur':
        'Allahumma inni a‘udhu bika minal-hammi wal-hazan, wal-‘ajzi wal-kasal, wal-bukhli wal-jubn, wa dala‘id-dayni wa ghalabatir-rijal.',
    'ru':
        'Аллахумма инни а‘узу бика миналь-хамми валь-хазан, валь-‘аджзи валь-касаль, валь-бухли валь-джубн, ва дала‘ид-дайни ва галабатир-риджаль.',
  }),
  meaning: LocalizedValue({
    'tr':
        'Allah’ım! Kaygı ve üzüntüden, güçsüzlük ve tembellikten, cimrilik ve korkaklıktan, borcun ağırlığından ve insanların baskısından Sana sığınırım.',
    'en':
        'O Allah, I seek refuge in You from worry and grief, incapacity and laziness, miserliness and cowardice, the burden of debt and being overpowered by others.',
    'ar':
        'اللهم إني ألتجئ إليك من الهم والحزن، والعجز والكسل، والبخل والجبن، وثقل الدين وغلبة الناس.',
    'fr':
        'Ô Allah, je cherche refuge auprès de Toi contre l’inquiétude, la tristesse, l’incapacité, la paresse, l’avarice, la lâcheté, le poids des dettes et la domination des gens.',
    'de':
        'O Allah, ich suche Zuflucht bei Dir vor Sorge und Trauer, Unfähigkeit und Trägheit, Geiz und Feigheit, der Last der Schulden und der Überwältigung durch andere.',
    'es':
        'Oh Allah, busco refugio en Ti de la preocupación, la tristeza, la incapacidad, la pereza, la avaricia, la cobardía, el peso de las deudas y el dominio de otros.',
    'id':
        'Ya Allah, aku berlindung kepada-Mu dari kecemasan dan kesedihan, kelemahan dan kemalasan, kekikiran dan ketakutan, beban utang dan tekanan orang lain.',
    'ms':
        'Ya Allah, aku berlindung kepada-Mu daripada keresahan dan kesedihan, kelemahan dan kemalasan, kekikiran dan ketakutan, beban hutang dan tekanan manusia.',
    'ur':
        'اے اللہ! میں فکر و غم، بے بسی و سستی، بخل و بزدلی، قرض کے بوجھ اور لوگوں کے غلبے سے تیری پناہ مانگتا ہوں۔',
    'ru':
        'О Аллах, прибегаю к Твоей защите от тревоги и печали, бессилия и лени, скупости и трусости, тяжести долгов и притеснения людей.',
  }),
  source: LocalizedValue({
    'tr': 'Sahih Buhari 6369',
    'en': 'Sahih al-Bukhari 6369',
    'ar': 'صحيح البخاري 6369',
    'fr': 'Sahih al-Bukhari 6369',
    'de': 'Sahih al-Bukhari 6369',
    'es': 'Sahih al-Bukhari 6369',
    'id': 'Sahih al-Bukhari 6369',
    'ms': 'Sahih al-Bukhari 6369',
    'ur': 'صحیح بخاری 6369',
    'ru': 'Сахих аль-Бухари 6369',
  }),
  target: 1,
);

const DhikrContent _istighfar = DhikrContent(
  name: LocalizedValue({
    'tr': 'Estağfirullah',
    'en': 'Astaghfirullah',
    'ar': 'أستغفر الله',
    'fr': 'Astaghfirullah',
    'de': 'Astaghfirullah',
    'es': 'Astaghfirullah',
    'id': 'Astaghfirullah',
    'ms': 'Astaghfirullah',
    'ur': 'استغفراللہ',
    'ru': 'Астагфируллах',
  }),
  arabic: 'أَسْتَغْفِرُ اللَّهَ',
  pronunciation: LocalizedValue({
    'tr': 'Estağfirullah',
    'en': 'Astaghfirullah',
    'ar': 'Astaghfirullah',
    'fr': 'Astaghfiroullah',
    'de': 'Astaghfirullah',
    'es': 'Astaghfirullah',
    'id': 'Astaghfirullah',
    'ms': 'Astaghfirullah',
    'ur': 'Astaghfirullah',
    'ru': 'Астагфируллах',
  }),
  meaning: LocalizedValue({
    'tr': 'Allah’tan bağışlanma dilerim.',
    'en': 'I seek forgiveness from Allah.',
    'ar': 'أطلب المغفرة من الله.',
    'fr': 'Je demande pardon à Allah.',
    'de': 'Ich bitte Allah um Vergebung.',
    'es': 'Pido perdón a Allah.',
    'id': 'Aku memohon ampun kepada Allah.',
    'ms': 'Aku memohon keampunan daripada Allah.',
    'ur': 'میں اللہ سے بخشش مانگتا ہوں۔',
    'ru': 'Я прошу Аллаха о прощении.',
  }),
  source: LocalizedValue({
    'tr': 'Kur’an 71:10 ve sahih rivayetlerde genel istiğfar',
    'en':
        'Quran 71:10 and general seeking of forgiveness in authentic narrations',
    'ar': 'القرآن 71:10 والاستغفار الوارد في الأحاديث الصحيحة',
    'fr': 'Coran 71:10 et demande de pardon dans les récits authentiques',
    'de':
        'Koran 71:10 und allgemeines Bitten um Vergebung in authentischen Überlieferungen',
    'es': 'Corán 71:10 y petición de perdón en narraciones auténticas',
    'id': 'Al-Qur’an 71:10 dan istigfar dalam riwayat sahih',
    'ms': 'Al-Quran 71:10 dan istighfar dalam riwayat sahih',
    'ur': 'قرآن 71:10 اور صحیح روایات میں استغفار',
    'ru': 'Коран 71:10 и истигфар в достоверных преданиях',
  }),
  target: 100,
);

const DhikrContent _alhamdulillah = DhikrContent(
  name: LocalizedValue({
    'tr': 'Elhamdülillah',
    'en': 'Alhamdulillah',
    'ar': 'الحمد لله',
    'fr': 'Alhamdulillah',
    'de': 'Alhamdulillah',
    'es': 'Alhamdulillah',
    'id': 'Alhamdulillah',
    'ms': 'Alhamdulillah',
    'ur': 'الحمدللہ',
    'ru': 'Альхамдулиллях',
  }),
  arabic: 'الْحَمْدُ لِلَّهِ',
  pronunciation: LocalizedValue({
    'tr': 'Elhamdülillah',
    'en': 'Alhamdulillah',
    'ar': 'Alhamdulillah',
    'fr': 'Al-hamdoulillah',
    'de': 'Alhamdulillah',
    'es': 'Alhamdulillah',
    'id': 'Alhamdulillah',
    'ms': 'Alhamdulillah',
    'ur': 'Alhamdulillah',
    'ru': 'Альхамдулиллях',
  }),
  meaning: LocalizedValue({
    'tr': 'Hamd ve övgü Allah’a aittir.',
    'en': 'All praise and thanks belong to Allah.',
    'ar': 'كل الحمد والشكر لله.',
    'fr': 'Toute louange et toute gratitude appartiennent à Allah.',
    'de': 'Alles Lob und aller Dank gebühren Allah.',
    'es': 'Toda alabanza y gratitud pertenecen a Allah.',
    'id': 'Segala puji dan syukur milik Allah.',
    'ms': 'Segala puji dan syukur milik Allah.',
    'ur': 'تمام تعریف اور شکر اللہ ہی کے لیے ہے۔',
    'ru': 'Вся хвала и благодарность принадлежат Аллаху.',
  }),
  source: LocalizedValue({
    'tr': 'Kur’an’da ve sahih hadislerde sıkça geçen hamd ifadesi',
    'en':
        'A phrase of praise repeatedly found in the Quran and authentic hadith',
    'ar': 'صيغة حمد متكررة في القرآن والأحاديث الصحيحة',
    'fr':
        'Formule de louange fréquemment citée dans le Coran et les hadiths authentiques',
    'de':
        'Eine häufig im Koran und in authentischen Hadithen erwähnte Lobpreisung',
    'es':
        'Expresión de alabanza frecuente en el Corán y los hadices auténticos',
    'id':
        'Ungkapan pujian yang banyak terdapat dalam Al-Qur’an dan hadis sahih',
    'ms': 'Ungkapan pujian yang banyak terdapat dalam Al-Quran dan hadis sahih',
    'ur': 'قرآن اور صحیح احادیث میں بار بار آنے والا حمد کا کلمہ',
    'ru':
        'Фраза восхваления, часто встречающаяся в Коране и достоверных хадисах',
  }),
  target: 33,
);

const DhikrContent _subhanallah = DhikrContent(
  name: LocalizedValue({
    'tr': 'Sübhanallahi ve bihamdihî',
    'en': 'SubhanAllahi wa bihamdihi',
    'ar': 'سبحان الله وبحمده',
    'fr': 'SubhanAllahi wa bihamdihi',
    'de': 'SubhanAllahi wa bihamdihi',
    'es': 'SubhanAllahi wa bihamdihi',
    'id': 'SubhanAllahi wa bihamdihi',
    'ms': 'SubhanAllahi wa bihamdihi',
    'ur': 'سبحان اللہ وبحمدہ',
    'ru': 'Субханаллахи ва бихамдихи',
  }),
  arabic: 'سُبْحَانَ اللَّهِ وَبِحَمْدِهِ',
  pronunciation: LocalizedValue({
    'tr': 'Sübhânallahi ve bihamdihî',
    'en': 'SubhanAllahi wa bihamdihi',
    'ar': 'SubhanAllahi wa bihamdihi',
    'fr': 'Soubhânallâhi wa bihamdihi',
    'de': 'SubhanAllahi wa bihamdihi',
    'es': 'SubhanAllahi wa bihamdihi',
    'id': 'SubhanAllahi wa bihamdihi',
    'ms': 'SubhanAllahi wa bihamdihi',
    'ur': 'SubhanAllahi wa bihamdihi',
    'ru': 'Субханаллахи ва бихамдихи',
  }),
  meaning: LocalizedValue({
    'tr': 'Allah’ı noksan sıfatlardan tenzih eder ve O’na hamd ederim.',
    'en': 'Glory and praise belong to Allah.',
    'ar': 'أنزّه الله عن كل نقص وأحمده.',
    'fr': 'Gloire et louange à Allah.',
    'de': 'Preis und Lob gebühren Allah.',
    'es': 'Gloria y alabanza pertenecen a Allah.',
    'id': 'Mahasuci Allah dan segala puji bagi-Nya.',
    'ms': 'Maha Suci Allah dan segala puji bagi-Nya.',
    'ur': 'اللہ پاک ہے اور تمام تعریف اسی کے لیے ہے۔',
    'ru': 'Пречист Аллах, и Ему принадлежит хвала.',
  }),
  source: LocalizedValue({
    'tr': 'Sahih Buhari 6405; Sahih Müslim 2692',
    'en': 'Sahih al-Bukhari 6405; Sahih Muslim 2692',
    'ar': 'صحيح البخاري 6405؛ صحيح مسلم 2692',
    'fr': 'Sahih al-Bukhari 6405 ; Sahih Muslim 2692',
    'de': 'Sahih al-Bukhari 6405; Sahih Muslim 2692',
    'es': 'Sahih al-Bukhari 6405; Sahih Muslim 2692',
    'id': 'Sahih al-Bukhari 6405; Sahih Muslim 2692',
    'ms': 'Sahih al-Bukhari 6405; Sahih Muslim 2692',
    'ur': 'صحیح بخاری 6405؛ صحیح مسلم 2692',
    'ru': 'Сахих аль-Бухари 6405; Сахих Муслим 2692',
  }),
  target: 100,
);

const DhikrContent _knowledgeDua = DhikrContent(
  name: LocalizedValue({
    'tr': 'İlim Duası',
    'en': 'Supplication for Knowledge',
    'ar': 'دعاء طلب العلم',
    'fr': 'Invocation pour la connaissance',
    'de': 'Bittgebet um Wissen',
    'es': 'Súplica por conocimiento',
    'id': 'Doa Memohon Ilmu',
    'ms': 'Doa Memohon Ilmu',
    'ur': 'علم کی دعا',
    'ru': 'Мольба о знании',
  }),
  arabic: 'رَبِّ زِدْنِي عِلْمًا',
  pronunciation: LocalizedValue({
    'tr': 'Rabbî zidnî ilmâ',
    'en': 'Rabbi zidni ‘ilma',
    'ar': 'Rabbi zidni ‘ilma',
    'fr': 'Rabbi zidnî ‘ilman',
    'de': 'Rabbi zidni ‘ilma',
    'es': 'Rabbi zidni ‘ilma',
    'id': 'Rabbi zidni ‘ilma',
    'ms': 'Rabbi zidni ‘ilma',
    'ur': 'Rabbi zidni ‘ilma',
    'ru': 'Рабби зидни ‘ильма',
  }),
  meaning: LocalizedValue({
    'tr': 'Rabbim, ilmimi artır.',
    'en': 'My Lord, increase me in knowledge.',
    'ar': 'يا رب، زدني علمًا.',
    'fr': 'Seigneur, augmente-moi en connaissance.',
    'de': 'Mein Herr, mehre mein Wissen.',
    'es': 'Señor mío, aumenta mi conocimiento.',
    'id': 'Ya Tuhanku, tambahkanlah ilmuku.',
    'ms': 'Wahai Tuhanku, tambahkanlah ilmuku.',
    'ur': 'اے میرے رب، میرے علم میں اضافہ فرما۔',
    'ru': 'Господь мой, приумножь мои знания.',
  }),
  source: LocalizedValue({
    'tr': 'Kur’an, Tâhâ 20:114',
    'en': 'Quran, Taha 20:114',
    'ar': 'القرآن، طه 20:114',
    'fr': 'Coran, Tâ-Hâ 20:114',
    'de': 'Koran, Tā-Hā 20:114',
    'es': 'Corán, Taha 20:114',
    'id': 'Al-Qur’an, Taha 20:114',
    'ms': 'Al-Quran, Taha 20:114',
    'ur': 'قرآن، طٰہٰ 20:114',
    'ru': 'Коран, Та Ха 20:114',
  }),
  target: 7,
);

const DhikrContent _familyDua = DhikrContent(
  name: LocalizedValue({
    'tr': 'Aile Duası',
    'en': 'Supplication for Family',
    'ar': 'دعاء الأسرة',
    'fr': 'Invocation pour la famille',
    'de': 'Bittgebet für die Familie',
    'es': 'Súplica por la familia',
    'id': 'Doa untuk Keluarga',
    'ms': 'Doa untuk Keluarga',
    'ur': 'اہل خانہ کی دعا',
    'ru': 'Мольба за семью',
  }),
  arabic:
      'رَبَّنَا هَبْ لَنَا مِنْ أَزْوَاجِنَا وَذُرِّيَّاتِنَا قُرَّةَ أَعْيُنٍ وَاجْعَلْنَا لِلْمُتَّقِينَ إِمَامًا',
  pronunciation: LocalizedValue({
    'tr':
        'Rabbenâ heb lenâ min ezvâcinâ ve zürriyyâtinâ kurrete a’yunin vec’alnâ lil-müttakîne imâmâ.',
    'en':
        'Rabbana hab lana min azwajina wa dhurriyyatina qurrata a‘yunin waj‘alna lil-muttaqina imama.',
    'ar':
        'Rabbana hab lana min azwajina wa dhurriyyatina qurrata a‘yunin waj‘alna lil-muttaqina imama.',
    'fr':
        'Rabbanâ hab lanâ min azwâjinâ wa dhourriyyâtinâ qourrata a‘yunin waj‘alnâ lil-mouttaqîna imâmâ.',
    'de':
        'Rabbana hab lana min azwadschina wa dhurriyyatina qurrata a‘yunin wadsch‘alna lil-muttaqina imama.',
    'es':
        'Rabbana hab lana min azwayina wa dhurriyyatina qurrata a‘yunin way‘alna lil-muttaqina imama.',
    'id':
        'Rabbana hab lana min azwajina wa dzurriyyatina qurrata a‘yunin waj‘alna lil-muttaqina imama.',
    'ms':
        'Rabbana hab lana min azwajina wa zurriyyatina qurrata a‘yunin waj‘alna lil-muttaqina imama.',
    'ur':
        'Rabbana hab lana min azwajina wa dhurriyyatina qurrata a‘yunin waj‘alna lil-muttaqina imama.',
    'ru':
        'Раббана хаб лана мин азваджина ва зуррийятина куррата а‘юнин вадж‘альна лиль-муттакина имама.',
  }),
  meaning: LocalizedValue({
    'tr':
        'Rabbimiz! Eşlerimizi ve çocuklarımızı bize göz aydınlığı kıl ve bizi takva sahiplerine önder eyle.',
    'en':
        'Our Lord, bless us with spouses and children who are the joy of our hearts, and make us examples for the mindful.',
    'ar': 'ربنا اجعل أزواجنا وذرياتنا سرورًا لقلوبنا واجعلنا قدوة للمتقين.',
    'fr':
        'Seigneur, accorde-nous en nos époux et nos enfants la joie des yeux et fais de nous des exemples pour les pieux.',
    'de':
        'Unser Herr, schenke uns an unseren Ehepartnern und Kindern Freude und mache uns zu Vorbildern für die Gottesfürchtigen.',
    'es':
        'Señor nuestro, concédenos alegría en nuestros cónyuges e hijos y haznos ejemplo para los piadosos.',
    'id':
        'Ya Tuhan kami, jadikan pasangan dan keturunan kami penyejuk mata, dan jadikan kami teladan bagi orang bertakwa.',
    'ms':
        'Wahai Tuhan kami, jadikan pasangan dan zuriat kami penyejuk mata dan jadikan kami teladan bagi orang bertakwa.',
    'ur':
        'اے ہمارے رب! ہماری بیویوں اور اولاد کو ہماری آنکھوں کی ٹھنڈک بنا اور ہمیں متقیوں کا پیشوا بنا۔',
    'ru':
        'Господь наш, даруй нам в супругах и потомстве радость глаз и сделай нас примером для богобоязненных.',
  }),
  source: LocalizedValue({
    'tr': 'Kur’an, Furkân 25:74',
    'en': 'Quran, Al-Furqan 25:74',
    'ar': 'القرآن، الفرقان 25:74',
    'fr': 'Coran, Al-Furqân 25:74',
    'de': 'Koran, Al-Furqān 25:74',
    'es': 'Corán, Al-Furqan 25:74',
    'id': 'Al-Qur’an, Al-Furqan 25:74',
    'ms': 'Al-Quran, Al-Furqan 25:74',
    'ur': 'قرآن، الفرقان 25:74',
    'ru': 'Коран, Аль-Фуркан 25:74',
  }),
  target: 7,
);

const DhikrContent _travelDua = DhikrContent(
  name: LocalizedValue({
    'tr': 'Yolculuk Zikri',
    'en': 'Travel Remembrance',
    'ar': 'ذكر السفر',
    'fr': 'Rappel du voyage',
    'de': 'Reise-Dhikr',
    'es': 'Recuerdo para el viaje',
    'id': 'Zikir Perjalanan',
    'ms': 'Zikir Perjalanan',
    'ur': 'سفر کا ذکر',
    'ru': 'Зикр в путешествии',
  }),
  arabic:
      'سُبْحَانَ الَّذِي سَخَّرَ لَنَا هَذَا وَمَا كُنَّا لَهُ مُقْرِنِينَ ۝ وَإِنَّا إِلَى رَبِّنَا لَمُنْقَلِبُونَ',
  pronunciation: LocalizedValue({
    'tr':
        'Sübhânellezî sehhara lenâ hâzâ ve mâ kunnâ lehû mukrinîn. Ve innâ ilâ Rabbinâ le munkalibûn.',
    'en':
        'Subhanalladhi sakhkhara lana hadha wa ma kunna lahu muqrinin. Wa inna ila Rabbina lamunqalibun.',
    'ar':
        'Subhanalladhi sakhkhara lana hadha wa ma kunna lahu muqrinin. Wa inna ila Rabbina lamunqalibun.',
    'fr':
        'Soubhânalladhî sakhkhara lanâ hâdhâ wa mâ kounnâ lahou mouqrinîn. Wa innâ ilâ Rabbinâ lamounqaliboun.',
    'de':
        'Subhanalladhi sakhkhara lana hadha wa ma kunna lahu muqrinin. Wa inna ila Rabbina lamunqalibun.',
    'es':
        'Subhanalladhi sakhkhara lana hadha wa ma kunna lahu muqrinin. Wa inna ila Rabbina lamunqalibun.',
    'id':
        'Subhanalladzi sakhkhara lana hadza wa ma kunna lahu muqrinin. Wa inna ila Rabbina lamunqalibun.',
    'ms':
        'Subhanallazi sakhkhara lana haza wa ma kunna lahu muqrinin. Wa inna ila Rabbina lamunqalibun.',
    'ur':
        'Subhanalladhi sakhkhara lana hadha wa ma kunna lahu muqrinin. Wa inna ila Rabbina lamunqalibun.',
    'ru':
        'Субханаллязи саххара лана хаза ва ма кунна ляху мукринин. Ва инна иля Раббина лямункалибун.',
  }),
  meaning: LocalizedValue({
    'tr':
        'Bunu hizmetimize veren Allah’ı noksan sıfatlardan tenzih ederiz; yoksa bizim buna gücümüz yetmezdi. Şüphesiz Rabbimize döneceğiz.',
    'en':
        'Glory be to the One Who subjected this for us, for we could not have controlled it. Surely to our Lord we will return.',
    'ar': 'سبحان من سخر لنا هذا وما كنا قادرين عليه، وإنا إلى ربنا راجعون.',
    'fr':
        'Gloire à Celui qui a mis ceci à notre service alors que nous n’aurions pu le maîtriser. Nous retournerons vers notre Seigneur.',
    'de':
        'Gepriesen sei Derjenige, Der uns dies dienstbar gemacht hat, obwohl wir es nicht beherrschen könnten. Zu unserem Herrn kehren wir zurück.',
    'es':
        'Gloria a Quien puso esto a nuestro servicio, pues no podríamos dominarlo. A nuestro Señor regresaremos.',
    'id':
        'Mahasuci Dia yang menundukkan kendaraan ini bagi kami, padahal kami tidak mampu menguasainya. Kepada Tuhan kami akan kembali.',
    'ms':
        'Maha Suci Dia yang menundukkan kenderaan ini untuk kami, sedangkan kami tidak mampu menguasainya. Kepada Tuhan kami akan kembali.',
    'ur':
        'پاک ہے وہ ذات جس نے اسے ہمارے تابع کر دیا، ورنہ ہم اسے قابو میں نہیں لا سکتے تھے، اور ہم اپنے رب ہی کی طرف لوٹنے والے ہیں۔',
    'ru':
        'Пречист Тот, Кто подчинил нам это, ведь сами мы не смогли бы овладеть им. Поистине, к нашему Господу мы вернёмся.',
  }),
  source: LocalizedValue({
    'tr': 'Kur’an, Zuhruf 43:13-14',
    'en': 'Quran, Az-Zukhruf 43:13-14',
    'ar': 'القرآن، الزخرف 43:13-14',
    'fr': 'Coran, Az-Zukhruf 43:13-14',
    'de': 'Koran, Az-Zukhruf 43:13-14',
    'es': 'Corán, Az-Zukhruf 43:13-14',
    'id': 'Al-Qur’an, Az-Zukhruf 43:13-14',
    'ms': 'Al-Quran, Az-Zukhruf 43:13-14',
    'ur': 'قرآن، الزخرف 43:13-14',
    'ru': 'Коран, Аз-Зухруф 43:13-14',
  }),
  target: 1,
);

const List<DhikrProgram> dhikrPrograms = [
  DhikrProgram(
    id: 'sad',
    icon: Icons.sentiment_dissatisfied_rounded,
    title: LocalizedValue({
      'tr': 'Moralim Bozuk',
      'en': 'I Feel Sad',
      'ar': 'أشعر بالحزن',
      'fr': 'Je me sens triste',
      'de': 'Ich bin traurig',
      'es': 'Me siento triste',
      'id': 'Saya Merasa Sedih',
      'ms': 'Saya Berasa Sedih',
      'ur': 'میں اداس ہوں',
      'ru': 'Мне грустно',
    }),
    description: _reflectionDescription,
    content: _hasbunallah,
  ),
  DhikrProgram(
    id: 'stress',
    icon: Icons.psychology_alt_rounded,
    title: LocalizedValue({
      'tr': 'Stresliyim',
      'en': 'I Feel Stressed',
      'ar': 'أشعر بالتوتر',
      'fr': 'Je suis stressé',
      'de': 'Ich bin gestresst',
      'es': 'Estoy estresado',
      'id': 'Saya Merasa Stres',
      'ms': 'Saya Berasa Tertekan',
      'ur': 'میں دباؤ میں ہوں',
      'ru': 'Я испытываю стресс',
    }),
    description: _duaDescription,
    content: _anxietyDua,
  ),
  DhikrProgram(
    id: 'tight',
    icon: Icons.favorite_border_rounded,
    title: LocalizedValue({
      'tr': 'İçim Daralıyor',
      'en': 'My Heart Feels Heavy',
      'ar': 'أشعر بضيق في صدري',
      'fr': 'J’ai le cœur lourd',
      'de': 'Mein Herz fühlt sich schwer an',
      'es': 'Siento el corazón oprimido',
      'id': 'Hati Saya Terasa Sempit',
      'ms': 'Hati Saya Terasa Sempit',
      'ur': 'میرا دل گھبرا رہا ہے',
      'ru': 'У меня тяжело на сердце',
    }),
    description: _duaDescription,
    content: _anxietyDua,
  ),
  DhikrProgram(
    id: 'difficulties',
    icon: Icons.route_rounded,
    title: LocalizedValue({
      'tr': 'İşlerim Ters Gidiyor',
      'en': 'Things Are Going Wrong',
      'ar': 'تتعسر أموري',
      'fr': 'Mes affaires vont mal',
      'de': 'Die Dinge laufen nicht gut',
      'es': 'Las cosas van mal',
      'id': 'Urusan Saya Terasa Sulit',
      'ms': 'Urusan Saya Terasa Sukar',
      'ur': 'میرے معاملات مشکل ہو رہے ہیں',
      'ru': 'Дела идут не так',
    }),
    description: _reflectionDescription,
    content: _hasbunallah,
  ),
  DhikrProgram(
    id: 'exam',
    icon: Icons.school_rounded,
    title: LocalizedValue({
      'tr': 'Sınava Gireceğim',
      'en': 'I Have an Exam',
      'ar': 'لدي اختبار',
      'fr': 'J’ai un examen',
      'de': 'Ich habe eine Prüfung',
      'es': 'Tengo un examen',
      'id': 'Saya Akan Menghadapi Ujian',
      'ms': 'Saya Akan Menghadapi Peperiksaan',
      'ur': 'میرا امتحان ہے',
      'ru': 'У меня экзамен',
    }),
    description: _duaDescription,
    content: _knowledgeDua,
  ),
  DhikrProgram(
    id: 'meeting',
    icon: Icons.business_center_rounded,
    title: LocalizedValue({
      'tr': 'Önemli Görüşmem Var',
      'en': 'I Have an Important Meeting',
      'ar': 'لدي لقاء مهم',
      'fr': 'J’ai une réunion importante',
      'de': 'Ich habe ein wichtiges Gespräch',
      'es': 'Tengo una reunión importante',
      'id': 'Saya Memiliki Pertemuan Penting',
      'ms': 'Saya Ada Pertemuan Penting',
      'ur': 'میری اہم ملاقات ہے',
      'ru': 'У меня важная встреча',
    }),
    description: _reflectionDescription,
    content: _hasbunallah,
  ),
  DhikrProgram(
    id: 'rizq',
    icon: Icons.work_outline_rounded,
    title: LocalizedValue({
      'tr': 'İş ve Rızık İçin',
      'en': 'For Work and Provision',
      'ar': 'للعمل والرزق',
      'fr': 'Pour le travail et la subsistance',
      'de': 'Für Arbeit und Versorgung',
      'es': 'Por trabajo y sustento',
      'id': 'Untuk Pekerjaan dan Rezeki',
      'ms': 'Untuk Pekerjaan dan Rezeki',
      'ur': 'کام اور رزق کے لیے',
      'ru': 'Для работы и удела',
    }),
    description: _duaDescription,
    content: _hasbunallah,
  ),
  DhikrProgram(
    id: 'gratitude',
    icon: Icons.volunteer_activism_rounded,
    title: LocalizedValue({
      'tr': 'Şükretmek İstiyorum',
      'en': 'I Want to Give Thanks',
      'ar': 'أريد أن أشكر الله',
      'fr': 'Je veux remercier Allah',
      'de': 'Ich möchte dankbar sein',
      'es': 'Quiero dar gracias',
      'id': 'Saya Ingin Bersyukur',
      'ms': 'Saya Ingin Bersyukur',
      'ur': 'میں شکر ادا کرنا چاہتا ہوں',
      'ru': 'Я хочу выразить благодарность',
    }),
    description: _gratitudeDescription,
    content: _alhamdulillah,
  ),
  DhikrProgram(
    id: 'forgiveness',
    icon: Icons.water_drop_outlined,
    title: LocalizedValue({
      'tr': 'Bağışlanmak İstiyorum',
      'en': 'I Seek Forgiveness',
      'ar': 'أطلب المغفرة',
      'fr': 'Je demande pardon',
      'de': 'Ich bitte um Vergebung',
      'es': 'Busco el perdón',
      'id': 'Saya Memohon Ampunan',
      'ms': 'Saya Memohon Keampunan',
      'ur': 'میں بخشش چاہتا ہوں',
      'ru': 'Я прошу прощения',
    }),
    description: _reflectionDescription,
    content: _istighfar,
  ),
  DhikrProgram(
    id: 'sleep',
    icon: Icons.bedtime_rounded,
    title: LocalizedValue({
      'tr': 'Uyumadan Önce',
      'en': 'Before Sleep',
      'ar': 'قبل النوم',
      'fr': 'Avant de dormir',
      'de': 'Vor dem Schlafen',
      'es': 'Antes de dormir',
      'id': 'Sebelum Tidur',
      'ms': 'Sebelum Tidur',
      'ur': 'سونے سے پہلے',
      'ru': 'Перед сном',
    }),
    description: _morningEveningDescription,
    content: _subhanallah,
  ),
  DhikrProgram(
    id: 'morning',
    icon: Icons.wb_sunny_outlined,
    title: LocalizedValue({
      'tr': 'Sabah Zikri',
      'en': 'Morning Dhikr',
      'ar': 'أذكار الصباح',
      'fr': 'Dhikr du matin',
      'de': 'Morgen-Dhikr',
      'es': 'Dhikr de la mañana',
      'id': 'Zikir Pagi',
      'ms': 'Zikir Pagi',
      'ur': 'صبح کا ذکر',
      'ru': 'Утренний зикр',
    }),
    description: _morningEveningDescription,
    content: _subhanallah,
  ),
  DhikrProgram(
    id: 'evening',
    icon: Icons.nights_stay_outlined,
    title: LocalizedValue({
      'tr': 'Akşam Zikri',
      'en': 'Evening Dhikr',
      'ar': 'أذكار المساء',
      'fr': 'Dhikr du soir',
      'de': 'Abend-Dhikr',
      'es': 'Dhikr de la tarde',
      'id': 'Zikir Petang',
      'ms': 'Zikir Petang',
      'ur': 'شام کا ذکر',
      'ru': 'Вечерний зикр',
    }),
    description: _morningEveningDescription,
    content: _subhanallah,
  ),
  DhikrProgram(
    id: 'travel',
    icon: Icons.flight_takeoff_rounded,
    title: LocalizedValue({
      'tr': 'Yolculuğa Çıkıyorum',
      'en': 'I Am Traveling',
      'ar': 'أنا مسافر',
      'fr': 'Je pars en voyage',
      'de': 'Ich reise',
      'es': 'Voy de viaje',
      'id': 'Saya Akan Bepergian',
      'ms': 'Saya Akan Bermusafir',
      'ur': 'میں سفر پر جا رہا ہوں',
      'ru': 'Я отправляюсь в путь',
    }),
    description: _duaDescription,
    content: _travelDua,
  ),
  DhikrProgram(
    id: 'patience',
    icon: Icons.hourglass_bottom_rounded,
    title: LocalizedValue({
      'tr': 'Sabırlı Olmak İstiyorum',
      'en': 'I Want to Be Patient',
      'ar': 'أريد أن أتحلى بالصبر',
      'fr': 'Je veux être patient',
      'de': 'Ich möchte geduldig sein',
      'es': 'Quiero tener paciencia',
      'id': 'Saya Ingin Bersabar',
      'ms': 'Saya Ingin Bersabar',
      'ur': 'میں صبر کرنا چاہتا ہوں',
      'ru': 'Я хочу проявить терпение',
    }),
    description: _reflectionDescription,
    content: _hasbunallah,
  ),
  DhikrProgram(
    id: 'family',
    icon: Icons.family_restroom_rounded,
    title: LocalizedValue({
      'tr': 'Ailem İçin Dua Etmek İstiyorum',
      'en': 'I Want to Pray for My Family',
      'ar': 'أريد الدعاء لأسرتي',
      'fr': 'Je veux prier pour ma famille',
      'de': 'Ich möchte für meine Familie beten',
      'es': 'Quiero orar por mi familia',
      'id': 'Saya Ingin Berdoa untuk Keluarga',
      'ms': 'Saya Ingin Berdoa untuk Keluarga',
      'ur': 'میں اپنے خاندان کے لیے دعا کرنا چاہتا ہوں',
      'ru': 'Я хочу помолиться за семью',
    }),
    description: _duaDescription,
    content: _familyDua,
  ),
];

import 'package:flutter/material.dart';

import '../core/localization/app_localization.dart';

class AsmaName {
  const AsmaName({
    required this.number,
    required this.arabic,
    required this.transliteration,
    required this.meanings,
    this.recommendedCount,
    this.isFeatured = false,
  });

  final int number;
  final String arabic;
  final String transliteration;
  final Map<String, String> meanings;
  final int? recommendedCount;
  final bool isFeatured;

  String meaning(BuildContext context) {
    final code = AppLocalization.languageCode(context);
    return meanings[code] ?? meanings['en'] ?? '';
  }

  String displayName(BuildContext context) {
    final code = AppLocalization.languageCode(context);

    if (transliteration.toLowerCase() == 'allah') {
      return 'Allah';
    }

    if (code == 'ar' || code == 'ur') {
      return arabic;
    }

    final cleanName = _removePrefix(transliteration);

    if (code == 'tr') {
      return 'Ya ${_turkishDisplayName(cleanName)}';
    }

    return 'Ya $cleanName';
  }

  String dhikrText(BuildContext context) => displayName(context);

  String get searchableText {
    final original = normalizeSearch(transliteration);
    final withoutPrefix = normalizeSearch(_removePrefix(transliteration));
    final turkish = normalizeSearch(
      _turkishDisplayName(_removePrefix(transliteration)),
    );

    return '$original $withoutPrefix $turkish';
  }

  static String normalizeSearch(String value) {
    var result = value.toLowerCase().trim();

    const replacements = <String, String>{
      'â': 'a',
      'î': 'i',
      'û': 'u',
      'ü': 'u',
      'ö': 'o',
      'ç': 'c',
      'ş': 's',
      'ğ': 'g',
      'ı': 'i',
      '’': '',
      "'": '',
      '-': ' ',
      '_': ' ',
    };

    replacements.forEach((from, to) {
      result = result.replaceAll(from, to);
    });

    result = result.replaceAll(RegExp(r'\s+'), ' ').trim();

    const removablePrefixes = <String>[
      'ya ',
      'al ',
      'el ',
      'ar ',
      'er ',
      'as ',
      'es ',
      'ash ',
      'at ',
      'et ',
      'az ',
      'ad ',
      'an ',
    ];

    for (final prefix in removablePrefixes) {
      if (result.startsWith(prefix)) {
        result = result.substring(prefix.length).trim();
        break;
      }
    }

    return result;
  }

  static String _removePrefix(String value) {
    var result = value.trim();

    const prefixes = <String>[
      'Ash-',
      'Ar-',
      'As-',
      'At-',
      'Az-',
      'An-',
      'Al-',
      'Ad-',
    ];

    for (final prefix in prefixes) {
      if (result.toLowerCase().startsWith(prefix.toLowerCase())) {
        result = result.substring(prefix.length);
        break;
      }
    }

    return result.replaceAll("'", '').trim();
  }

  static String _turkishDisplayName(String value) {
    final key = value
        .replaceAll("'", '')
        .replaceAll('’', '')
        .replaceAll('-', '')
        .trim();

    const names = <String, String>{
      'Rahman': 'Rahmân',
      'Rahim': 'Rahîm',
      'Malik': 'Melik',
      'Quddus': 'Kuddûs',
      'Salam': 'Selâm',
      'Mumin': 'Mü’min',
      'Muhaymin': 'Müheymin',
      'Aziz': 'Azîz',
      'Jabbar': 'Cebbâr',
      'Mutakabbir': 'Mütekebbir',
      'Khaliq': 'Hâlık',
      'Bari': 'Bârî',
      'Musawwir': 'Musavvir',
      'Ghaffar': 'Gaffâr',
      'Qahhar': 'Kahhâr',
      'Wahhab': 'Vehhâb',
      'Razzaq': 'Rezzâk',
      'Fattah': 'Fettâh',
      'Alim': 'Alîm',
      'Qabid': 'Kâbız',
      'Basit': 'Bâsıt',
      'Khafid': 'Hâfıd',
      'Rafi': 'Râfi',
      'Muizz': 'Muizz',
      'Mudhill': 'Müzill',
      'Sami': 'Semî',
      'Basir': 'Basîr',
      'Hakam': 'Hakem',
      'Adl': 'Adl',
      'Latif': 'Latîf',
      'Khabir': 'Habîr',
      'Halim': 'Halîm',
      'Azim': 'Azîm',
      'Ghafur': 'Gafûr',
      'Shakur': 'Şekûr',
      'Ali': 'Aliyy',
      'Kabir': 'Kebîr',
      'Hafiz': 'Hafîz',
      'Muqit': 'Mukît',
      'Hasib': 'Hasîb',
      'Jalil': 'Celîl',
      'Karim': 'Kerîm',
      'Raqib': 'Rakîb',
      'Mujib': 'Mücîb',
      'Wasi': 'Vâsi',
      'Hakim': 'Hakîm',
      'Wadud': 'Vedûd',
      'Majid': 'Mecîd',
      'Baith': 'Bâis',
      'Shahid': 'Şehîd',
      'Haqq': 'Hakk',
      'Wakil': 'Vekîl',
      'Qawiyy': 'Kaviyy',
      'Matin': 'Metîn',
      'Wali': 'Velî',
      'Hamid': 'Hamîd',
      'Muhsi': 'Muhsî',
      'Mubdi': 'Mübdi',
      'Muid': 'Muîd',
      'Muhyi': 'Muhyî',
      'Mumit': 'Mümît',
      'Hayy': 'Hayy',
      'Qayyum': 'Kayyûm',
      'Wajid': 'Vâcid',
      'Wahid': 'Vâhid',
      'Ahad': 'Ehad',
      'Samad': 'Samed',
      'Qadir': 'Kâdir',
      'Muqtadir': 'Muktedir',
      'Muqaddim': 'Mukaddim',
      'Muakhkhir': 'Muahhir',
      'Awwal': 'Evvel',
      'Akhir': 'Âhir',
      'Zahir': 'Zâhir',
      'Batin': 'Bâtın',
      'Mutaali': 'Müteâlî',
      'Barr': 'Berr',
      'Tawwab': 'Tevvâb',
      'Muntaqim': 'Müntekim',
      'Afuww': 'Afüvv',
      'Rauf': 'Raûf',
      'Muqsit': 'Muksit',
      'Jami': 'Câmi',
      'Ghani': 'Ganî',
      'Mughni': 'Muğnî',
      'Mani': 'Mâni',
      'Darr': 'Dârr',
      'Nafi': 'Nâfi',
      'Nur': 'Nûr',
      'Hadi': 'Hâdî',
      'Badi': 'Bedî',
      'Baqi': 'Bâkî',
      'Warith': 'Vâris',
      'Rashid': 'Reşîd',
      'Sabur': 'Sabûr',
    };

    return names[key] ?? value.replaceAll("'", '').trim();
  }
}

import 'package:flutter/material.dart';
import '../core/localization/app_localization.dart';

class AsmaName {
  const AsmaName({
    required this.number,
    required this.arabic,
    required this.transliteration,
    required this.meanings,
  });

  final int number;
  final String arabic;
  final String transliteration;
  final Map<String, String> meanings;

  String meaning(BuildContext context) {
    final code = AppLocalization.languageCode(context);
    return meanings[code] ?? meanings['en'] ?? '';
  }
}

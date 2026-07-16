import 'package:flutter/material.dart';

import '../core/localization/app_localization.dart';

class LocalizedValue {
  const LocalizedValue(this.values);

  final Map<String, String> values;

  String resolve(BuildContext context) {
    return AppLocalization.text(context, values);
  }

  String resolveCode(String languageCode) {
    return values[languageCode] ?? values['en'] ?? values.values.first;
  }
}

class DhikrContent {
  const DhikrContent({
    required this.name,
    required this.arabic,
    required this.pronunciation,
    required this.meaning,
    required this.source,
    required this.target,
  });

  final LocalizedValue name;
  final String arabic;
  final LocalizedValue pronunciation;
  final LocalizedValue meaning;
  final LocalizedValue source;
  final int target;
}

class DhikrProgram {
  const DhikrProgram({
    required this.id,
    required this.icon,
    required this.title,
    required this.description,
    required this.content,
  });

  final String id;
  final IconData icon;
  final LocalizedValue title;
  final LocalizedValue description;
  final DhikrContent content;
}

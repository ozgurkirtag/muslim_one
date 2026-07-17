import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_colors.dart';
import '../../core/localization/app_localization.dart';

class PrayerTimesScreen extends StatefulWidget {
  const PrayerTimesScreen({super.key});

  @override
  State<PrayerTimesScreen> createState() => _PrayerTimesScreenState();
}

class _PrayerTimesScreenState extends State<PrayerTimesScreen> {
  static const _savedCityKey = 'prayer_times_city';

  static const _defaultCity = _City(
    name: 'Istanbul',
    country: 'Türkiye',
    code: 'TR',
    latitude: 41.0082,
    longitude: 28.9784,
  );

  final http.Client _client = http.Client();
  _City _city = _defaultCity;
  _PrayerData? _data;
  bool _loading = true;
  String? _error;
  Timer? _clock;

  static const _ui = <String, Map<String, String>>{
    'title': {
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
    },
    'city': {
      'tr': 'Şehir Değiştir',
      'en': 'Change City',
      'ar': 'تغيير المدينة',
      'fr': 'Changer de ville',
      'de': 'Stadt ändern',
      'es': 'Cambiar ciudad',
      'id': 'Ganti Kota',
      'ms': 'Tukar Bandar',
      'ur': 'شہر تبدیل کریں',
      'ru': 'Изменить город',
    },
    'search': {
      'tr': 'Şehir ara',
      'en': 'Search city',
      'ar': 'ابحث عن مدينة',
      'fr': 'Rechercher une ville',
      'de': 'Stadt suchen',
      'es': 'Buscar ciudad',
      'id': 'Cari kota',
      'ms': 'Cari bandar',
      'ur': 'شہر تلاش کریں',
      'ru': 'Найти город',
    },
    'hint': {
      'tr': 'İstanbul, New York, Kahire...',
      'en': 'Istanbul, New York, Cairo...',
      'ar': 'إسطنبول، نيويورك، القاهرة...',
      'fr': 'Istanbul, New York, Le Caire...',
      'de': 'Istanbul, New York, Kairo...',
      'es': 'Estambul, Nueva York, El Cairo...',
      'id': 'Istanbul, New York, Kairo...',
      'ms': 'Istanbul, New York, Kaherah...',
      'ur': 'استنبول، نیویارک، قاہرہ...',
      'ru': 'Стамбул, Нью-Йорк, Каир...',
    },
    'next': {
      'tr': 'SIRADAKİ NAMAZ',
      'en': 'NEXT PRAYER',
      'ar': 'الصلاة القادمة',
      'fr': 'PROCHAINE PRIÈRE',
      'de': 'NÄCHSTES GEBET',
      'es': 'PRÓXIMA ORACIÓN',
      'id': 'SALAT BERIKUTNYA',
      'ms': 'SOLAT SETERUSNYA',
      'ur': 'اگلی نماز',
      'ru': 'СЛЕДУЮЩАЯ МОЛИТВА',
    },
    'left': {
      'tr': 'kaldı',
      'en': 'remaining',
      'ar': 'متبقي',
      'fr': 'restant',
      'de': 'verbleibend',
      'es': 'restante',
      'id': 'tersisa',
      'ms': 'berbaki',
      'ur': 'باقی',
      'ru': 'осталось',
    },
    'retry': {
      'tr': 'Tekrar Dene',
      'en': 'Try Again',
      'ar': 'حاول مرة أخرى',
      'fr': 'Réessayer',
      'de': 'Erneut versuchen',
      'es': 'Intentar de nuevo',
      'id': 'Coba Lagi',
      'ms': 'Cuba Lagi',
      'ur': 'دوبارہ کوشش کریں',
      'ru': 'Повторить',
    },
    'empty': {
      'tr': 'Şehir bulunamadı.',
      'en': 'No city found.',
      'ar': 'لم يتم العثور على مدينة.',
      'fr': 'Aucune ville trouvée.',
      'de': 'Keine Stadt gefunden.',
      'es': 'No se encontró ninguna ciudad.',
      'id': 'Kota tidak ditemukan.',
      'ms': 'Bandar tidak ditemui.',
      'ur': 'کوئی شہر نہیں ملا۔',
      'ru': 'Город не найден.',
    },
    'type': {
      'tr': 'En az 2 harf yazarak şehir ara.',
      'en': 'Type at least 2 letters to search.',
      'ar': 'اكتب حرفين على الأقل للبحث.',
      'fr': 'Saisissez au moins 2 lettres.',
      'de': 'Mindestens 2 Buchstaben eingeben.',
      'es': 'Escribe al menos 2 letras.',
      'id': 'Ketik minimal 2 huruf.',
      'ms': 'Taip sekurang-kurangnya 2 huruf.',
      'ur': 'کم از کم 2 حروف لکھیں۔',
      'ru': 'Введите не менее 2 букв.',
    },
    'note': {
      'tr':
          'Vakitler seçilen şehir ve bölgesel hesaplama yöntemine göre hesaplanır.',
      'en':
          'Times are calculated for the selected city using a regional calculation method.',
      'ar': 'تُحسب المواقيت للمدينة المختارة وفق الطريقة الإقليمية.',
      'fr': 'Les horaires sont calculés selon une méthode régionale.',
      'de': 'Die Zeiten werden mit einer regionalen Methode berechnet.',
      'es': 'Los horarios se calculan con un método regional.',
      'id': 'Waktu dihitung dengan metode regional.',
      'ms': 'Waktu dikira menggunakan kaedah serantau.',
      'ur': 'اوقات علاقائی طریقہ حساب سے نکالے جاتے ہیں۔',
      'ru': 'Время рассчитывается региональным методом.',
    },
  };

  static const _names = <String, Map<String, String>>{
    'fajr': {
      'tr': 'İmsak',
      'en': 'Fajr',
      'ar': 'الفجر',
      'fr': 'Fajr',
      'de': 'Fajr',
      'es': 'Fajr',
      'id': 'Subuh',
      'ms': 'Subuh',
      'ur': 'فجر',
      'ru': 'Фаджр',
    },
    'sunrise': {
      'tr': 'Güneş',
      'en': 'Sunrise',
      'ar': 'الشروق',
      'fr': 'Lever du soleil',
      'de': 'Sonnenaufgang',
      'es': 'Amanecer',
      'id': 'Terbit',
      'ms': 'Syuruk',
      'ur': 'طلوع آفتاب',
      'ru': 'Восход',
    },
    'dhuhr': {
      'tr': 'Öğle',
      'en': 'Dhuhr',
      'ar': 'الظهر',
      'fr': 'Dhuhr',
      'de': 'Dhuhr',
      'es': 'Dhuhr',
      'id': 'Zuhur',
      'ms': 'Zohor',
      'ur': 'ظہر',
      'ru': 'Зухр',
    },
    'asr': {
      'tr': 'İkindi',
      'en': 'Asr',
      'ar': 'العصر',
      'fr': 'Asr',
      'de': 'Asr',
      'es': 'Asr',
      'id': 'Asar',
      'ms': 'Asar',
      'ur': 'عصر',
      'ru': 'Аср',
    },
    'maghrib': {
      'tr': 'Akşam',
      'en': 'Maghrib',
      'ar': 'المغرب',
      'fr': 'Maghrib',
      'de': 'Maghrib',
      'es': 'Maghrib',
      'id': 'Magrib',
      'ms': 'Maghrib',
      'ur': 'مغرب',
      'ru': 'Магриб',
    },
    'isha': {
      'tr': 'Yatsı',
      'en': 'Isha',
      'ar': 'العشاء',
      'fr': 'Isha',
      'de': 'Isha',
      'es': 'Isha',
      'id': 'Isya',
      'ms': 'Isyak',
      'ur': 'عشاء',
      'ru': 'Иша',
    },
  };

  @override
  void initState() {
    super.initState();
    _load();
    _clock = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted && _data != null) setState(() {});
    });
  }

  @override
  void dispose() {
    _clock?.cancel();
    _client.close();
    super.dispose();
  }

  String _t(String key) => AppLocalization.text(context, _ui[key]!);
  String _name(String key) => AppLocalization.text(context, _names[key]!);

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_savedCityKey);
    if (saved != null) {
      try {
        _city = _City.fromJson(jsonDecode(saved) as Map<String, dynamic>);
      } catch (_) {}
    }
    await _fetch();
  }

  Future<void> _fetch() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final offset = await _utcOffset();
      final cityNow = DateTime.now().toUtc().add(Duration(seconds: offset));
      final date =
          '${cityNow.day.toString().padLeft(2, '0')}-'
          '${cityNow.month.toString().padLeft(2, '0')}-${cityNow.year}';

      final uri = Uri.https('api.aladhan.com', '/v1/timings/$date', {
        'latitude': '${_city.latitude}',
        'longitude': '${_city.longitude}',
        'method': '${_method(_city.code)}',
      });

      final response = await _client
          .get(uri)
          .timeout(const Duration(seconds: 15));
      final root = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 200 || root['code'] != 200) {
        throw const FormatException();
      }

      final data = root['data'] as Map<String, dynamic>;
      final times = data['timings'] as Map<String, dynamic>;
      final dateData = data['date'] as Map<String, dynamic>;
      final hijri = dateData['hijri'] as Map<String, dynamic>;
      final meta = data['meta'] as Map<String, dynamic>;

      if (!mounted) return;
      setState(() {
        _data = _PrayerData(
          fajr: _clean(times['Fajr']),
          sunrise: _clean(times['Sunrise']),
          dhuhr: _clean(times['Dhuhr']),
          asr: _clean(times['Asr']),
          maghrib: _clean(times['Maghrib']),
          isha: _clean(times['Isha']),
          date: dateData['readable']?.toString() ?? date,
          hijri:
              '${hijri['day']} ${(hijri['month'] as Map<String, dynamic>)['en']} ${hijri['year']}',
          method:
              ((meta['method'] as Map<String, dynamic>?)?['name'])
                  ?.toString() ??
              '',
          offset: offset,
        );
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _error = _t('retry');
      });
    }
  }

  String _clean(Object? value) {
    final match = RegExp(r'\d{1,2}:\d{2}').firstMatch(value?.toString() ?? '');
    return match?.group(0)?.padLeft(5, '0') ?? '--:--';
  }

  Future<int> _utcOffset() async {
    final uri = Uri.https('api.open-meteo.com', '/v1/forecast', {
      'latitude': '${_city.latitude}',
      'longitude': '${_city.longitude}',
      'current': 'temperature_2m',
      'timezone': 'auto',
      'forecast_days': '1',
    });
    try {
      final response = await _client
          .get(uri)
          .timeout(const Duration(seconds: 12));
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return (json['utc_offset_seconds'] as num).toInt();
    } catch (_) {
      return DateTime.now().timeZoneOffset.inSeconds;
    }
  }

  int _method(String code) {
    const methods = {
      'TR': 13,
      'US': 2,
      'CA': 2,
      'EG': 5,
      'SA': 4,
      'PK': 1,
      'IN': 1,
      'BD': 1,
      'AF': 1,
      'AE': 16,
      'QA': 10,
      'KW': 9,
      'MY': 17,
      'ID': 20,
      'SG': 11,
      'FR': 12,
      'RU': 14,
      'TN': 18,
      'DZ': 19,
      'MA': 21,
      'PT': 22,
      'JO': 23,
    };
    return methods[code.toUpperCase()] ?? 3;
  }

  DateTime get _cityNow =>
      DateTime.now().toUtc().add(Duration(seconds: _data?.offset ?? 0));

  ({String key, String time, Duration left})? _next() {
    final data = _data;
    if (data == null) return null;
    final prayers = [
      ('fajr', data.fajr),
      ('dhuhr', data.dhuhr),
      ('asr', data.asr),
      ('maghrib', data.maghrib),
      ('isha', data.isha),
    ];

    DateTime parse(String value, {int days = 0}) {
      final p = value.split(':');
      return DateTime(
        _cityNow.year,
        _cityNow.month,
        _cityNow.day + days,
        int.parse(p[0]),
        int.parse(p[1]),
      );
    }

    for (final prayer in prayers) {
      final time = parse(prayer.$2);
      if (time.isAfter(_cityNow)) {
        return (
          key: prayer.$1,
          time: prayer.$2,
          left: time.difference(_cityNow),
        );
      }
    }
    final tomorrow = parse(data.fajr, days: 1);
    return (key: 'fajr', time: data.fajr, left: tomorrow.difference(_cityNow));
  }

  String _duration(Duration value) {
    final d = value.isNegative ? Duration.zero : value;
    return '${d.inHours.toString().padLeft(2, '0')}:'
        '${(d.inMinutes % 60).toString().padLeft(2, '0')}:'
        '${(d.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  Future<void> _chooseCity() async {
    final selected = await showModalBottomSheet<_City>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.background,
      builder: (_) => _CitySearch(
        client: _client,
        title: _t('search'),
        hint: _t('hint'),
        initialMessage: _t('type'),
        emptyMessage: _t('empty'),
        language: AppLocalization.languageCode(context),
      ),
    );
    if (selected == null) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_savedCityKey, jsonEncode(selected.toJson()));
    if (!mounted) return;
    setState(() => _city = selected);
    await _fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: AppLocalization.isRtl(context)
          ? TextDirection.rtl
          : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_t('title')),
          actions: [
            IconButton(
              tooltip: _t('city'),
              onPressed: _chooseCity,
              icon: const Icon(Icons.location_city_rounded),
            ),
          ],
        ),
        body: _loading
            ? const Center(
                child: CircularProgressIndicator(color: AppColors.gold),
              )
            : _error != null || _data == null
            ? Center(
                child: FilledButton.icon(
                  onPressed: _fetch,
                  icon: const Icon(Icons.refresh_rounded),
                  label: Text(_t('retry')),
                ),
              )
            : RefreshIndicator(
                color: AppColors.gold,
                onRefresh: _fetch,
                child: _content(),
              ),
      ),
    );
  }

  Widget _content() {
    final data = _data!;
    final next = _next();
    final rows = [
      ('fajr', data.fajr, Icons.dark_mode_outlined),
      ('sunrise', data.sunrise, Icons.wb_sunny_outlined),
      ('dhuhr', data.dhuhr, Icons.light_mode_outlined),
      ('asr', data.asr, Icons.wb_twilight_outlined),
      ('maghrib', data.maghrib, Icons.nights_stay_outlined),
      ('isha', data.isha, Icons.bedtime_outlined),
    ];

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
      children: [
        InkWell(
          onTap: _chooseCity,
          borderRadius: BorderRadius.circular(23),
          child: Ink(
            padding: const EdgeInsets.all(19),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(23),
              border: Border.all(color: AppColors.goldDark),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on_rounded,
                  color: AppColors.goldLight,
                  size: 31,
                ),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _city.display,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${data.date} • ${data.hijri}',
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.expand_more_rounded, color: AppColors.gold),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),
        if (next != null)
          Container(
            padding: const EdgeInsets.all(23),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.surfaceSoft, AppColors.surface],
              ),
              borderRadius: BorderRadius.circular(26),
              border: Border.all(color: AppColors.gold),
            ),
            child: Column(
              children: [
                Text(
                  _t('next'),
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.4,
                  ),
                ),
                const SizedBox(height: 9),
                Text(
                  _name(next.key),
                  style: const TextStyle(
                    color: AppColors.goldLight,
                    fontSize: 31,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  next.time,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 11),
                Text(
                  '${_duration(next.left)} ${_t('left')}',
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 14),
        ...rows.map(
          (row) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: _PrayerRow(
              name: _name(row.$1),
              time: row.$2,
              icon: row.$3,
              active: next?.key == row.$1,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surfaceSoft,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.goldDark),
          ),
          child: Column(
            children: [
              Text(
                _t('note'),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 11.5,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                data.method,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.goldLight,
                  fontSize: 11.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PrayerRow extends StatelessWidget {
  const _PrayerRow({
    required this.name,
    required this.time,
    required this.icon,
    required this.active,
  });

  final String name;
  final String time;
  final IconData icon;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: active
            ? AppColors.gold.withValues(alpha: 0.11)
            : AppColors.surface,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: active ? AppColors.gold : AppColors.goldDark),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: active ? AppColors.goldLight : AppColors.textSecondary,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                color: active ? AppColors.goldLight : AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Text(
            time,
            style: TextStyle(
              color: active ? AppColors.goldLight : AppColors.textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _CitySearch extends StatefulWidget {
  const _CitySearch({
    required this.client,
    required this.title,
    required this.hint,
    required this.initialMessage,
    required this.emptyMessage,
    required this.language,
  });

  final http.Client client;
  final String title;
  final String hint;
  final String initialMessage;
  final String emptyMessage;
  final String language;

  @override
  State<_CitySearch> createState() => _CitySearchState();
}

class _CitySearchState extends State<_CitySearch> {
  Timer? _debounce;
  bool _loading = false;
  bool _searched = false;
  List<_City> _results = const [];

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _changed(String value) {
    _debounce?.cancel();
    if (value.trim().length < 2) {
      setState(() {
        _searched = false;
        _results = const [];
      });
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 450), () => _search(value));
  }

  Future<void> _search(String value) async {
    setState(() {
      _loading = true;
      _searched = true;
    });
    try {
      final uri = Uri.https('geocoding-api.open-meteo.com', '/v1/search', {
        'name': value.trim(),
        'count': '15',
        'language': widget.language,
        'format': 'json',
      });
      final response = await widget.client
          .get(uri)
          .timeout(const Duration(seconds: 15));
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final raw = (json['results'] as List<dynamic>?) ?? const [];
      final results = raw
          .whereType<Map<String, dynamic>>()
          .where((e) => e['latitude'] is num && e['longitude'] is num)
          .map(_City.fromApi)
          .toList(growable: false);
      if (mounted) setState(() => _results = results);
    } catch (_) {
      if (mounted) setState(() => _results = const []);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboard = MediaQuery.viewInsetsOf(context).bottom;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 18, 20, keyboard + 18),
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.72,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                autofocus: true,
                onChanged: _changed,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  hintText: widget.hint,
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: AppColors.gold,
                  ),
                  filled: true,
                  fillColor: AppColors.surface,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: const BorderSide(color: AppColors.goldDark),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: const BorderSide(color: AppColors.gold),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: _loading
                    ? const Center(
                        child: CircularProgressIndicator(color: AppColors.gold),
                      )
                    : !_searched
                    ? Center(
                        child: Text(
                          widget.initialMessage,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      )
                    : _results.isEmpty
                    ? Center(
                        child: Text(
                          widget.emptyMessage,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      )
                    : ListView.separated(
                        itemCount: _results.length,
                        separatorBuilder: (_, _) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final city = _results[index];
                          return ListTile(
                            leading: const Icon(
                              Icons.location_on_outlined,
                              color: AppColors.goldLight,
                            ),
                            title: Text(
                              city.name,
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            subtitle: Text(
                              city.display,
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            onTap: () => Navigator.of(context).pop(city),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _City {
  const _City({
    required this.name,
    required this.country,
    required this.code,
    required this.latitude,
    required this.longitude,
    this.region,
  });

  final String name;
  final String country;
  final String code;
  final double latitude;
  final double longitude;
  final String? region;

  String get display {
    final r = region?.trim();
    if (r != null && r.isNotEmpty && r != name) return '$name, $r, $country';
    return '$name, $country';
  }

  Map<String, Object?> toJson() => {
    'name': name,
    'country': country,
    'code': code,
    'latitude': latitude,
    'longitude': longitude,
    'region': region,
  };

  factory _City.fromJson(Map<String, dynamic> json) => _City(
    name: json['name'] as String,
    country: json['country'] as String,
    code: json['code'] as String,
    latitude: (json['latitude'] as num).toDouble(),
    longitude: (json['longitude'] as num).toDouble(),
    region: json['region'] as String?,
  );

  factory _City.fromApi(Map<String, dynamic> json) => _City(
    name: json['name']?.toString() ?? '',
    country: json['country']?.toString() ?? '',
    code: json['country_code']?.toString().toUpperCase() ?? '',
    latitude: (json['latitude'] as num).toDouble(),
    longitude: (json['longitude'] as num).toDouble(),
    region: json['admin1']?.toString(),
  );
}

class _PrayerData {
  const _PrayerData({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
    required this.date,
    required this.hijri,
    required this.method,
    required this.offset,
  });

  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;
  final String date;
  final String hijri;
  final String method;
  final int offset;
}

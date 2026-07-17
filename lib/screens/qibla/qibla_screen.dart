import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';

import '../../core/constants/app_colors.dart';
import '../../core/localization/app_localization.dart';

class QiblaScreen extends StatefulWidget {
  const QiblaScreen({super.key});

  @override
  State<QiblaScreen> createState() => _QiblaScreenState();
}

class _QiblaScreenState extends State<QiblaScreen> {
  static const double _kaabaLatitude = 21.422487;
  static const double _kaabaLongitude = 39.826206;

  StreamSubscription<CompassEvent>? _compassSubscription;

  Position? _position;
  double? _heading;
  double? _qiblaBearing;
  double? _distanceKm;

  bool _loading = true;
  bool _locationServiceDisabled = false;
  bool _permissionDeniedForever = false;
  bool _sensorUnavailable = false;

  static const _texts = <String, Map<String, String>>{
    'title': {
      'tr': 'Kıble Bulucu',
      'en': 'Qibla Finder',
      'ar': 'محدد القبلة',
      'fr': 'Direction de la Qibla',
      'de': 'Qibla-Finder',
      'es': 'Buscador de Qibla',
      'id': 'Pencari Kiblat',
      'ms': 'Pencari Kiblat',
      'ur': 'قبلہ فائنڈر',
      'ru': 'Направление Киблы',
    },
    'finding': {
      'tr': 'Konum ve pusula hazırlanıyor...',
      'en': 'Preparing location and compass...',
      'ar': 'جارٍ تجهيز الموقع والبوصلة...',
      'fr': 'Préparation de la position et de la boussole...',
      'de': 'Standort und Kompass werden vorbereitet...',
      'es': 'Preparando ubicación y brújula...',
      'id': 'Menyiapkan lokasi dan kompas...',
      'ms': 'Menyediakan lokasi dan kompas...',
      'ur': 'مقام اور کمپاس تیار ہو رہا ہے...',
      'ru': 'Подготовка геолокации и компаса...',
    },
    'direction': {
      'tr': 'Kıble Yönü',
      'en': 'Qibla Direction',
      'ar': 'اتجاه القبلة',
      'fr': 'Direction de la Qibla',
      'de': 'Qibla-Richtung',
      'es': 'Dirección de la Qibla',
      'id': 'Arah Kiblat',
      'ms': 'Arah Kiblat',
      'ur': 'قبلہ کی سمت',
      'ru': 'Направление Киблы',
    },
    'turn': {
      'tr': 'Telefonu düz tutup altın oku Kâbe simgesiyle hizalayın.',
      'en': 'Hold the phone flat and align the gold arrow with the Kaaba icon.',
      'ar': 'أمسك الهاتف بشكل مستوٍ وحاذِ السهم الذهبي مع رمز الكعبة.',
      'fr':
          'Tenez le téléphone à plat et alignez la flèche dorée avec la Kaaba.',
      'de':
          'Halte das Telefon flach und richte den goldenen Pfeil auf die Kaaba aus.',
      'es': 'Sostén el teléfono plano y alinea la flecha dorada con la Kaaba.',
      'id': 'Pegang ponsel datar dan sejajarkan panah emas dengan ikon Kaabah.',
      'ms':
          'Pegang telefon rata dan sejajarkan anak panah emas dengan ikon Kaabah.',
      'ur': 'فون کو سیدھا رکھیں اور سنہری تیر کو کعبہ کے نشان سے ملائیں۔',
      'ru':
          'Держите телефон ровно и совместите золотую стрелку со значком Каабы.',
    },
    'aligned': {
      'tr': 'Kıble yönündesiniz',
      'en': 'You are facing the Qibla',
      'ar': 'أنت باتجاه القبلة',
      'fr': 'Vous êtes face à la Qibla',
      'de': 'Du blickst in Richtung Qibla',
      'es': 'Estás orientado hacia la Qibla',
      'id': 'Anda menghadap Kiblat',
      'ms': 'Anda menghadap Kiblat',
      'ur': 'آپ قبلہ رخ ہیں',
      'ru': 'Вы смотрите в сторону Киблы',
    },
    'bearing': {
      'tr': 'Kıble açısı',
      'en': 'Qibla bearing',
      'ar': 'زاوية القبلة',
      'fr': 'Angle de la Qibla',
      'de': 'Qibla-Winkel',
      'es': 'Ángulo de la Qibla',
      'id': 'Sudut Kiblat',
      'ms': 'Sudut Kiblat',
      'ur': 'قبلہ زاویہ',
      'ru': 'Азимут Киблы',
    },
    'distance': {
      'tr': 'Kâbe mesafesi',
      'en': 'Distance to Kaaba',
      'ar': 'المسافة إلى الكعبة',
      'fr': 'Distance jusqu’à la Kaaba',
      'de': 'Entfernung zur Kaaba',
      'es': 'Distancia a la Kaaba',
      'id': 'Jarak ke Kaabah',
      'ms': 'Jarak ke Kaabah',
      'ur': 'کعبہ تک فاصلہ',
      'ru': 'Расстояние до Каабы',
    },
    'calibrate': {
      'tr':
          'Pusula sapıyorsa telefonu birkaç kez sekiz şeklinde hareket ettirin.',
      'en': 'If the compass drifts, move the phone in a figure-eight motion.',
      'ar': 'إذا انحرفت البوصلة، حرّك الهاتف على شكل الرقم ثمانية.',
      'fr': 'Si la boussole dérive, déplacez le téléphone en forme de huit.',
      'de': 'Falls der Kompass abweicht, bewege das Telefon in einer Acht.',
      'es': 'Si la brújula se desvía, mueve el teléfono formando un ocho.',
      'id': 'Jika kompas melenceng, gerakkan ponsel membentuk angka delapan.',
      'ms': 'Jika kompas tersasar, gerakkan telefon membentuk angka lapan.',
      'ur': 'اگر کمپاس درست نہ ہو تو فون کو آٹھ کی شکل میں حرکت دیں۔',
      'ru':
          'Если компас отклоняется, двигайте телефон по траектории восьмёрки.',
    },
    'locationOff': {
      'tr': 'Konum servisi kapalı. Kıbleyi hesaplamak için konumu açın.',
      'en': 'Location services are off. Enable location to calculate Qibla.',
      'ar': 'خدمات الموقع متوقفة. فعّل الموقع لحساب القبلة.',
      'fr':
          'La localisation est désactivée. Activez-la pour calculer la Qibla.',
      'de': 'Standortdienste sind deaktiviert. Aktiviere sie für die Qibla.',
      'es': 'La ubicación está desactivada. Actívala para calcular la Qibla.',
      'id': 'Layanan lokasi mati. Aktifkan lokasi untuk menghitung Kiblat.',
      'ms':
          'Perkhidmatan lokasi dimatikan. Aktifkan lokasi untuk mengira Kiblat.',
      'ur': 'لوکیشن بند ہے۔ قبلہ معلوم کرنے کے لیے لوکیشن آن کریں۔',
      'ru': 'Геолокация отключена. Включите её для расчёта Киблы.',
    },
    'permission': {
      'tr': 'Kıbleyi hesaplamak için konum izni gereklidir.',
      'en': 'Location permission is required to calculate Qibla.',
      'ar': 'إذن الموقع مطلوب لحساب القبلة.',
      'fr': 'L’autorisation de localisation est nécessaire.',
      'de':
          'Für die Qibla-Berechnung ist die Standortberechtigung erforderlich.',
      'es': 'Se requiere permiso de ubicación para calcular la Qibla.',
      'id': 'Izin lokasi diperlukan untuk menghitung Kiblat.',
      'ms': 'Kebenaran lokasi diperlukan untuk mengira Kiblat.',
      'ur': 'قبلہ معلوم کرنے کے لیے لوکیشن کی اجازت ضروری ہے۔',
      'ru': 'Для расчёта Киблы требуется доступ к геолокации.',
    },
    'settings': {
      'tr': 'Ayarları Aç',
      'en': 'Open Settings',
      'ar': 'فتح الإعدادات',
      'fr': 'Ouvrir les réglages',
      'de': 'Einstellungen öffnen',
      'es': 'Abrir ajustes',
      'id': 'Buka Pengaturan',
      'ms': 'Buka Tetapan',
      'ur': 'سیٹنگز کھولیں',
      'ru': 'Открыть настройки',
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
    'noSensor': {
      'tr':
          'Bu cihazda pusula sensörü algılanmadı. Kıble açısını aşağıdan görebilirsiniz.',
      'en':
          'No compass sensor was detected. You can still use the Qibla bearing below.',
      'ar': 'لم يتم اكتشاف مستشعر البوصلة. يمكنك استخدام زاوية القبلة أدناه.',
      'fr': 'Aucun capteur de boussole détecté. Utilisez l’angle ci-dessous.',
      'de': 'Kein Kompasssensor erkannt. Nutze den Qibla-Winkel unten.',
      'es': 'No se detectó brújula. Puedes usar el ángulo indicado abajo.',
      'id': 'Sensor kompas tidak terdeteksi. Gunakan sudut Kiblat di bawah.',
      'ms': 'Sensor kompas tidak dikesan. Gunakan sudut Kiblat di bawah.',
      'ur': 'کمپاس سینسر نہیں ملا۔ نیچے دیا گیا قبلہ زاویہ استعمال کریں۔',
      'ru': 'Датчик компаса не обнаружен. Используйте азимут ниже.',
    },
    'privacy': {
      'tr':
          'Konum yalnızca kıble yönünü hesaplamak için cihazınızda kullanılır.',
      'en':
          'Your location is used on-device only to calculate the Qibla direction.',
      'ar': 'يُستخدم موقعك على الجهاز فقط لحساب اتجاه القبلة.',
      'fr':
          'Votre position est utilisée sur l’appareil uniquement pour calculer la Qibla.',
      'de':
          'Dein Standort wird nur auf dem Gerät zur Qibla-Berechnung verwendet.',
      'es':
          'Tu ubicación se usa solo en el dispositivo para calcular la Qibla.',
      'id': 'Lokasi hanya digunakan di perangkat untuk menghitung arah Kiblat.',
      'ms': 'Lokasi hanya digunakan pada peranti untuk mengira arah Kiblat.',
      'ur':
          'آپ کا مقام صرف قبلہ کی سمت معلوم کرنے کے لیے فون پر استعمال ہوتا ہے۔',
      'ru': 'Геолокация используется только на устройстве для расчёта Киблы.',
    },
  };

  @override
  void initState() {
    super.initState();
    _start();
  }

  @override
  void dispose() {
    _compassSubscription?.cancel();
    super.dispose();
  }

  String _t(String key) => AppLocalization.text(context, _texts[key]!);

  Future<void> _start() async {
    setState(() {
      _loading = true;
      _locationServiceDisabled = false;
      _permissionDeniedForever = false;
    });

    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _locationServiceDisabled = true;
      });
      return;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _permissionDeniedForever =
            permission == LocationPermission.deniedForever;
      });
      return;
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 20),
        ),
      );

      final bearing = _calculateBearing(
        position.latitude,
        position.longitude,
        _kaabaLatitude,
        _kaabaLongitude,
      );

      final distance =
          Geolocator.distanceBetween(
            position.latitude,
            position.longitude,
            _kaabaLatitude,
            _kaabaLongitude,
          ) /
          1000;

      if (!mounted) return;
      setState(() {
        _position = position;
        _qiblaBearing = bearing;
        _distanceKm = distance;
        _loading = false;
      });

      await _compassSubscription?.cancel();
      _compassSubscription = FlutterCompass.events?.listen((event) {
        if (!mounted) return;
        final heading = event.heading;
        if (heading == null) {
          setState(() => _sensorUnavailable = true);
          return;
        }
        setState(() {
          _heading = heading;
          _sensorUnavailable = false;
        });
      });

      if (FlutterCompass.events == null && mounted) {
        setState(() => _sensorUnavailable = true);
      }
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _loading = false;
      });
    }
  }

  double _calculateBearing(
    double startLatitude,
    double startLongitude,
    double endLatitude,
    double endLongitude,
  ) {
    final startLat = _toRadians(startLatitude);
    final startLon = _toRadians(startLongitude);
    final endLat = _toRadians(endLatitude);
    final endLon = _toRadians(endLongitude);

    final longitudeDifference = endLon - startLon;
    final y = math.sin(longitudeDifference) * math.cos(endLat);
    final x =
        math.cos(startLat) * math.sin(endLat) -
        math.sin(startLat) * math.cos(endLat) * math.cos(longitudeDifference);

    return (_toDegrees(math.atan2(y, x)) + 360) % 360;
  }

  double _toRadians(double value) => value * math.pi / 180;
  double _toDegrees(double value) => value * 180 / math.pi;

  double get _rotationDegrees {
    if (_qiblaBearing == null || _heading == null) return 0;
    return (_qiblaBearing! - _heading! + 360) % 360;
  }

  bool get _isAligned {
    if (_qiblaBearing == null || _heading == null) return false;
    final difference = ((_qiblaBearing! - _heading! + 540) % 360) - 180;
    return difference.abs() <= 4;
  }

  String _cardinalDirection(double degrees) {
    final directions = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'];
    final index = ((degrees + 22.5) ~/ 45) % 8;
    return directions[index];
  }

  @override
  Widget build(BuildContext context) {
    final rtl = AppLocalization.isRtl(context);

    return Directionality(
      textDirection: rtl ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(title: Text(_t('title'))),
        body: _loading
            ? _LoadingView(text: _t('finding'))
            : _locationServiceDisabled
            ? _PermissionView(
                icon: Icons.location_off_rounded,
                message: _t('locationOff'),
                button: _t('settings'),
                onPressed: () async {
                  await Geolocator.openLocationSettings();
                },
              )
            : _position == null
            ? _PermissionView(
                icon: Icons.location_disabled_rounded,
                message: _t('permission'),
                button: _permissionDeniedForever ? _t('settings') : _t('retry'),
                onPressed: _permissionDeniedForever
                    ? Geolocator.openAppSettings
                    : _start,
              )
            : RefreshIndicator(
                color: AppColors.gold,
                onRefresh: _start,
                child: _content(),
              ),
      ),
    );
  }

  Widget _content() {
    final bearing = _qiblaBearing ?? 0;
    final rotation = _rotationDegrees;

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _isAligned ? AppColors.gold : AppColors.goldDark,
              width: _isAligned ? 1.8 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.gold.withValues(
                  alpha: _isAligned ? 0.14 : 0.05,
                ),
                blurRadius: 28,
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                _isAligned ? _t('aligned') : _t('direction'),
                style: TextStyle(
                  color: _isAligned
                      ? AppColors.goldLight
                      : AppColors.textPrimary,
                  fontSize: 21,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                _t('turn'),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 290,
                height: 290,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 275,
                      height: 275,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.background,
                        border: Border.all(color: AppColors.goldDark, width: 2),
                      ),
                    ),
                    ...List.generate(36, (index) {
                      final angle = index * 10.0;
                      final major = index % 9 == 0;
                      return Transform.rotate(
                        angle: _toRadians(angle),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            margin: const EdgeInsets.only(top: 9),
                            width: major ? 3 : 1,
                            height: major ? 17 : 9,
                            color: major
                                ? AppColors.goldLight
                                : AppColors.textSecondary,
                          ),
                        ),
                      );
                    }),
                    const Positioned(
                      top: 25,
                      child: Text(
                        'N',
                        style: TextStyle(
                          color: AppColors.goldLight,
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const Positioned(
                      bottom: 25,
                      child: Text(
                        'S',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 27,
                      child: Text(
                        'W',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const Positioned(
                      right: 27,
                      child: Text(
                        'E',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    AnimatedRotation(
                      turns: rotation / 360,
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOut,
                      child: SizedBox(
                        width: 210,
                        height: 210,
                        child: Column(
                          children: [
                            const Icon(
                              Icons.navigation_rounded,
                              color: AppColors.goldLight,
                              size: 88,
                            ),
                            const Spacer(),
                            Container(
                              width: 62,
                              height: 62,
                              decoration: BoxDecoration(
                                color: AppColors.surfaceSoft,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: AppColors.gold,
                                  width: 2,
                                ),
                              ),
                              alignment: Alignment.center,
                              child: const Text(
                                '🕋',
                                style: TextStyle(fontSize: 34),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.gold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '${bearing.toStringAsFixed(1)}° ${_cardinalDirection(bearing)}',
                style: const TextStyle(
                  color: AppColors.goldLight,
                  fontSize: 23,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        if (_sensorUnavailable || _heading == null)
          _InfoCard(icon: Icons.sensors_off_rounded, text: _t('noSensor')),
        if (_sensorUnavailable || _heading == null) const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _MetricCard(
                icon: Icons.explore_rounded,
                label: _t('bearing'),
                value: '${bearing.toStringAsFixed(1)}°',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _MetricCard(
                icon: Icons.straighten_rounded,
                label: _t('distance'),
                value: '${(_distanceKm ?? 0).round()} km',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _InfoCard(
          icon: Icons.screen_rotation_alt_rounded,
          text: _t('calibrate'),
        ),
        const SizedBox(height: 12),
        _InfoCard(icon: Icons.privacy_tip_outlined, text: _t('privacy')),
      ],
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(color: AppColors.gold),
            const SizedBox(height: 20),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textPrimary),
            ),
          ],
        ),
      ),
    );
  }
}

class _PermissionView extends StatelessWidget {
  const _PermissionView({
    required this.icon,
    required this.message,
    required this.button,
    required this.onPressed,
  });

  final IconData icon;
  final String message;
  final String button;
  final Future<void> Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.goldLight, size: 56),
            const SizedBox(height: 18),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                height: 1.45,
              ),
            ),
            const SizedBox(height: 22),
            FilledButton.icon(
              onPressed: () => onPressed(),
              icon: const Icon(Icons.settings_rounded),
              label: Text(button),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: AppColors.goldDark),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.goldLight),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceSoft,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.goldDark),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.goldLight),
          const SizedBox(width: 13),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

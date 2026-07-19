import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

import '../../core/localization/app_localization.dart';

class DigitalTasbihScreen extends StatefulWidget {
  const DigitalTasbihScreen({
    super.key,
    this.initialDhikrName = 'SubhanAllah',
    this.initialTarget = 33,
    this.startFresh = false,
  });

  final String initialDhikrName;
  final int initialTarget;
  final bool startFresh;

  @override
  State<DigitalTasbihScreen> createState() => _DigitalTasbihScreenState();
}

class _DigitalTasbihScreenState extends State<DigitalTasbihScreen> {
  static const Map<String, String> _pageTitle = {
    'tr': 'Dijital Tesbih', 'en': 'Digital Tasbih', 'ar': 'المسبحة الرقمية',
    'fr': 'Tasbih numérique', 'de': 'Digitaler Tasbih', 'es': 'Tasbih digital',
    'id': 'Tasbih Digital', 'ms': 'Tasbih Digital', 'ur': 'ڈیجیٹل تسبیح',
    'ru': 'Цифровой тасбих',
  };
  static const Map<String, String> _currentDhikr = {
    'tr': 'MEVCUT ZİKİR', 'en': 'CURRENT DHIKR', 'ar': 'الذكر الحالي',
    'fr': 'DHIKR ACTUEL', 'de': 'AKTUELLER DHIKR', 'es': 'DHIKR ACTUAL',
    'id': 'ZIKIR SAAT INI', 'ms': 'ZIKIR SEMASA', 'ur': 'موجودہ ذکر',
    'ru': 'ТЕКУЩИЙ ЗИКР',
  };
  static const Map<String, String> _count = {
    'tr': 'SAYAÇ', 'en': 'COUNT', 'ar': 'العدد', 'fr': 'COMPTEUR',
    'de': 'ZÄHLER', 'es': 'CONTADOR', 'id': 'HITUNGAN', 'ms': 'KIRAAN',
    'ur': 'تعداد', 'ru': 'СЧЁТЧИК',
  };
  static const Map<String, String> _target = {
    'tr': 'Hedef', 'en': 'Target', 'ar': 'الهدف', 'fr': 'Objectif',
    'de': 'Ziel', 'es': 'Objetivo', 'id': 'Target', 'ms': 'Sasaran',
    'ur': 'ہدف', 'ru': 'Цель',
  };
  static const Map<String, String> _remaining = {
    'tr': 'Kalan', 'en': 'Remaining', 'ar': 'المتبقي', 'fr': 'Restant',
    'de': 'Verbleibend', 'es': 'Restante', 'id': 'Tersisa', 'ms': 'Baki',
    'ur': 'باقی', 'ru': 'Осталось',
  };
  static const Map<String, String> _selectTarget = {
    'tr': 'HEDEF SEÇ', 'en': 'SELECT TARGET', 'ar': 'اختر الهدف',
    'fr': 'CHOISIR L’OBJECTIF', 'de': 'ZIEL AUSWÄHLEN',
    'es': 'ELEGIR OBJETIVO', 'id': 'PILIH TARGET', 'ms': 'PILIH SASARAN',
    'ur': 'ہدف منتخب کریں', 'ru': 'ВЫБЕРИТЕ ЦЕЛЬ',
  };
  static const Map<String, String> _custom = {
    'tr': 'Özel', 'en': 'Custom', 'ar': 'مخصص', 'fr': 'Personnalisé',
    'de': 'Benutzerdefiniert', 'es': 'Personalizado', 'id': 'Kustom',
    'ms': 'Tersuai', 'ur': 'اپنی مرضی', 'ru': 'Другое',
  };
  static const Map<String, String> _tap = {
    'tr': 'DOKUN', 'en': 'TAP', 'ar': 'اضغط', 'fr': 'TOUCHER',
    'de': 'TIPPEN', 'es': 'TOCAR', 'id': 'KETUK', 'ms': 'KETIK',
    'ur': 'دبائیں', 'ru': 'НАЖАТЬ',
  };
  static const Map<String, String> _toCount = {
    'tr': 'saymak için', 'en': 'to count', 'ar': 'للعد',
    'fr': 'pour compter', 'de': 'zum Zählen', 'es': 'para contar',
    'id': 'untuk menghitung', 'ms': 'untuk mengira', 'ur': 'گننے کے لیے',
    'ru': 'для подсчёта',
  };
  static const Map<String, String> _vibration = {
    'tr': 'Titreşim', 'en': 'Vibration', 'ar': 'الاهتزاز', 'fr': 'Vibration',
    'de': 'Vibration', 'es': 'Vibración', 'id': 'Getaran', 'ms': 'Getaran',
    'ur': 'وائبریشن', 'ru': 'Вибрация',
  };
  static const Map<String, String> _sound = {
    'tr': 'Ses', 'en': 'Sound', 'ar': 'الصوت', 'fr': 'Son', 'de': 'Ton',
    'es': 'Sonido', 'id': 'Suara', 'ms': 'Bunyi', 'ur': 'آواز', 'ru': 'Звук',
  };
  static const Map<String, String> _reset = {
    'tr': 'Sıfırla', 'en': 'Reset', 'ar': 'إعادة ضبط', 'fr': 'Réinitialiser',
    'de': 'Zurücksetzen', 'es': 'Restablecer', 'id': 'Atur Ulang',
    'ms': 'Tetapkan Semula', 'ur': 'ری سیٹ', 'ru': 'Сбросить',
  };
  static const Map<String, String> _continue = {
    'tr': 'Devam Et', 'en': 'Continue', 'ar': 'متابعة', 'fr': 'Continuer',
    'de': 'Fortfahren', 'es': 'Continuar', 'id': 'Lanjutkan', 'ms': 'Teruskan',
    'ur': 'جاری رکھیں', 'ru': 'Продолжить',
  };
  static const Map<String, String> _customTarget = {
    'tr': 'Özel Hedef', 'en': 'Custom Target', 'ar': 'هدف مخصص',
    'fr': 'Objectif personnalisé', 'de': 'Benutzerdefiniertes Ziel',
    'es': 'Objetivo personalizado', 'id': 'Target Kustom',
    'ms': 'Sasaran Tersuai', 'ur': 'اپنی مرضی کا ہدف', 'ru': 'Своя цель',
  };
  static const Map<String, String> _enterTarget = {
    'tr': 'Hedef sayısını gir', 'en': 'Enter a target',
    'ar': 'أدخل العدد المستهدف', 'fr': 'Saisissez un objectif',
    'de': 'Ziel eingeben', 'es': 'Introduce un objetivo',
    'id': 'Masukkan target', 'ms': 'Masukkan sasaran',
    'ur': 'ہدف درج کریں', 'ru': 'Введите цель',
  };
  static const Map<String, String> _setTarget = {
    'tr': 'Hedefi Ayarla', 'en': 'Set Target', 'ar': 'تعيين الهدف',
    'fr': 'Définir l’objectif', 'de': 'Ziel festlegen',
    'es': 'Establecer objetivo', 'id': 'Atur Target',
    'ms': 'Tetapkan Sasaran', 'ur': 'ہدف مقرر کریں', 'ru': 'Установить цель',
  };
  static const Map<String, String> _dhikrName = {
    'tr': 'Zikir Adı', 'en': 'Dhikr Name', 'ar': 'اسم الذكر',
    'fr': 'Nom du dhikr', 'de': 'Name des Dhikr', 'es': 'Nombre del dhikr',
    'id': 'Nama Zikir', 'ms': 'Nama Zikir', 'ur': 'ذکر کا نام',
    'ru': 'Название зикра',
  };
  static const Map<String, String> _dhikrExample = {
    'tr': 'Örnek: Sübhanallah', 'en': 'Example: SubhanAllah',
    'ar': 'مثال: سبحان الله', 'fr': 'Exemple : SubhanAllah',
    'de': 'Beispiel: SubhanAllah', 'es': 'Ejemplo: SubhanAllah',
    'id': 'Contoh: SubhanAllah', 'ms': 'Contoh: SubhanAllah',
    'ur': 'مثال: سبحان اللہ', 'ru': 'Пример: Субханаллах',
  };
  static const Map<String, String> _save = {
    'tr': 'Kaydet', 'en': 'Save', 'ar': 'حفظ', 'fr': 'Enregistrer',
    'de': 'Speichern', 'es': 'Guardar', 'id': 'Simpan', 'ms': 'Simpan',
    'ur': 'محفوظ کریں', 'ru': 'Сохранить',
  };
  static const Map<String, String> _cancel = {
    'tr': 'İptal', 'en': 'Cancel', 'ar': 'إلغاء', 'fr': 'Annuler',
    'de': 'Abbrechen', 'es': 'Cancelar', 'id': 'Batal', 'ms': 'Batal',
    'ur': 'منسوخ', 'ru': 'Отмена',
  };
  static const Map<String, String> _resetQuestion = {
    'tr': 'Sayaç sıfırlansın mı?', 'en': 'Reset Counter?',
    'ar': 'هل تريد إعادة ضبط العداد؟', 'fr': 'Réinitialiser le compteur ?',
    'de': 'Zähler zurücksetzen?', 'es': '¿Restablecer el contador?',
    'id': 'Atur ulang penghitung?', 'ms': 'Tetapkan semula kiraan?',
    'ur': 'کاؤنٹر ری سیٹ کریں؟', 'ru': 'Сбросить счётчик?',
  };
  static const Map<String, String> _resetInfo = {
    'tr': 'Mevcut sayım sıfıra dönecek.',
    'en': 'Your current count will return to zero.',
    'ar': 'سيعود العدد الحالي إلى الصفر.',
    'fr': 'Votre compteur actuel reviendra à zéro.',
    'de': 'Der aktuelle Zähler wird auf null gesetzt.',
    'es': 'El contador actual volverá a cero.',
    'id': 'Hitungan saat ini akan kembali ke nol.',
    'ms': 'Kiraan semasa akan kembali kepada sifar.',
    'ur': 'موجودہ تعداد صفر ہو جائے گی۔',
    'ru': 'Текущий счёт вернётся к нулю.',
  };
  static const Map<String, String> _targetCompleted = {
    'tr': 'Hedef tamamlandı. Allah zikrinizi kabul etsin.',
    'en': 'Target completed. May Allah accept your dhikr.',
    'ar': 'اكتمل الهدف. تقبل الله ذكرك.',
    'fr': 'Objectif atteint. Qu’Allah accepte votre dhikr.',
    'de': 'Ziel erreicht. Möge Allah deinen Dhikr annehmen.',
    'es': 'Objetivo completado. Que Allah acepte tu dhikr.',
    'id': 'Target selesai. Semoga Allah menerima zikirmu.',
    'ms': 'Sasaran selesai. Semoga Allah menerima zikir anda.',
    'ur': 'ہدف مکمل ہوا۔ اللہ آپ کا ذکر قبول فرمائے۔',
    'ru': 'Цель достигнута. Пусть Аллах примет ваш зикр.',
  };
  static const Map<String, String> _advertisement = {
    'tr': 'REKLAM', 'en': 'ADVERTISEMENT', 'ar': 'إعلان',
    'fr': 'PUBLICITÉ', 'de': 'WERBUNG', 'es': 'PUBLICIDAD',
    'id': 'IKLAN', 'ms': 'IKLAN', 'ur': 'اشتہار', 'ru': 'РЕКЛАМА',
  };
  static const Map<String, String> _bannerSpace = {
    'tr': 'Banner reklam alanı', 'en': 'Banner ad space',
    'ar': 'مساحة إعلان بانر', 'fr': 'Espace publicitaire',
    'de': 'Banner-Werbefläche', 'es': 'Espacio para banner',
    'id': 'Ruang iklan banner', 'ms': 'Ruang iklan sepanduk',
    'ur': 'بینر اشتہار کی جگہ', 'ru': 'Место для баннера',
  };

  String _text(BuildContext context, Map<String, String> values) {
    return AppLocalization.text(context, values);
  }
  static const Color _background = Color(0xFF090909);
  static const Color _surface = Color(0xFF151515);
  static const Color _surfaceSoft = Color(0xFF1E1E1E);
  static const Color _gold = Color(0xFFD4AF37);
  static const Color _goldLight = Color(0xFFF2D675);
  static const Color _goldDark = Color(0xFF9D7A19);
  static const Color _textPrimary = Color(0xFFF7F7F7);
  static const Color _textSecondary = Color(0xFFA9A9A9);

  static const String _countKey = 'digital_tasbih_count';
  static const String _targetKey = 'digital_tasbih_target';
  static const String _soundKey = 'digital_tasbih_sound';
  static const String _vibrationKey = 'digital_tasbih_vibration';
  static const String _dhikrNameKey = 'digital_tasbih_dhikr_name';

  final List<int> _presetTargets = const [33, 99, 100, 1000];
  final AudioPlayer _audioPlayer = AudioPlayer();

  int _count = 0;
  int _target = 33;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;
  bool _isLoading = true;
  bool _targetMessageShown = false;
  String _dhikrName = 'SubhanAllah';

  double get _progress {
    if (_target <= 0) {
      return 0;
    }

    return (_count / _target).clamp(0.0, 1.0);
  }

  int get _remaining {
    final remaining = _target - _count;
    return remaining < 0 ? 0 : remaining;
  }

  @override
  void initState() {
    super.initState();
    _target = widget.initialTarget;
    _dhikrName = widget.initialDhikrName;
    _loadSavedSession();
  }

  Future<void> _loadSavedSession() async {
    final preferences = await SharedPreferences.getInstance();

    if (!mounted) {
      return;
    }

    setState(() {
      if (widget.startFresh) {
        _count = 0;
        _target = widget.initialTarget;
        _dhikrName = widget.initialDhikrName;
      } else {
        _count = preferences.getInt(_countKey) ?? 0;
        _target = preferences.getInt(_targetKey) ?? widget.initialTarget;
        _dhikrName =
            preferences.getString(_dhikrNameKey) ?? widget.initialDhikrName;
      }

      _soundEnabled = preferences.getBool(_soundKey) ?? true;
      _vibrationEnabled = preferences.getBool(_vibrationKey) ?? true;
      _targetMessageShown = _count >= _target;
      _isLoading = false;
    });

    if (widget.startFresh) {
      await _saveSession();
    }
  }

  Future<void> _saveSession() async {
    final preferences = await SharedPreferences.getInstance();

    await Future.wait([
      preferences.setInt(_countKey, _count),
      preferences.setInt(_targetKey, _target),
      preferences.setBool(_soundKey, _soundEnabled),
      preferences.setBool(_vibrationKey, _vibrationEnabled),
      preferences.setString(_dhikrNameKey, _dhikrName),
    ]);
  }

  Future<void> _incrementCount() async {
    setState(() {
      _count++;
    });

    if (_vibrationEnabled) {
      unawaited(
        Vibration.vibrate(
          duration: 50,
          amplitude: 200,
        ),
      );
    }

    if (_soundEnabled) {
      unawaited(
        _audioPlayer.play(
          AssetSource('sounds/tasbih_tick.wav'),
          volume: 0.80,
        ),
      );
    }

    await _saveSession();

    if (_count >= _target && !_targetMessageShown && mounted) {
      _targetMessageShown = true;

      if (_vibrationEnabled) {
        unawaited(
          Vibration.vibrate(
            pattern: [0, 120, 60, 220],
            intensities: [0, 210, 0, 255],
          ),
        );
      }

      if (_soundEnabled) {
        unawaited(
          _audioPlayer.play(
            AssetSource('sounds/tasbih_tick.wav'),
            volume: 0.95,
          ),
        );
      }

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            backgroundColor: _surfaceSoft,
            behavior: SnackBarBehavior.floating,
            content: Text(
              _text(context, _targetCompleted),
              style: const TextStyle(color: _textPrimary),
            ),
            action: SnackBarAction(
              label: _text(context, _continue),
              textColor: _goldLight,
              onPressed: () {},
            ),
          ),
        );
    }
  }

  Future<void> _selectTarget(int target) async {
    setState(() {
      _target = target;
      _targetMessageShown = _count >= target;
    });

    await _saveSession();
  }

  Future<void> _showCustomTargetDialog() async {
    final controller = TextEditingController(
      text: _presetTargets.contains(_target) ? '' : _target.toString(),
    );

    final result = await showDialog<int>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: _surface,
          title: Text(
            _text(context, _customTarget),
            style: const TextStyle(color: _textPrimary),
          ),
          content: TextField(
            controller: controller,
            autofocus: true,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: _textPrimary),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(6),
            ],
            decoration: InputDecoration(
              hintText: _text(context, _enterTarget),
              hintStyle: const TextStyle(color: _textSecondary),
              filled: true,
              fillColor: _surfaceSoft,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: _goldDark),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: _goldLight, width: 1.5),
              ),
            ),
            onSubmitted: (_) {
              final value = int.tryParse(controller.text);

              if (value != null && value > 0) {
                Navigator.of(dialogContext).pop(value);
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                _text(context, _cancel),
                style: const TextStyle(color: _textSecondary),
              ),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: _gold,
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                final value = int.tryParse(controller.text);

                if (value != null && value > 0) {
                  Navigator.of(dialogContext).pop(value);
                }
              },
              child: Text(_text(context, _setTarget)),
            ),
          ],
        );
      },
    );

    controller.dispose();

    if (result != null) {
      await _selectTarget(result);
    }
  }

  Future<void> _showDhikrNameDialog() async {
    final controller = TextEditingController(text: _dhikrName);

    final result = await showDialog<String>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: _surface,
          title: Text(
            _text(context, _dhikrName),
            style: const TextStyle(color: _textPrimary),
          ),
          content: TextField(
            controller: controller,
            autofocus: true,
            textCapitalization: TextCapitalization.words,
            maxLength: 40,
            style: const TextStyle(color: _textPrimary),
            decoration: InputDecoration(
              hintText: _text(context, _dhikrExample),
              hintStyle: const TextStyle(color: _textSecondary),
              counterStyle: const TextStyle(color: _textSecondary),
              filled: true,
              fillColor: _surfaceSoft,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: _goldDark),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: _goldLight, width: 1.5),
              ),
            ),
            onSubmitted: (_) {
              final value = controller.text.trim();

              if (value.isNotEmpty) {
                Navigator.of(dialogContext).pop(value);
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                _text(context, _cancel),
                style: const TextStyle(color: _textSecondary),
              ),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: _gold,
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                final value = controller.text.trim();

                if (value.isNotEmpty) {
                  Navigator.of(dialogContext).pop(value);
                }
              },
              child: Text(_text(context, _save)),
            ),
          ],
        );
      },
    );

    controller.dispose();

    if (result != null) {
      setState(() {
        _dhikrName = result;
      });

      await _saveSession();
    }
  }

  Future<void> _confirmReset() async {
    final shouldReset = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: _surface,
          title: Text(
            _text(context, _resetQuestion),
            style: const TextStyle(color: _textPrimary),
          ),
          content: Text(
            _text(context, _resetInfo),
            style: const TextStyle(color: _textSecondary),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(
                _text(context, _cancel),
                style: const TextStyle(color: _textSecondary),
              ),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: _gold,
                foregroundColor: Colors.black,
              ),
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(_text(context, _reset)),
            ),
          ],
        );
      },
    );

    if (shouldReset != true) {
      return;
    }

    setState(() {
      _count = 0;
      _targetMessageShown = false;
    });

    await _saveSession();
  }

  Future<void> _toggleSound() async {
    setState(() {
      _soundEnabled = !_soundEnabled;
    });

    await _saveSession();
  }

  Future<void> _toggleVibration() async {
    setState(() {
      _vibrationEnabled = !_vibrationEnabled;
    });

    await _saveSession();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: AppBar(
        backgroundColor: _background,
        foregroundColor: _textPrimary,
        elevation: 0,
        centerTitle: true,
        title: Text(
          _text(context, _pageTitle),
          style: const TextStyle(fontWeight: FontWeight.w700, letterSpacing: 0.3),
        ),
        actions: [
          IconButton(
            tooltip: _text(context, _reset),
            onPressed: _confirmReset,
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: _gold))
          : SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                      child: Column(
                        children: [
                          _buildDhikrNameCard(),
                          const SizedBox(height: 18),
                          _buildCounterCard(),
                          const SizedBox(height: 18),
                          _buildTargetSelector(),
                          const SizedBox(height: 18),
                          _buildTapButton(),
                          const SizedBox(height: 18),
                          _buildControlRow(),
                        ],
                      ),
                    ),
                  ),
                  _buildBannerPlaceholder(),
                ],
              ),
            ),
    );
  }

  Widget _buildDhikrNameCard() {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: _showDhikrNameDialog,
      child: Ink(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        decoration: BoxDecoration(
          color: _surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: _goldDark.withValues(alpha: 0.75)),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: _gold.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.auto_awesome_rounded, color: _goldLight),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _text(context, _currentDhikr),
                    style: TextStyle(
                      color: _textSecondary,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _dhikrName,
                    style: const TextStyle(
                      color: _textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.edit_rounded, color: _textSecondary, size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCounterCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 22),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: _goldDark.withValues(alpha: 0.85)),
        boxShadow: [
          BoxShadow(
            color: _gold.withValues(alpha: 0.06),
            blurRadius: 30,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            _text(context, _count),
            style: TextStyle(
              color: _textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 6),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 150),
            transitionBuilder: (child, animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: Text(
              '$_count',
              key: ValueKey<int>(_count),
              style: const TextStyle(
                color: _goldLight,
                fontSize: 76,
                height: 1,
                fontWeight: FontWeight.w800,
                letterSpacing: -2,
              ),
            ),
          ),
          const SizedBox(height: 18),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: LinearProgressIndicator(
              value: _progress,
              minHeight: 8,
              backgroundColor: _surfaceSoft,
              valueColor: const AlwaysStoppedAnimation<Color>(_gold),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_text(context, _target)}: $_target',
                style: const TextStyle(
                  color: _textSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${_text(context, _remaining)}: $_remaining',
                style: const TextStyle(
                  color: _textSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTargetSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2),
          child: Text(
            _text(context, _selectTarget),
            style: TextStyle(
              color: _textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.3,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ..._presetTargets.map(_buildTargetChip),
            _buildCustomTargetChip(),
          ],
        ),
      ],
    );
  }

  Widget _buildTargetChip(int target) {
    final selected = _target == target;

    return ChoiceChip(
      selected: selected,
      showCheckmark: false,
      label: Text('$target'),
      onSelected: (_) => _selectTarget(target),
      backgroundColor: _surface,
      selectedColor: _gold,
      side: BorderSide(
        color: selected ? _gold : _goldDark.withValues(alpha: 0.7),
      ),
      labelStyle: TextStyle(
        color: selected ? Colors.black : _textPrimary,
        fontWeight: FontWeight.w700,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  Widget _buildCustomTargetChip() {
    final isCustom = !_presetTargets.contains(_target);

    return ChoiceChip(
      selected: isCustom,
      showCheckmark: false,
      avatar: Icon(
        Icons.tune_rounded,
        size: 17,
        color: isCustom ? Colors.black : _goldLight,
      ),
      label: Text(isCustom ? '$_target' : _text(context, _custom)),
      onSelected: (_) => _showCustomTargetDialog(),
      backgroundColor: _surface,
      selectedColor: _gold,
      side: BorderSide(
        color: isCustom ? _gold : _goldDark.withValues(alpha: 0.7),
      ),
      labelStyle: TextStyle(
        color: isCustom ? Colors.black : _textPrimary,
        fontWeight: FontWeight.w700,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  Widget _buildTapButton() {
    return Semantics(
      button: true,
      label: _text(context, _pageTitle),
      child: GestureDetector(
        onTap: _incrementCount,
        child: Container(
          width: 210,
          height: 210,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const RadialGradient(
              colors: [_goldLight, _gold, _goldDark],
              stops: [0, 0.66, 1],
            ),
            border: Border.all(
              color: _goldLight.withValues(alpha: 0.85),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: _gold.withValues(alpha: 0.22),
                blurRadius: 34,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withValues(alpha: 0.12),
              border: Border.all(color: Colors.black.withValues(alpha: 0.18)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.touch_app_rounded, color: Colors.black, size: 46),
                SizedBox(height: 8),
                Text(
                  'TAP',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.5,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  _text(context, _toCount),
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildControlRow() {
    return Row(
      children: [
        Expanded(
          child: _buildControlButton(
            icon: _vibrationEnabled
                ? Icons.vibration_rounded
                : Icons.phone_android_rounded,
            label: _text(context, _vibration),
            enabled: _vibrationEnabled,
            onTap: _toggleVibration,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildControlButton(
            icon: _soundEnabled
                ? Icons.volume_up_rounded
                : Icons.volume_off_rounded,
            label: _text(context, _sound),
            enabled: _soundEnabled,
            onTap: _toggleSound,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildControlButton(
            icon: Icons.refresh_rounded,
            label: _text(context, _reset),
            enabled: false,
            onTap: _confirmReset,
          ),
        ),
      ],
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required bool enabled,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
        decoration: BoxDecoration(
          color: _surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: enabled ? _gold : _goldDark.withValues(alpha: 0.55),
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: enabled ? _goldLight : _textSecondary, size: 24),
            const SizedBox(height: 6),
            Text(
              label,
              maxLines: 1,
              style: TextStyle(
                color: enabled ? _textPrimary : _textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerPlaceholder() {
    return Container(
      width: double.infinity,
      height: 64,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: _surface,
        border: Border(top: BorderSide(color: _goldDark, width: 0.6)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'ADVERTISEMENT',
            style: TextStyle(
              color: _textSecondary,
              fontSize: 9,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.5,
            ),
          ),
          SizedBox(height: 4),
          Text(
            _text(context, _bannerSpace),
            style: const TextStyle(color: _textSecondary, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

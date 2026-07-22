import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';
import '../../core/localization/app_localization.dart';
import '../../widgets/banner_ad_widget.dart';

class DigitalTasbihScreen extends StatefulWidget {
  const DigitalTasbihScreen({
    super.key,
    this.initialDhikrName = 'SubhanAllah',
    this.initialTarget = 33,
    this.startFresh = false,
    this.enableCompletionMode = false,
    this.completionId,
  });

  final String initialDhikrName;
  final int initialTarget;
  final bool startFresh;

  /// Yalnızca Esmaül Hüsna ekranından açılan sayaçlarda kullanılır.
  final bool enableCompletionMode;

  /// Dil değişse bile her Esma'nın kaydının ayrı kalmasını sağlayan sabit kimlik.
  final String? completionId;

  @override
  State<DigitalTasbihScreen> createState() => _DigitalTasbihScreenState();
}

class _DigitalTasbihScreenState extends State<DigitalTasbihScreen> {
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
  static const String _completionKeyPrefix =
      'digital_tasbih_esma_completion';

  final List<int> _presetTargets = const [33, 99, 100, 1000];
  final AudioPlayer _audioPlayer = AudioPlayer();

  int _count = 0;
  int _target = 33;
  int _completionCount = 0;
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

  String get _completionStorageKey {
    final rawId = widget.completionId ?? widget.initialDhikrName;
    final safeId = rawId
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
        .replaceAll(RegExp(r'^_+|_+$'), '');

    return '${_completionKeyPrefix}_$safeId';
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

      if (widget.enableCompletionMode) {
        _completionCount =
            preferences.getInt(_completionStorageKey) ?? 0;
        _count = 0;
        _target = widget.initialTarget;
        _dhikrName = widget.initialDhikrName;
        _targetMessageShown = false;
      } else {
        _completionCount = 0;
        _targetMessageShown = _count >= _target;
      }

      _isLoading = false;
    });

    if (widget.startFresh) {
      await _saveSession();
    }
  }

  Future<void> _saveSession() async {
    final preferences = await SharedPreferences.getInstance();

    final operations = <Future<bool>>[
      preferences.setBool(_soundKey, _soundEnabled),
      preferences.setBool(_vibrationKey, _vibrationEnabled),
    ];

    if (widget.enableCompletionMode) {
      operations.add(
        preferences.setInt(
          _completionStorageKey,
          _completionCount,
        ),
      );
    } else {
      operations.addAll([
        preferences.setInt(_countKey, _count),
        preferences.setInt(_targetKey, _target),
        preferences.setString(_dhikrNameKey, _dhikrName),
      ]);
    }

    await Future.wait(operations);
  }

  Future<void> _incrementCount() async {
    final completedNow =
        widget.enableCompletionMode && (_count + 1 >= _target);

    setState(() {
      if (completedNow) {
        _completionCount++;
        _count = 0;
        _targetMessageShown = false;
      } else {
        _count++;
      }
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

    if (completedNow && mounted) {
      if (_vibrationEnabled) {
        unawaited(
          Vibration.vibrate(
            pattern: [0, 120, 60, 220],
            intensities: [0, 210, 0, 255],
          ),
        );
      }

      final isTurkish =
          Localizations.localeOf(context).languageCode == 'tr';

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            backgroundColor: _surfaceSoft,
            behavior: SnackBarBehavior.floating,
            content: Text(
              isTurkish
                  ? 'Allah kabul etsin. $_dhikrName zikrini '
                      '$_completionCount kez tamamladınız.'
                  : 'May Allah accept your dhikr. You completed '
                      '$_dhikrName $_completionCount times.',
              style: const TextStyle(color: _textPrimary),
            ),
          ),
        );

      return;
    }

    if (!widget.enableCompletionMode &&
        _count >= _target &&
        !_targetMessageShown &&
        mounted) {
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
            content: const Text(
              'Target completed. May Allah accept your dhikr.',
              style: TextStyle(color: _textPrimary),
            ),
            action: SnackBarAction(
              label: AppLocalization.text(
                context,
                AppLocalization.continueAction,
              ),
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
          title: const Text(
            'Custom Target',
            style: TextStyle(color: _textPrimary),
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
              hintText: 'Enter a target',
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
              child: const Text(
                'Cancel',
                style: TextStyle(color: _textSecondary),
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
              child: const Text('Set Target'),
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
          title: const Text(
            'Dhikr Name',
            style: TextStyle(color: _textPrimary),
          ),
          content: TextField(
            controller: controller,
            autofocus: true,
            textCapitalization: TextCapitalization.words,
            maxLength: 40,
            style: const TextStyle(color: _textPrimary),
            decoration: InputDecoration(
              hintText: 'Example: SubhanAllah',
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
              child: const Text(
                'Cancel',
                style: TextStyle(color: _textSecondary),
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
              child: const Text('Save'),
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
          title: const Text(
            'Reset Counter?',
            style: TextStyle(color: _textPrimary),
          ),
          content: const Text(
            'Your current count will return to zero.',
            style: TextStyle(color: _textSecondary),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text(
                'Cancel',
                style: TextStyle(color: _textSecondary),
              ),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: _gold,
                foregroundColor: Colors.black,
              ),
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(
                AppLocalization.text(
                  context,
                  AppLocalization.reset,
                ),
              ),
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
          AppLocalization.text(
            context,
            AppLocalization.digitalTasbihTitle,
          ),
          style: const TextStyle(fontWeight: FontWeight.w700, letterSpacing: 0.3),
        ),
        actions: [
          IconButton(
            tooltip: AppLocalization.text(
              context,
              AppLocalization.reset,
            ),
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
                          if (widget.enableCompletionMode) ...[
                            const SizedBox(height: 12),
                            _buildCompletionSummary(),
                          ],
                          if (!widget.enableCompletionMode) ...[
                            const SizedBox(height: 18),
                            _buildTargetSelector(),
                          ],
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
      onTap: widget.enableCompletionMode
          ? null
          : _showDhikrNameDialog,
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
                    AppLocalization.text(
                      context,
                      AppLocalization.currentDhikr,
                    ),
                    style: const TextStyle(
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
            if (!widget.enableCompletionMode)
              const Icon(
                Icons.edit_rounded,
                color: _textSecondary,
                size: 20,
              ),
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
            AppLocalization.text(
              context,
              AppLocalization.tasbihCount,
            ),
            style: const TextStyle(
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
                'Target: $_target',
                style: const TextStyle(
                  color: _textSecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'Remaining: $_remaining',
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

  Future<void> _resetCompletionCount() async {
    final isTurkish =
        Localizations.localeOf(context).languageCode == 'tr';

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: _surface,
          title: Text(
            isTurkish
                ? 'Tamamlama sayısını sıfırla'
                : 'Reset completion count',
            style: const TextStyle(color: _textPrimary),
          ),
          content: Text(
            isTurkish
                ? '$_dhikrName için kaydedilen tamamlama sayısı '
                    'sıfırlansın mı?'
                : 'Reset the saved completion count for $_dhikrName?',
            style: const TextStyle(color: _textSecondary),
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.of(dialogContext).pop(false),
              child: Text(
                isTurkish ? 'Vazgeç' : 'Cancel',
                style: const TextStyle(color: _textSecondary),
              ),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: _gold,
                foregroundColor: Colors.black,
              ),
              onPressed: () =>
                  Navigator.of(dialogContext).pop(true),
              child: Text(isTurkish ? 'Sıfırla' : 'Reset'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) {
      return;
    }

    setState(() {
      _completionCount = 0;
    });

    await _saveSession();
  }

  Widget _buildCompletionSummary() {
    final isTurkish =
        Localizations.localeOf(context).languageCode == 'tr';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 16, 18, 10),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: _goldDark.withValues(alpha: 0.75),
        ),
      ),
      child: Column(
        children: [
          Text(
            isTurkish ? 'TAMAMLAMA SAYISI' : 'COMPLETION COUNT',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: _textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            '$_completionCount',
            style: const TextStyle(
              color: _goldLight,
              fontSize: 32,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            isTurkish
                ? '$_dhikrName zikrini $_completionCount kez tamamladınız'
                : 'You completed $_dhikrName $_completionCount times',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: _textSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextButton.icon(
            onPressed: _completionCount == 0
                ? null
                : _resetCompletionCount,
            icon: const Icon(Icons.restart_alt_rounded, size: 18),
            label: Text(
              isTurkish
                  ? 'Tamamlama sayısını sıfırla'
                  : 'Reset completion count',
            ),
            style: TextButton.styleFrom(
              foregroundColor: _goldLight,
              disabledForegroundColor:
                  _textSecondary.withValues(alpha: 0.45),
            ),
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
            AppLocalization.text(
              context,
              AppLocalization.selectTarget,
            ),
            style: const TextStyle(
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
      label: Text(
        isCustom
            ? '$_target'
            : AppLocalization.text(
                context,
                AppLocalization.customTarget,
              ),
      ),
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
      label: 'Count dhikr',
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
                const Icon(
                  Icons.touch_app_rounded,
                  color: Colors.black,
                  size: 46,
                ),
                const SizedBox(height: 8),
                Text(
                  AppLocalization.text(
                    context,
                    AppLocalization.tap,
                  ),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  AppLocalization.text(
                    context,
                    AppLocalization.toCount,
                  ),
                  style: TextStyle(
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
            label: AppLocalization.text(
              context,
              AppLocalization.vibration,
            ),
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
            label: AppLocalization.text(
              context,
              AppLocalization.sound,
            ),
            enabled: _soundEnabled,
            onTap: _toggleSound,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildControlButton(
            icon: Icons.refresh_rounded,
            label: AppLocalization.text(
              context,
              AppLocalization.reset,
            ),
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
    return const SafeArea(
      top: false,
      child: BannerAdWidget(),
    );
  }
}

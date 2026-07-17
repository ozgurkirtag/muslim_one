import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  AdManager._();

  static final AdManager instance = AdManager._();

  static const String bannerAdUnitId =
      'ca-app-pub-3940256099942544/6300978111';

  static const String interstitialAdUnitId =
      'ca-app-pub-3940256099942544/1033173712';

  InterstitialAd? _interstitialAd;
  bool _isInitialized = false;
  bool _isInitializing = false;
  bool _isLoadingInterstitial = false;
  bool _isShowingInterstitial = false;
  int _regularNamedTransitions = 0;

  final Set<String> _shownSessionAds = <String>{};

  bool get isInitialized => _isInitialized;

  Future<void> initializeSafely() async {
    if (_isInitialized || _isInitializing) {
      return;
    }

    _isInitializing = true;

    try {
      await MobileAds.instance.initialize().timeout(
        const Duration(seconds: 12),
      );
      _isInitialized = true;
      loadInterstitial();
    } on TimeoutException {
      debugPrint(
        'AdMob başlatma zaman aşımına uğradı; uygulama reklamsız devam ediyor.',
      );
    } catch (error, stackTrace) {
      debugPrint('AdMob başlatılamadı: $error');
      debugPrintStack(stackTrace: stackTrace);
    } finally {
      _isInitializing = false;
    }
  }

  void loadInterstitial() {
    if (!_isInitialized ||
        _isLoadingInterstitial ||
        _interstitialAd != null) {
      return;
    }

    _isLoadingInterstitial = true;

    try {
      InterstitialAd.load(
        adUnitId: interstitialAdUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            _isLoadingInterstitial = false;
            _interstitialAd = ad;
          },
          onAdFailedToLoad: (error) {
            _isLoadingInterstitial = false;
            _interstitialAd = null;
            debugPrint('Interstitial yüklenemedi: $error');
          },
        ),
      );
    } catch (error, stackTrace) {
      _isLoadingInterstitial = false;
      debugPrint('Interstitial yükleme çağrısı başarısız: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  Future<void> showSessionAdOnce(String key) async {
    if (!_isInitialized ||
        _shownSessionAds.contains(key) ||
        _isShowingInterstitial) {
      return;
    }

    final shown = await _showLoadedInterstitial();

    if (shown) {
      _shownSessionAds.add(key);
      _regularNamedTransitions = 0;
    }
  }

  Future<void> handleNamedPagePush(String routeName) async {
    if (!_isInitialized || _isShowingInterstitial) {
      return;
    }

    if (routeName == '/digital-tasbih') {
      return;
    }

    if (routeName == '/asma-names') {
      await showSessionAdOnce('asma-names');
      return;
    }

    _regularNamedTransitions++;

    if (_regularNamedTransitions < 6) {
      return;
    }

    final shown = await _showLoadedInterstitial();

    if (shown) {
      _regularNamedTransitions = 0;
    }
  }

  Future<bool> _showLoadedInterstitial() async {
    final ad = _interstitialAd;

    if (!_isInitialized || ad == null || _isShowingInterstitial) {
      loadInterstitial();
      return false;
    }

    _interstitialAd = null;
    _isShowingInterstitial = true;
    final completer = Completer<bool>();

    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (_) {
        if (!completer.isCompleted) {
          completer.complete(true);
        }
      },
      onAdDismissedFullScreenContent: (dismissedAd) {
        dismissedAd.dispose();
        _isShowingInterstitial = false;
        loadInterstitial();
      },
      onAdFailedToShowFullScreenContent: (failedAd, error) {
        debugPrint('Interstitial gösterilemedi: $error');
        failedAd.dispose();
        _isShowingInterstitial = false;
        loadInterstitial();

        if (!completer.isCompleted) {
          completer.complete(false);
        }
      },
    );

    try {
      ad.show();
    } catch (error, stackTrace) {
      ad.dispose();
      _isShowingInterstitial = false;
      debugPrint('Interstitial açılırken hata oluştu: $error');
      debugPrintStack(stackTrace: stackTrace);

      if (!completer.isCompleted) {
        completer.complete(false);
      }
    }

    return completer.future;
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  AdManager._();

  static final AdManager instance = AdManager._();

  static const String bannerAdUnitId = 'ca-app-pub-7094485651472008/9126553690';

  static const String interstitialAdUnitId =
      'ca-app-pub-7094485651472008/8979902395';

  InterstitialAd? _interstitialAd;
  bool _isLoadingInterstitial = false;
  bool _isShowingInterstitial = false;
  int _regularNamedTransitions = 0;

  final Set<String> _shownSessionAds = <String>{};

  Future<void> initialize() async {
    await MobileAds.instance.initialize();
    loadInterstitial();
  }

  void loadInterstitial() {
    if (_isLoadingInterstitial || _interstitialAd != null) {
      return;
    }

    _isLoadingInterstitial = true;

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

          Future<void>.delayed(const Duration(seconds: 20), loadInterstitial);
        },
      ),
    );
  }

  /// Aynı uygulama oturumunda aynı reklam anahtarı yalnızca bir kez gösterilir.
  Future<void> showSessionAdOnce(String key) async {
    if (_shownSessionAds.contains(key) || _isShowingInterstitial) {
      return;
    }

    final shown = await _showLoadedInterstitial();

    if (shown) {
      _shownSessionAds.add(key);
      _regularNamedTransitions = 0;
    }
  }

  /// Normal isimlendirilmiş ekran geçişlerinde her 6 geçişte bir gösterilir.
  Future<void> handleNamedPagePush(String routeName) async {
    if (_isShowingInterstitial) {
      return;
    }

    // Bu ekranların kendilerine özel ilk giriş reklamı vardır.
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

    if (ad == null || _isShowingInterstitial) {
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

    ad.show();
    return completer.future;
  }
}

class AdNavigationObserver extends NavigatorObserver {
  bool _initialRouteSkipped = false;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);

    if (!_initialRouteSkipped && previousRoute == null) {
      _initialRouteSkipped = true;
      return;
    }

    if (route is! PageRoute<dynamic>) {
      return;
    }

    final routeName = route.settings.name;

    // İsimsiz detay sayfalarını normal 6'lı sayaçta kullanmıyoruz.
    // Böylece zikir başlangıç reklamıyla aynı anda ikinci reklam çıkmaz.
    if (routeName == null || routeName.isEmpty) {
      return;
    }

    Future<void>.delayed(const Duration(milliseconds: 300), () {
      AdManager.instance.handleNamedPagePush(routeName);
    });
  }
}

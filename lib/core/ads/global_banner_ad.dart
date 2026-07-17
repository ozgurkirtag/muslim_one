import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ad_manager.dart';

class GlobalBannerAd extends StatefulWidget {
  const GlobalBannerAd({super.key});

  @override
  State<GlobalBannerAd> createState() => _GlobalBannerAdState();
}

class _GlobalBannerAdState extends State<GlobalBannerAd> {
  BannerAd? _bannerAd;
  bool _isLoaded = false;
  bool _isStarting = false;
  Timer? _startupTimer;

  @override
  void initState() {
    super.initState();

    // Önce uygulama arayüzünün tamamen açılmasını bekle.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      _startupTimer = Timer(
        const Duration(seconds: 3),
        _startAdsSafely,
      );
    });
  }

  Future<void> _startAdsSafely() async {
    if (!mounted || _isStarting) return;

    _isStarting = true;

    try {
      await AdManager.instance.initializeSafely();

      if (!mounted || !AdManager.instance.isInitialized) {
        return;
      }

      _loadBanner();
    } catch (error, stackTrace) {
      debugPrint('Banner güvenli başlatma hatası: $error');
      debugPrintStack(stackTrace: stackTrace);
    } finally {
      _isStarting = false;
    }
  }

  void _loadBanner() {
    if (!mounted || _bannerAd != null) return;

    final banner = BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }

          setState(() {
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('Banner yüklenemedi: $error');
          ad.dispose();

          if (!mounted) return;

          setState(() {
            _bannerAd = null;
            _isLoaded = false;
          });
        },
      ),
    );

    _bannerAd = banner;
    banner.load();
  }

  @override
  void dispose() {
    _startupTimer?.cancel();
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final banner = _bannerAd;

    if (!_isLoaded || banner == null) {
      return const SizedBox.shrink();
    }

    return SafeArea(
      top: false,
      child: SizedBox(
        width: banner.size.width.toDouble(),
        height: banner.size.height.toDouble(),
        child: AdWidget(ad: banner),
      ),
    );
  }
}

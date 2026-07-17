import 'dart:async';

import 'package:flutter/foundation.dart';
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
  bool _loadAttempted = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(_initializeAndLoad());
    });
  }

  Future<void> _initializeAndLoad() async {
    try {
      await Future<void>.delayed(const Duration(milliseconds: 800));
      await AdManager.instance.initializeSafely();

      if (!mounted || !AdManager.instance.isInitialized) {
        return;
      }

      _loadBanner();
    } catch (error, stackTrace) {
      debugPrint('Banner hazırlığı başarısız: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }

  void _loadBanner() {
    if (_loadAttempted || !mounted) {
      return;
    }

    _loadAttempted = true;

    try {
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

            setState(() => _isLoaded = true);
          },
          onAdFailedToLoad: (ad, error) {
            debugPrint('Banner yüklenemedi: $error');
            ad.dispose();
          },
        ),
      );

      _bannerAd = banner;
      banner.load();
    } catch (error, stackTrace) {
      debugPrint('Banner oluşturulamadı: $error');
      debugPrintStack(stackTrace: stackTrace);
      _bannerAd?.dispose();
      _bannerAd = null;
    }
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ad = _bannerAd;

    if (!_isLoaded || ad == null) {
      return const SizedBox.shrink();
    }

    return SafeArea(
      top: false,
      child: SizedBox(
        width: double.infinity,
        height: ad.size.height.toDouble(),
        child: Center(
          child: SizedBox(
            width: ad.size.width.toDouble(),
            height: ad.size.height.toDouble(),
            child: AdWidget(ad: ad),
          ),
        ),
      ),
    );
  }
}

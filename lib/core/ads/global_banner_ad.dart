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

  @override
  void initState() {
    super.initState();

    _bannerAd = BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          if (mounted) {
            setState(() => _isLoaded = true);
          }
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint('Banner yüklenemedi: $error');
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ad = _bannerAd;

    return SafeArea(
      top: false,
      child: SizedBox(
        width: double.infinity,
        height: AdSize.banner.height.toDouble(),
        child: !_isLoaded || ad == null
            ? const SizedBox.shrink()
            : Center(
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

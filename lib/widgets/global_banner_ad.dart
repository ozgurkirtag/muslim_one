import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class GlobalBannerAd extends StatefulWidget {
  const GlobalBannerAd({super.key});

  @override
  State<GlobalBannerAd> createState() => _GlobalBannerAdState();
}

class _GlobalBannerAdState extends State<GlobalBannerAd> {
  static const String _androidRealBannerId =
      'ca-app-pub-7094485651472008/9126553690';

  static const String _androidTestBannerId =
      'ca-app-pub-3940256099942544/6300978111';

  BannerAd? _bannerAd;
  bool _isLoaded = false;
  bool _loadStarted = false;

  String get _adUnitId {
    // Debug derlemesinde test reklamı, release derlemesinde gerçek reklam.
    return kDebugMode ? _androidTestBannerId : _androidRealBannerId;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_loadStarted) {
      _loadStarted = true;
      _loadBanner();
    }
  }

  void _loadBanner() {
    final banner = BannerAd(
      adUnitId: _adUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (!mounted) {
            ad.dispose();
            return;
          }

          setState(() {
            _bannerAd = ad as BannerAd;
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();

          if (!mounted) return;

          setState(() {
            _bannerAd = null;
            _isLoaded = false;
          });

          debugPrint('Banner reklam yüklenemedi: $error');
        },
      ),
    );

    banner.load();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final banner = _bannerAd;

    // Reklam yüklenmediyse boş alan bırakma.
    if (!_isLoaded || banner == null) {
      return const SizedBox.shrink();
    }

    return Material(
      color: Colors.black,
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          height: banner.size.height.toDouble(),
          child: Center(
            child: SizedBox(
              width: banner.size.width.toDouble(),
              height: banner.size.height.toDouble(),
              child: AdWidget(ad: banner),
            ),
          ),
        ),
      ),
    );
  }
}

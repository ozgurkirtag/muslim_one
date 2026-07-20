import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({super.key});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  static const String _bannerId =
      'ca-app-pub-7094485651472008/9126553690';

  BannerAd? _bannerAd;
  bool _loaded = false;

  @override
  void initState() {
    super.initState();

    if (!kIsWeb) {
      _bannerAd = BannerAd(
        adUnitId: _bannerId,
        size: AdSize.banner,
        request: const AdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (_) {
            if (mounted) {
              setState(() => _loaded = true);
            }
          },
          onAdFailedToLoad: (ad, error) {
            ad.dispose();
            debugPrint('Banner yüklenemedi: $error');
          },
        ),
      )..load();
    }
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb || !_loaded || _bannerAd == null) {
      return const SizedBox.shrink();
    }

    return Container(
      color: Colors.black,
      alignment: Alignment.center,
      width: double.infinity,
      height: _bannerAd!.size.height.toDouble(),
      child: AdWidget(ad: _bannerAd!),
    );
  }
}

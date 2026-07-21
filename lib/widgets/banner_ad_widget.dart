import 'dart:async';

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
  Timer? _retryTimer;

  bool _loaded = false;
  bool _loading = false;
  String? _errorText;

  @override
  void initState() {
    super.initState();

    if (!kIsWeb) {
      _loadBanner();
    }
  }

  void _loadBanner() {
    if (_loading || kIsWeb) {
      return;
    }

    _retryTimer?.cancel();
    _bannerAd?.dispose();

    _bannerAd = null;
    _loaded = false;
    _loading = true;
    _errorText = null;

    final ad = BannerAd(
      adUnitId: _bannerId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (loadedAd) {
          if (!mounted) {
            loadedAd.dispose();
            return;
          }

          setState(() {
            _loaded = true;
            _loading = false;
            _errorText = null;
          });

          debugPrint('Banner başarıyla yüklendi.');
        },
        onAdFailedToLoad: (failedAd, error) {
          failedAd.dispose();

          final message =
              'Kod: ${error.code} | ${error.domain}\n${error.message}';

          debugPrint('Banner yüklenemedi: $message');
          debugPrint('Response info: ${error.responseInfo}');

          if (!mounted) {
            return;
          }

          setState(() {
            _bannerAd = null;
            _loaded = false;
            _loading = false;
            _errorText = message;
          });

          _retryTimer = Timer(
            const Duration(seconds: 15),
            _loadBanner,
          );
        },
      ),
    );

    _bannerAd = ad;
    ad.load();
  }

  @override
  void dispose() {
    _retryTimer?.cancel();
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const SizedBox.shrink();
    }

    if (_loaded && _bannerAd != null) {
      return Container(
        color: Colors.black,
        alignment: Alignment.center,
        width: double.infinity,
        height: _bannerAd!.size.height.toDouble(),
        child: AdWidget(ad: _bannerAd!),
      );
    }

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 50),
      alignment: Alignment.center,
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(
        _loading
            ? 'Reklam yükleniyor...'
            : (_errorText ?? 'Reklam bekleniyor...'),
        textAlign: TextAlign.center,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 10,
        ),
      ),
    );
  }
}

#!/usr/bin/env bash
set -euo pipefail

cd /workspaces/muslim_one

APP_ID="ca-app-pub-7094485651472008~4134649682"
BANNER_ID="ca-app-pub-7094485651472008/9126553690"
INTERSTITIAL_ID="ca-app-pub-7094485651472008/8979902395"

echo "== Muslim One AdMob kurulumu başlıyor =="

if [[ ! -f pubspec.yaml || ! -f lib/main.dart ]]; then
  echo "HATA: /workspaces/muslim_one içinde Flutter projesi bulunamadı."
  exit 1
fi

if [[ -n "$(git status --porcelain)" ]]; then
  echo "HATA: Git çalışma alanı temiz değil."
  echo "Önce değişikliklerini commit et veya geri al, sonra scripti yeniden çalıştır."
  git status --short
  exit 1
fi

echo "== Güvenlik etiketi oluşturuluyor =="
BACKUP_TAG="before-admob-$(date +%Y%m%d-%H%M%S)"
git tag "$BACKUP_TAG"
echo "Geri dönüş etiketi: $BACKUP_TAG"

echo "== google_mobile_ads ekleniyor =="
flutter pub add google_mobile_ads:^9.0.0

mkdir -p lib/core/ads

cat > lib/core/ads/ad_manager.dart <<'DART'
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdManager {
  AdManager._();

  static final AdManager instance = AdManager._();

  static const String bannerAdUnitId =
      'ca-app-pub-7094485651472008/9126553690';
  static const String interstitialAdUnitId =
      'ca-app-pub-7094485651472008/8979902395';

  InterstitialAd? _interstitialAd;
  bool _isLoadingInterstitial = false;
  bool _isShowingInterstitial = false;
  int _regularPageTransitions = 0;

  final Set<String> _shownFirstEntryAds = <String>{};

  static const Set<String> _firstEntryRoutes = <String>{
    '/digital-tasbih',
    '/asma-names',
    '/tasbih-from-asma',
    '/tasbih-from-recite',
    '/tasbih-from-daily',
  };

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

          Future<void>.delayed(
            const Duration(seconds: 20),
            loadInterstitial,
          );
        },
      ),
    );
  }

  Future<void> handlePagePush(String? routeName) async {
    if (_isShowingInterstitial) {
      return;
    }

    final normalizedRoute = routeName ?? '';

    if (_firstEntryRoutes.contains(normalizedRoute)) {
      if (_shownFirstEntryAds.contains(normalizedRoute)) {
        return;
      }

      final shown = await _showLoadedInterstitial();
      if (shown) {
        _shownFirstEntryAds.add(normalizedRoute);
        _regularPageTransitions = 0;
      }
      return;
    }

    _regularPageTransitions++;

    if (_regularPageTransitions < 6) {
      return;
    }

    final shown = await _showLoadedInterstitial();
    if (shown) {
      _regularPageTransitions = 0;
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

    Future<void>.delayed(const Duration(milliseconds: 350), () {
      AdManager.instance.handlePagePush(route.settings.name);
    });
  }
}
DART

cat > lib/core/ads/global_banner_ad.dart <<'DART'
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
  bool _loaded = false;

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
            setState(() => _loaded = true);
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
        child: !_loaded || ad == null
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
DART

python3 - <<'PY'
from pathlib import Path
import re

main_path = Path("lib/main.dart")
text = main_path.read_text(encoding="utf-8")

imports = [
    "import 'package:google_mobile_ads/google_mobile_ads.dart';",
    "import 'core/ads/ad_manager.dart';",
    "import 'core/ads/global_banner_ad.dart';",
]

if imports[0] not in text:
    text = text.replace(
        "import 'package:flutter_localizations/flutter_localizations.dart';",
        "import 'package:flutter_localizations/flutter_localizations.dart';\n"
        "import 'package:google_mobile_ads/google_mobile_ads.dart';",
    )

if imports[1] not in text:
    text = text.replace(
        "import 'controllers/app_locale_controller.dart';",
        "import 'controllers/app_locale_controller.dart';\n"
        "import 'core/ads/ad_manager.dart';\n"
        "import 'core/ads/global_banner_ad.dart';",
    )

old_main = """  await AppLocaleController.instance.load();
  runApp(const MuslimOneApp());"""
new_main = """  await AppLocaleController.instance.load();
  await AdManager.instance.initialize();
  runApp(const MuslimOneApp());"""

if old_main in text:
    text = text.replace(old_main, new_main)
elif "await AdManager.instance.initialize();" not in text:
    raise SystemExit("main.dart başlangıç bölümü bulunamadı.")

old_material = """        return MaterialApp(
          title: AppStrings.appName,"""
new_material = """        return MaterialApp(
          builder: (context, child) {
            return Column(
              children: [
                Expanded(child: child ?? const SizedBox.shrink()),
                const GlobalBannerAd(),
              ],
            );
          },
          navigatorObservers: [
            AdNavigationObserver(),
          ],
          title: AppStrings.appName,"""

if old_material in text:
    text = text.replace(old_material, new_material)
elif "const GlobalBannerAd()" not in text:
    raise SystemExit("MaterialApp bölümü bulunamadı.")

main_path.write_text(text, encoding="utf-8")

route_files = {
    Path("lib/screens/asma/asma_name_detail_screen.dart"):
        "/tasbih-from-asma",
    Path("lib/screens/recite/recite_detail_screen.dart"):
        "/tasbih-from-recite",
    Path("lib/screens/daily_dhikr/daily_dhikr_screen.dart"):
        "/tasbih-from-daily",
}

pattern = re.compile(
    r"MaterialPageRoute\(\s*\n(?P<indent>\s*)builder:\s*\(_\)\s*=>\s*DigitalTasbihScreen\(",
    re.MULTILINE,
)

for path, route_name in route_files.items():
    if not path.exists():
        raise SystemExit(f"Dosya bulunamadı: {path}")

    source = path.read_text(encoding="utf-8")

    if route_name in source:
        continue

    def replacement(match):
        indent = match.group("indent")
        return (
            "MaterialPageRoute(\n"
            f"{indent}settings: const RouteSettings(name: '{route_name}'),\n"
            f"{indent}builder: (_) => DigitalTasbihScreen("
        )

    updated, count = pattern.subn(replacement, source, count=1)

    if count != 1:
        raise SystemExit(
            f"{path} içinde DigitalTasbih MaterialPageRoute bulunamadı."
        )

    path.write_text(updated, encoding="utf-8")
PY

echo "== AndroidManifest App ID ekleniyor =="

python3 - <<PY
from pathlib import Path
import re

path = Path("android/app/src/main/AndroidManifest.xml")
text = path.read_text(encoding="utf-8")

app_id = "$APP_ID"
metadata_pattern = re.compile(
    r'<meta-data\s+android:name="com\.google\.android\.gms\.ads\.APPLICATION_ID"\s+android:value="[^"]*"\s*/>',
    re.MULTILINE,
)

metadata = (
    '<meta-data\n'
    '            android:name="com.google.android.gms.ads.APPLICATION_ID"\n'
    f'            android:value="{app_id}" />'
)

if metadata_pattern.search(text):
    text = metadata_pattern.sub(metadata, text)
else:
    application_pattern = re.compile(r'(<application\b[^>]*>)', re.DOTALL)
    match = application_pattern.search(text)

    if not match:
        raise SystemExit("AndroidManifest.xml içinde <application> bulunamadı.")

    text = (
        text[:match.end()]
        + "\n        "
        + metadata
        + text[match.end():]
    )

path.write_text(text, encoding="utf-8")
PY

echo "== Kod biçimlendiriliyor =="
dart format \
  lib/main.dart \
  lib/core/ads/ad_manager.dart \
  lib/core/ads/global_banner_ad.dart \
  lib/screens/asma/asma_name_detail_screen.dart \
  lib/screens/recite/recite_detail_screen.dart \
  lib/screens/daily_dhikr/daily_dhikr_screen.dart

echo "== Flutter analiz =="
flutter analyze

echo "== Değişiklik özeti =="
git status --short
git diff --stat

echo "== Commit ve push =="
git add \
  pubspec.yaml \
  pubspec.lock \
  android/app/src/main/AndroidManifest.xml \
  lib/main.dart \
  lib/core/ads/ad_manager.dart \
  lib/core/ads/global_banner_ad.dart \
  lib/screens/asma/asma_name_detail_screen.dart \
  lib/screens/recite/recite_detail_screen.dart \
  lib/screens/daily_dhikr/daily_dhikr_screen.dart

git commit -m "Add AdMob banner and interstitial ads"
git push

echo
echo "=============================================="
echo "AdMob kurulumu tamamlandı."
echo "App ID:          $APP_ID"
echo "Banner ID:       $BANNER_ID"
echo "Interstitial ID: $INTERSTITIAL_ID"
echo "Geri dönüş etiketi: $BACKUP_TAG"
echo "=============================================="
echo
echo "APK almak için:"
echo "flutter build apk --release"

// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';

// class AdManager {
//   // Private constructor
//   AdManager._internal();

//   // Singleton instance
//   static final AdManager _instance = AdManager._internal();

//   // Factory constructor
//   factory AdManager() {
//     return _instance;
//   }

//   InterstitialAd? _interstitialAd;
//   BannerAd? _bannerAd;

//   final String interstitialAdUnitId = 'ca-app-pub-3940256099942544/1033173712';
//   final String bannerAdUnitId = 'ca-app-pub-3940256099942544/6300978111';

//   // List of test device IDs
//   // final List<String> testDeviceIds = ['YOUR_DEVICE_ID'];

//   // Initializes the Google Mobile Ads SDK
//   Future<void> initialize() async {
//     await MobileAds.instance.initialize();
//     // MobileAds.instance.updateRequestConfiguration(
//     //   // RequestConfiguration(testDeviceIds: testDeviceIds),
//     // );
//   }

//   // *********** INTERSTITIAL AD METHODS *********** //

//   void loadInterstitialAd() {
//     InterstitialAd.load(
//       adUnitId: interstitialAdUnitId,
//       request: AdRequest(),
//       adLoadCallback: InterstitialAdLoadCallback(
//         onAdLoaded: (InterstitialAd ad) {
//           _interstitialAd = ad;
//           print('Interstitial Ad loaded.');
//         },
//         onAdFailedToLoad: (LoadAdError error) {
//           print('Failed to load Interstitial Ad: $error');
//           _interstitialAd = null;
//         },
//       ),
//     );
//   }

//   void showInterstitialAd() {
//     if (_interstitialAd != null) {
//       _interstitialAd!.show();
//       _interstitialAd = null; // Clear after showing
//     } else {
//       print('Interstitial Ad is not loaded yet.');
//     }
//   }

//   // *********** BANNER AD METHODS *********** //

//   void loadBannerAd() {
//     _bannerAd = BannerAd(
//       adUnitId: bannerAdUnitId,
//       size: AdSize.banner,
//       request: AdRequest(),
//       listener: BannerAdListener(
//         onAdLoaded: (Ad ad) {
//           print('Banner Ad loaded.');
//         },
//         onAdFailedToLoad: (Ad ad, LoadAdError error) {
//           print('Failed to load Banner Ad: $error');
//           ad.dispose();
//         },
//       ),
//     )..load();
//   }

//   Widget getBannerAdWidget() {
//     if (_bannerAd != null) {
//       return Container(
//         alignment: Alignment.center,
//         child: AdWidget(ad: _bannerAd!),
//         width: _bannerAd!.size.width.toDouble(),
//         height: _bannerAd!.size.height.toDouble(),
//       );
//     } else {
//       return SizedBox.shrink(); // Empty widget if ad is not loaded
//     }
//   }

//   // *********** CLEAN UP METHODS *********** //

//   void dispose() {
//     _interstitialAd?.dispose();
//     _bannerAd?.dispose();
//   }
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  static String? get bannerAdUnitId {
    if (Platform.isAndroid) {
      // return 'ca-app-pub-4634689499659793/4231834959';
      return '	ca-app-pub-3940256099942544/6300978111'; // TestID
    } else if (Platform.isIOS) {
      return '';
    } else {
      return null;
    }
  }

  static String? get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return '';
      // return ''; // TestID
    } else if (Platform.isIOS) {
      return '';
    } else {
      return null;
    }
  }

  static String? get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return '';
      // return ''; // TestID
    } else if (Platform.isIOS) {
      return '';
    } else {
      return null;
    }
  }

  static final BannerAdListener bannerAdListener = BannerAdListener(
    onAdLoaded: (ad) => debugPrint("AD Loaded."),
    onAdFailedToLoad: (ad, error) {
      ad.dispose();
      debugPrint("Ad failed to load : $error");
    },
    onAdOpened: (ad) => debugPrint('Ad opened'),
    onAdClosed: (ad) => debugPrint('Ad Closed'),
  );
}

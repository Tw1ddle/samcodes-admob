# CHANGELOG

## 1.0.9 -> 1.1.0
 * Upgraded to latest AdMob SDK.
 * Numerous updates to support OpenFL 8.
 * Updated bindings to facilitate GDPR compliance.
 * Made init method iOS-only and renamed to initAdMob.

## 1.0.8 -> 1.0.9
* Fixed a bug with non-unique CFFI primitive names, which could cause clashes (duplicate symbol errors) when using other haxelibs

## 1.0.7 -> 1.0.8
* Update to iOS Google Mobile Ads SDK 7.7.0.
* Renamed hasCachedInterstitial method to hasInterstitial.

## 1.0.6 -> 1.0.7
* Fix runtime crash by including extension-android-support-v4.
* Fix typo in AndroidManifest.xml, missed closing tag on the AdActivity activity.

## 1.0.5 -> 1.0.6
* Updated to iOS AdMob SDK 7.5.2
* Fix set_banner_position CFFI definition

## 1.0.4 -> 1.0.5
* Update to non-deprecated Google Play services dependency library

## 1.0.3 -> 1.0.4
* Fix to make library compatible with Lime

## 1.0.2 -> 1.0.3
* Fix build error introduced in previous update

## 1.0.1 -> 1.0.2
* Add constructor to AdMobListener base class

## 1.0.0 -> 1.0.1
* Refactor setBannerPosition(int) to setBannerPosition(horizontal_gravity, vertical_gravity)
* Update to iOS AdMob SDK 7.5.1

## 1.0.0
* Initial release
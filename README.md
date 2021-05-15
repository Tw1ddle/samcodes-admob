# Haxe AdMob

[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](https://github.com/Tw1ddle/samcodes-admob/blob/master/LICENSE)

Unofficial AdMob banner and interstitial ad support for iOS and Android Haxe OpenFL targets.

This is deprecated, I am no longer updating it because I do not use AdMob in any projects. Feel free to fork and fix this though!

### Features

Supports:
* Caching, showing and dismissing interstitial ads.
* Showing, hiding and refreshing banner ads.
* Customizable listener for reacting to SDK events.
* Customizable banner positioning.
* Multiple ad units.

Doesn't support:
* Displaying more than one banner ad at a time.
* IAP functionality.
* Rewarded videos.
* DoubleClick ads or mediation.

### Install

```bash
haxelib install samcodes-admob
```

### Usage

Include the haxelib through Project.xml:
```xml
<haxelib name="samcodes-admob" />
```

For Android enter a device id if you want to use test ads on one:
```xml
<!-- Set this if you want to use test ads on a particular device. -->
<setenv name="AdmobTestDeviceId" value="YOUR_HASHED_TEST_DEVICE_ID" />
```

For iOS you can specify a test device id in the AdMob.initAdMob() call in Haxe code:
```haxe
AdMob.initAdMob("YOUR_HASHED_TEST_DEVICE_ID");
```

```haxe
import extension.admob.AdMob;
import extension.admob.AdMobListener;
import extension.admob.AdMobGravity;

#if ios
AdMob.initAdMob("YOUR_HASHED_TEST_DEVICE_ID"); // Specify a test device id for iOS here.
#end

// Optionally subclass AdMobListener and set it here to handle SDK events.
// Extending and customizing this is useful for actions like pausing the game when showing interstitials, showing banners as soon as they cache etc.
AdMob.setListener(new AdMobListener());

var interstitialId:String = "my_interstitial_id";

AdMob.cacheInterstitial(interstitialId); // Cache interstitial with the id from your AdMob dashboard.

// Later...
if(AdMob.hasInterstitial(interstitialId) {
	// Shows an interstitial with the given id.
	// If this is called and the interstitial isn't cached, then it won't display at all - that's just how the AdMob SDK works.
	// You should cache interstitial ads well in advance of showing them.
	AdMob.showInterstitial(interstitialId);
}

AdMob.setBannerPosition(AdMobHorizontalGravity.CENTER, AdMobVerticalGravity.BOTTOM); // All banners will appear bottom center of the screen

var bannerId:String = "my_banner_id";

AdMob.refreshBanner(bannerId);

// Later...
AdMob.showBanner(bannerId); // Shows the banner (it will only show if the SDK has finished caching a banner after calling refreshBanner)
AdMob.hideBanner(bannerId); // Hides the banner
```

### Notes

Use ```#if (android || ios)``` conditionals around your imports and calls to this library for cross platform projects, as there is no stub/fallback implementation included in the haxelib.

If you need to rebuild the iOS or simulator ndlls navigate to ```/project``` and run ```rebuild_ndlls.sh```.

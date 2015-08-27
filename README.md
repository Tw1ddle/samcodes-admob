# samcodes-admob

Unofficial AdMob banner and interstitial ads support for iOS and Android Haxe OpenFL/Lime targets.

### Features ###

Supports:
* Caching and showing interstitial ads.
* Refreshing, showing and hiding banner ads.
* Multiple ad units.
* Customizable listener for reacting to SDK events.
* Customizable banner positioning.

Doesn't support:
* Displaying more than one banner at a time.
* IAP functionality.
* DoubleClick ads or mediation.

If there is something you would like adding let me know. Pull requests welcomed too!

### Install ###

```bash
haxelib install samcodes-admob
```

### Usage ###

Include the haxelib through Project.xml:
```xml
<haxelib name="samcodes-admob" />
```

For Android enter a device id if you want to use test ads on one:
```xml
<!-- Set this if you want to use test ads on a particular device. -->
<setenv name="AdmobTestDeviceId" value="YOUR_HASHED_TEST_DEVICE_ID" />
```

For iOS you may specify a test device id in the AdMob.init() call in Haxe code:
```haxe
AdMob.init("YOUR_HASHED_TEST_DEVICE_ID");
```

```haxe
// Basic usage

import extension.admob.AdMob;
import extension.admob.AdMobListener;
import extension.admob.AdMobGravity;

AdMob.init(); // Must be called first. You may specify a test device id for iOS here.

// Optionally subclass AdMobListener and set it here to handle SDK events .
// Extending and customizing this can be used to perform actions like pausing the game/showing banners as soon as they load etc.
AdMob.setListener(new AdMobListener());

var interstitialId:String = "my_interstitial_id";

AdMob.cacheInterstitial(interstitialId); // Cache interstitial with the given id from your AdMob dashboard.

// A bit later...
if(AdMob.hasCachedInterstitial(interstitialId) {
	// Shows an interstitial with the given id.
	// If this is called and the ad isn't cached, then it won't display at all (that's just how the AdMob SDK works).
	// Generally you should cache interstitial ads well in advance of showing them.
	AdMob.showInterstitial(interstitialId);
}

AdMob.setBannerPosition(AdMobHorizontalGravity.CENTER, AdMobVerticalGravity.BOTTOM); // All banners will appear bottom center of the screen 

var bannerId:String = "my_banner_id";

AdMob.refreshBanner(bannerId);

// A bit later...
AdMob.showBanner(bannerId); // Shows the banner (it will only show if you have already cached a banner using refreshBanner)
AdMob.hideBanner(bannerId); // Hides the banner
```

### Example ###

For a full example that uses a listener see the demo app: https://github.com/Tw1ddle/samcodes-ads-demo

![Screenshot of demo app](https://github.com/Tw1ddle/samcodes-ads-demo/blob/master/screenshots/admob-banner.png?raw=true "Demo app")

![Screenshot of demo app](https://github.com/Tw1ddle/samcodes-ads-demo/blob/master/screenshots/admob-interstitial.png?raw=true "Demo app")
	
### Notes ###

Note that you should add platform conditionals like ```#if (android || ios)``` around your imports and calls to this library when creating a cross platform project, as there is no included stub/fallback implementation for other platforms.

For running on iOS, you may need to drag your ```libAdMobAds.a``` into the "link binaries with libraries" section under the "build phases" tab in Xcode.

If you need to rebuild the iOS libs navigate to the ```/project``` folder and run:

```bash
haxelib run hxcpp Build.xml -Diphoneos
haxelib run hxcpp Build.xml -Diphoneos -DHXCPP_ARMV7
haxelib run hxcpp Build.xml -Diphoneos -DHXCPP_ARM64
```
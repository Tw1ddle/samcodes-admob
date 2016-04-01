# samcodes-admob

Unofficial [AdMob](https://developers.google.com/admob/) banner and interstitial ad support for iOS and Android Haxe OpenFL/Lime targets.

### Features ###

Supports:
* Caching, showing and dismissing interstitial ads.
* Showing, hiding and refreshing banner ads.
* Customizable listener for reacting to SDK events.
* Customizable banner positioning.
* Multiple ad units.

Doesn't support:
* Displaying more than one banner ad at a time.
* IAP functionality.
* DoubleClick ads or mediation.

If there is something you would like adding let me know. Pull requests welcomed too!

### Install ###

```bash
haxelib install samcodes-admob
```

### Example ###

See the demo app for a working example using a custom listener: https://github.com/Tw1ddle/samcodes-ads-demo

![Screenshot of demo app](https://github.com/Tw1ddle/samcodes-ads-demo/blob/master/screenshots/admob-banner.png?raw=true "Demo app")

![Screenshot of demo app](https://github.com/Tw1ddle/samcodes-ads-demo/blob/master/screenshots/admob-interstitial.png?raw=true "Demo app")

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

For iOS you can specify a test device id in the AdMob.init() call in Haxe code:
```haxe
AdMob.init("YOUR_HASHED_TEST_DEVICE_ID");
```

```haxe
import extension.admob.AdMob;
import extension.admob.AdMobListener;
import extension.admob.AdMobGravity;

AdMob.init(); // Must be called first. You may specify a test device id for iOS here.

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
	
### Notes ###

Use ```#if (android || ios)``` conditionals around your imports and calls to this library for cross platform projects, as there is no stub/fallback implementation included in the haxelib.

For iOS you need to drag your ```libAdMobAds.a``` into the "link binaries with libraries" section under the "build phases" tab in Xcode. If you need to rebuild the iOS or simulator ndlls navigate to ```/project``` and run:

```bash
haxelib run hxcpp Build.xml -Diphoneos
haxelib run hxcpp Build.xml -Diphoneos -DHXCPP_ARMV7
haxelib run hxcpp Build.xml -Diphoneos -DHXCPP_ARM64
haxelib run hxcpp Build.xml -Diphonesim -DHXCPP_M64
haxelib run hxcpp Build.xml -Diphonesim
```
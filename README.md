# samcodes-admob

Unofficial AdMob banner and interstitial ads support for iOS and Android Haxe/OpenFL targets.

### Features ###

Supports:
* Caching and showing interstitial ads.
* Showing and hiding banner ads.
* Multiple ad units.
* Customizable listener for reacting to SDK events.
* Banners either at top or bottom of screen.

Doesn't support:
* Displaying more than one banner at a time.
* Complex customization for banner size or position.
* IAP functionality.
* DoubleClick ads or mediation.

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
AdMob.init(); // Must be called first. You may specify a test device id on iOS here.
AdMob.setBannerPosition(1); // All banners will appear at top of screen. 0 = bottom/1 = top.
AdMob.setListener(new AdSimpleAdMobListener(listener)); // Attach an extended AdMobListener to handle/respond to SDK events (this is good for showing banners as soon as they load etc...)

AdMob.cacheInterstitial("my_ad_unit_id"); // Cache interstitial with the given id from your AdMob dashboard.

// A bit later...

if(AdMob.hasCachedInterstitial("my_ad_unit_id") {
	// Shows an interstitial with the given id.
	// If this is called and the ad isn't cached, then it may display later or not at all depending on the ads SDK.
	// Generally you want to cache interstitial ads well in advance of showing them.
	AdMob.showInterstitial("my_ad_unit_id");
}

AdMob.refreshBanner("my_ad_unit_id");

// A bit later...

AdMob.showBanner("my_ad_unit_id"); // Shows an invisible banner
AdMob.hideBanner("my_ad_unit_id"); // Hides a visible banner
```

### Example ###

For a full example see the demo app: https://github.com/Tw1ddle/samcodes-ads-demo

![Screenshot of demo app](https://github.com/Tw1ddle/samcodes-ads-demo/blob/master/screenshots/admob-banner.png?raw=true "Demo app")

![Screenshot of demo app](https://github.com/Tw1ddle/samcodes-ads-demo/blob/master/screenshots/admob-interstitial.png?raw=true "Demo app")
	
### Notes ###

For running on iOS, you need to drag your ```libAdMobAds.a``` into the "link binaries with libraries" section under the "build phases" tab in Xcode.

If you need to rebuild the iOS libs for any reason navigate to ```/project``` and run:

```bash
haxelib run hxcpp Build.xml -Diphoneos
haxelib run hxcpp Build.xml -Diphoneos -DHXCPP_ARMV7
haxelib run hxcpp Build.xml -Diphoneos -DHXCPP_ARM64
```

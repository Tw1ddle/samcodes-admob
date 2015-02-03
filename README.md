# samcodes-admob

Unofficial AdMob banner and interstitial ads support for iOS and Android Haxe/OpenFL targets.

### Features ###

Supports:
* Caching and showing interstitial ads.
* Showing and hiding banner ads.
* Multiple ads and ad units.
* Customizable listener for reacting to SDK events.

Doesn't support:
* Customizable banner ad locations or sizes.
* Displaying more than one banner at a time.
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

For iOS you must specify a test device id in the AdMob.init() call in Haxe code:
```haxe
TODO
```

```haxe
// Basic usage
AdMob.init();
AdMob.setListener(new AdSimpleAdMobListener(listener)); // Attach an extended AdMobListener to handle/respond to SDK events.

AdMob.cacheInterstitial("my_ad_unit_id"); // Cache interstitial with the given id from your AdMob dashboard.

// A bit later...

if(AdMob.hasCachedInterstitial("my_ad_unit_id") {
	AdMob.showInterstitial("my_ad_unit_id"); // Shows an interstitial with the given id. If this is called and the ad isn't cached, then it will issue a cache request and show if as soon as it caches.
}

AdMob.showBanner(); // Shows a banner
AdMob.hideBanner(); // Hides a visible banner
```

### Example ###

For a full example see the demo app: https://github.com/Tw1ddle/samcodes-chartboost-demo

TODO
![Screenshot of demo app](https://github.com/Tw1ddle/samcodes-chartboost-demo/blob/master/screenshots/main.png?raw=true "Demo app")

### Notes ###

For running on iOS, you need to drag your ```libAdMobAds.a``` into the "link binaries with libraries" section under the "build phases" tab in Xcode.

If you need to rebuild the iOS libs for any reason navigate to ```/project``` and run:

```bash
haxelib run hxcpp Build.xml -Diphoneos
haxelib run hxcpp Build.xml -Diphoneos -DHXCPP_ARMV7
haxelib run hxcpp Build.xml -Diphoneos -DHXCPP_ARM64
```

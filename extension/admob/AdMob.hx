package extension.admob;

#if (android || ios)

#if android
import lime.system.JNI;
#end

import extension.admob.AdMobGravity.AdMobHorizontalGravity;
import extension.admob.AdMobGravity.AdMobVerticalGravity;

/**
   The AdMob class provides bindings to the main functionality of the AdMob ads SDK on iOS and Android
   See: https://github.com/Tw1ddle/samcodes-admob
**/
class AdMob {
	#if ios
	public static function initAdMob(?testDeviceIdHash:String):Void {
		init_admob(testDeviceIdHash);
	}
	#end
	
	public static function setListener(listener:AdMobListener):Void {
		#if android
		set_listener(listener);
		#end
		#if ios
		set_listener(listener.notify);
		#end
	}
	
	public static function showInterstitial(id:String):Void {
		show_interstitial(id);
	}

	public static function cacheInterstitial(id:String):Void {
		cache_interstitial(id);
	}

	public static function hasInterstitial(id:String):Bool {
		return has_interstitial(id);
	}
	
	public static function setBannerPosition(horizontal:AdMobHorizontalGravity, vertical:AdMobVerticalGravity):Void {
		set_banner_position(horizontal, vertical);
	}
	
	public static function refreshBanner(id:String):Void {
		refresh_banner(id);
	}
	
	public static function showBanner(id:String):Void {
		show_banner(id);
	}

	public static function hideBanner(id:String):Void {
		hide_banner(id);
	}
	
	#if android
	private static inline var packageName:String = "com/samcodes/admob/AdMobExtension";
	private static inline function bindJNI(jniMethod:String, jniSignature:String) {
		return JNI.createStaticMethod(packageName, jniMethod, jniSignature);
	}
	
	private static var set_listener:Dynamic = bindJNI("setListener", "(Lorg/haxe/lime/HaxeObject;)V");
	private static var show_interstitial:Dynamic = bindJNI("showInterstitial", "(Ljava/lang/String;)V");
	private static var cache_interstitial:Dynamic = bindJNI("cacheInterstitial", "(Ljava/lang/String;)V");
	private static var has_interstitial:Dynamic = bindJNI("hasInterstitial", "(Ljava/lang/String;)Z");
	private static var set_banner_position:Dynamic = bindJNI("setBannerPosition", "(II)V");
	private static var refresh_banner:Dynamic = bindJNI("refreshBanner", "(Ljava/lang/String;)V");
	private static var show_banner:Dynamic = bindJNI("showBanner", "(Ljava/lang/String;)V");
	private static var hide_banner:Dynamic = bindJNI("hideBanner", "(Ljava/lang/String;)V");
	#end
	
	#if ios
	private static var init_admob:Dynamic = PrimeLoader.load("samcodesadmob_init_admob", "sv");
	
	private static var set_listener:Dynamic = PrimeLoader.load("samcodesadmob_set_listener", "ov");
	private static var show_interstitial:Dynamic = PrimeLoader.load("samcodesadmob_show_interstitial", "sv");
	private static var cache_interstitial:Dynamic = PrimeLoader.load("samcodesadmob_cache_interstitial", "sv");
	private static var has_interstitial:Dynamic = PrimeLoader.load("samcodesadmob_has_interstitial", "sb");
	private static var set_banner_position:Dynamic = PrimeLoader.load("samcodesadmob_set_banner_position", "iiv");
	private static var refresh_banner:Dynamic = PrimeLoader.load("samcodesadmob_refresh_banner", "sv");
	private static var show_banner:Dynamic = PrimeLoader.load("samcodesadmob_show_banner", "sv");
	private static var hide_banner:Dynamic = PrimeLoader.load("samcodesadmob_hide_banner", "sv");
	#end

}
#end
package extension.admob;

#if android

#if lime
import lime.system.JNI;
#elseif openfl
import openfl.utils.JNI;
#else
#error "samcodes-admob could not find JNI include for non-openfl and non-lime project."
#end

#end

#if ios
import flash.Lib;
#end

#if (android || ios)

import extension.admob.AdMobGravity.AdMobHorizontalGravity;
import extension.admob.AdMobGravity.AdMobVerticalGravity;

@:allow(extension.AdMob)
class AdMob {
	// Must be called before use of any other methods in this class
	public static function init(?testDeviceIdHash:String):Void {
		AdMob.initBindings();
		
		#if ios
		init_admob(testDeviceIdHash);
		#end
	}
	
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

	public static function hasCachedInterstitial(id:String):Bool {
		return has_cached_interstitial(id);
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
	
	private static function initBindings():Void {
		#if android
		var packageName:String = "com/samcodes/admob/AdMobExtension";
		#end
		#if ios
		var ndllName:String = "samcodesadmob";
		#end
		
		#if ios
		if (init_admob == null) {
			init_admob = Lib.load(ndllName, "init_admob", 1);
		}
		#end
		
		if (set_listener == null) {
			#if android
			set_listener = JNI.createStaticMethod(packageName, "setListener", "(Lorg/haxe/lime/HaxeObject;)V");
			#end
			#if ios
			set_listener = Lib.load(ndllName, "set_listener", 1);
			#end
		}
		if (show_interstitial == null) {
			#if android
			show_interstitial = JNI.createStaticMethod(packageName, "showInterstitial", "(Ljava/lang/String;)V");
			#end
			#if ios
			show_interstitial = Lib.load(ndllName, "show_interstitial", 1);
			#end
		}
		if (cache_interstitial == null) {
			#if android
			cache_interstitial = JNI.createStaticMethod(packageName, "cacheInterstitial", "(Ljava/lang/String;)V");
			#end
			#if ios
			cache_interstitial = Lib.load(ndllName, "cache_interstitial", 1);
			#end
		}
		if (has_cached_interstitial == null) {
			#if android
			has_cached_interstitial = JNI.createStaticMethod(packageName, "hasCachedInterstitial", "(Ljava/lang/String;)Z");
			#end
			#if ios
			has_cached_interstitial = Lib.load(ndllName, "has_cached_interstitial", 1);
			#end
		}
		if (set_banner_position == null) {
			#if android
			set_banner_position = JNI.createStaticMethod(packageName, "setBannerPosition", "(II)V");
			#end
			#if ios
			set_banner_position = Lib.load(ndllName, "set_banner_position", 2);
			#end
		}
		if (refresh_banner == null) {
			#if android
			refresh_banner = JNI.createStaticMethod(packageName, "refreshBanner", "(Ljava/lang/String;)V");
			#end
			#if ios
			refresh_banner = Lib.load(ndllName, "refresh_banner", 1);
			#end
		}
		if (show_banner == null) {
			#if android
			show_banner = JNI.createStaticMethod(packageName, "showBanner", "(Ljava/lang/String;)V");
			#end
			#if ios
			show_banner = Lib.load(ndllName, "show_banner", 1);
			#end
		}
		if (hide_banner == null) {
			#if android
			hide_banner = JNI.createStaticMethod(packageName, "hideBanner", "(Ljava/lang/String;)V");
			#end
			#if ios
			hide_banner = Lib.load(ndllName, "hide_banner", 1);
			#end
		}
	}
	
	#if ios
	private static var init_admob:Dynamic = null;
	#end
	private static var set_listener:Dynamic = null;
	private static var show_interstitial:Dynamic = null;
	private static var cache_interstitial:Dynamic = null;
	private static var has_cached_interstitial:Dynamic = null;
	private static var set_banner_position:Dynamic = null;
	private static var refresh_banner:Dynamic = null;
	private static var show_banner:Dynamic = null;
	private static var hide_banner:Dynamic = null;
}
#end
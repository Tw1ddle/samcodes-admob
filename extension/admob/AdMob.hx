package extension.admob;

#if android

#if openfl
import openfl.utils.JNI;
#elseif lime
import lime.system.JNI;
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
	
	private static function initBindings():Void {
		#if ios
		if (init_admob == null) {
			init_admob = Lib.load(ndllName, "init_admob", 1);
		}
		#end
		
		set_listener = initBinding("setListener", "(Lorg/haxe/lime/HaxeObject;)V", "set_listener", 1);
		show_interstitial = initBinding("showInterstitial", "(Ljava/lang/String;)V", "show_interstitial", 1);
		cache_interstitial = initBinding("cacheInterstitial", "(Ljava/lang/String;)V", "cache_interstitial", 1);
		has_interstitial = initBinding("hasInterstitial", "(Ljava/lang/String;)Z", "has_interstitial", 1);
		set_banner_position = initBinding("setBannerPosition", "(II)V", "set_banner_position", 2);
		refresh_banner = initBinding("refreshBanner", "(Ljava/lang/String;)V", "refresh_banner", 1);
		show_banner = initBinding("showBanner", "(Ljava/lang/String;)V", "show_banner", 1);
		hide_banner = initBinding("hideBanner", "(Ljava/lang/String;)V", "hide_banner", 1);
	}
	
	private static inline function initBinding(jniMethod:String, jniSignature:String, ndllMethod:String, argCount:Int):Dynamic {
		#if android
		var binding = JNI.createStaticMethod(packageName, jniMethod, jniSignature);
		#end
		
		#if ios
		var binding = Lib.load(ndllName, ndllName + "_" + ndllMethod, argCount);
		#end
		
		#if debug
		if (binding == null) {
			throw "Failed to bind method: " + jniMethod + ", " + jniSignature + ", " + ndllMethod + " (" + Std.string(argCount) + ").";
		}
		#end
		
		return binding;
	}
	
	#if android
	private static inline var packageName:String = "com/samcodes/admob/AdMobExtension";
	#end
	#if ios
	private static inline var ndllName:String = "samcodesadmob";
	#end
	
	#if ios
	private static var init_admob:Dynamic = null;
	#end
	private static var set_listener:Dynamic = null;
	private static var show_interstitial:Dynamic = null;
	private static var cache_interstitial:Dynamic = null;
	private static var has_interstitial:Dynamic = null;
	private static var set_banner_position:Dynamic = null;
	private static var refresh_banner:Dynamic = null;
	private static var show_banner:Dynamic = null;
	private static var hide_banner:Dynamic = null;
}
#end
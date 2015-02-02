package extension.admob;

#if android
import openfl.utils.JNI;
#end

#if ios
import flash.Lib;
#end

#if (android || ios)
@:allow(extension.Chartboost) class AdMob
{
	// Must be called before use of any other methods in this class
	public static function init():Void {
		AdMob.initBindings();
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
	
	public static function showBanner(id:String):Void {
		show_banner(id);
	}

	public static function hideBanner(id:String):Void {
		hide_banner(id);
	}
	
	private static function initBindings():Void {
		#if android
		var packageName:String = "com/samcodes/chartboost/AdMobExtension";
		#end
		#if ios
		var ndllName:String = "samcodesadmob";
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
		if (show_banner == null) {
			#if android
			show_banner = JNI.createStaticMethod(packageName, "showBanner", "(Ljava/lang/String;)Z");
			#end
			#if ios
			show_banner = Lib.load(ndllName, "show_banner", 1);
			#end
		}
		if (hide_banner == null) {
			#if android
			hide_banner = JNI.createStaticMethod(packageName, "hideBanner", "(Ljava/lang/String;)Z");
			#end
			#if ios
			hide_banner = Lib.load(ndllName, "hide_banner", 1);
			#end
		}
	}
	
	private static var set_listener:Dynamic = null;
	private static var show_interstitial:Dynamic = null;
	private static var cache_interstitial:Dynamic = null;
	private static var has_cached_interstitial:Dynamic = null;
	private static var show_banner:Dynamic = null;
	private static var hide_banner:Dynamic = null;
}
#end
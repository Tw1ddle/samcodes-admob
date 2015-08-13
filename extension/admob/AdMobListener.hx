package extension.admob;

class AdMobListener
{
	public function new() {
	}

	private function log(message:String):Void {
		#if debug
		trace(message);
		#end
	}

	// Called when a banner is clicked and about to return to the application.
	public function onBannerClosed(unitId:String):Void {
		log("onBannerClosed " + unitId);
	}
	
	// Called when a banner failed to load.
	public function onBannerFailedToLoad(unitId:String):Void {
		log("onBannerFailedToLoad " + unitId);
	}
	
	// Called when a banner is clicked and going to start a new Activity that will
	// leave the application (e.g. breaking out to the Browser or Maps application).
	public function onBannerLeftApplication(unitId:String):Void {
		log("onBannerLeftApplication " + unitId);
	}
	
	// Called when an Activity is created in front of the app (e.g. a banner is clicked and launches a new Activity).
	public function onBannerOpened(unitId:String):Void {
		log("onBannerOpened " + unitId);
	}
	
	// Called when a banner is loaded.
	public function onBannerLoaded(unitId:String):Void {
		log("onBannerLoaded " + unitId);
	}
	
	// Called when an interstitial is clicked and about to return to the application.
	public function onInterstitialClosed(unitId:String):Void {
		log("onInterstitialClosed " + unitId);
	}
	
	// Called when an interstitial failed to load.
	public function onInterstitialFailedToLoad(unitId:String):Void {
		log("onInterstitialFailedToLoad " + unitId);
	}
	
	// Called when an interstitial is clicked and going to start a new Activity that will
	// leave the application (e.g. breaking out to the Browser or Maps application).
	public function onInterstitialLeftApplication(unitId:String):Void {
		log("onInterstitialLeftApplication " + unitId);
	}
	
	// Called when an Activity is created in front of the app (e.g. an interstitial is shown).
	public function onInterstitialOpened(unitId:String):Void {
		log("onInterstitialOpened " + unitId);
	}
	
	// Called when an interstitial is loaded.
	public function onInterstitialLoaded(unitId:String):Void {
		log("onInterstitialLoaded " + unitId);
	}
	
	// TODO there are far better ways of doing this
	
	#if ios
	// Banner events
	public static inline var ON_BANNER_CLOSED:String = "onBannerClosed";
	public static inline var ON_BANNER_FAILED_TO_LOAD:String = "onBannerFailedToLoad";
	public static inline var ON_BANNER_LEFT_APPLICATION:String = "onBannerLeftApplication";
	public static inline var ON_BANNER_OPENED:String = "onBannerOpened";
	public static inline var ON_BANNER_LOADED:String = "onBannerLoaded";
	
	// Interstitial events
	public static inline var ON_INTERSTITIAL_CLOSED:String = "onInterstitialClosed";
	public static inline var ON_INTERSTITIAL_FAILED_TO_LOAD:String = "onInterstitialFailedToLoad";
	public static inline var ON_INTERSTITIAL_LEFT_APPLICATION:String = "onInterstitialLeftApplication";
	public static inline var ON_INTERSTITIAL_OPENED:String = "onInterstitialOpened";
	public static inline var ON_INTERSTITIAL_LOADED:String = "onInterstitialLoaded";
	
	public function notify(inEvent:Dynamic):Void {
		var type:String = "";
		var location:String = "";
		
		if (Reflect.hasField(inEvent, "type")) {
			type = Std.string (Reflect.field (inEvent, "type"));
		}
		
		if (Reflect.hasField(inEvent, "location")) {
			location = Std.string (Reflect.field (inEvent, "location"));
		}
		
		switch(type) {
			case ON_BANNER_CLOSED:
				onBannerClosed(location);
			case ON_BANNER_FAILED_TO_LOAD:
				onBannerFailedToLoad(location);
			case ON_BANNER_LEFT_APPLICATION:
				onBannerLeftApplication(location);
			case ON_BANNER_OPENED:
				onBannerOpened(location);
			case ON_BANNER_LOADED:
				onBannerLoaded(location);
				
			case ON_INTERSTITIAL_CLOSED:
				onInterstitialClosed(location);
			case ON_INTERSTITIAL_FAILED_TO_LOAD:
				onInterstitialFailedToLoad(location);
			case ON_INTERSTITIAL_LEFT_APPLICATION:
				onInterstitialLeftApplication(location);
			case ON_INTERSTITIAL_OPENED:
				onInterstitialOpened(location);
			case ON_INTERSTITIAL_LOADED:
				onInterstitialLoaded(location);
				
			default:
			{
				trace("Unhandled AdMob event. There shouldn't be any of these. Event type was [" + type + "]");
			}
		}
	}
	#end
}
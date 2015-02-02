package extension.admob;

class AdMobListener
{
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
	
	// TODO iOS events - there are far better ways of doing this
	
	#if ios
	// Events
	
	public function notify(inEvent:Dynamic):Void {
	}
	#end
}
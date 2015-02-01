package extension.chartboost;

class ChartboostListener
{
	public function shouldRequestInterstitial(location:String):Void {
		
	}
	
	public function shouldDisplayInterstitial(location:String):Void {
		
	}
	
	public function didCacheInterstitial(location:String):Void {
		
	}
	
	public function didFailToLoadInterstitial(location:String):Void {
		
	}
	
	public function didDismissInterstitial(location:String):Void {
		
	}
	
	public function didCloseInterstitial(location:String):Void {
		
	}
	
	public function didClickInterstitial(location:String):Void {
		
	}
	
	public function didDisplayInterstitial(location:String):Void {
		
	}
	
	public function shouldRequestMoreApps(location:String):Void {
		
	}
	
	public function shouldDisplayMoreApps(location:String):Void {
		
	}
	
	public function didFailToLoadMoreApps(location:String):Void {
		
	}
	
	public function didCacheMoreApps(location:String):Void {
		
	}
	
	public function didDismissMoreApps(location:String):Void {
		
	}
	
	public function didCloseMoreApps(location:String):Void {
		
	}
	
	public function didClickMoreApps(location:String):Void {
		
	}
	
	public function didDisplayMoreApps(location:String):Void {
		
	}
	
	public function shouldDisplayRewardedVideo(location:String):Void {
		
	}
	
	public function didCacheRewardedVideo(location:String):Void {
		
	}
	
	public function didFailToLoadRewardedVideo(location:String):Void {
		
	}
	
	public function didDismissRewardedVideo(location:String):Void {
		
	}
	
	public function didCloseRewardedVideo(location:String):Void {
		
	}
	
	public function didClickRewardedVideo(location:String):Void {
		
	}
	
	public function didCompleteRewardedVideo(location:String, reward:Int):Void {
		
	}
	
	public function didDisplayRewardedVideo(location:String):Void {
		
	}
	
	public function willDisplayVideo(location:String):Void {
		
	}
	
	public function didFailToRecordClick(uri:String):Void {
		
	}
	
	// TODO there are far better ways of doing this
	
	#if ios
	// Interstitial events
	private static inline var SHOULD_REQUEST_INTERSTITIAL:String = "shouldRequestInterstitial";
	private static inline var SHOULD_DISPLAY_INTERSTITIAL:String = "shouldDisplayInterstitial";
	private static inline var DID_CACHE_INTERSTITIAL:String = "didCacheInterstitial";
	private static inline var DID_FAIL_TO_LOAD_INTERSTITIAL:String = "didFailToLoadInterstitial";
	private static inline var DID_DISMISS_INTERSTITIAL:String = "didDismissInterstitial";
	private static inline var DID_CLOSE_INTERSTITIAL:String = "didCloseInterstitial";
	private static inline var DID_CLICK_INTERSTITIAL:String = "didClickInterstitial";
	private static inline var DID_DISPLAY_INTERSTITIAL:String = "didDisplayInterstitial";
	
	// More-apps events
	private static inline var SHOULD_REQUEST_MORE_APPS:String = "shouldRequestMoreApps";
	private static inline var SHOULD_DISPLAY_MORE_APPS:String = "shouldDisplayMoreApps";
	private static inline var DID_FAIL_TO_LOAD_MORE_APPS:String = "didFailToLoadMoreApps";
	private static inline var DID_CACHE_MORE_APPS:String = "didCacheMoreApps";
	private static inline var DID_DISMISS_MORE_APPS:String = "didDismissMoreApps";
	private static inline var DID_CLOSE_MORE_APPS:String = "didCloseMoreApps";
	private static inline var DID_CLICK_MORE_APPS:String = "didClickMoreApps";
	private static inline var DID_DISPLAY_MORE_APPS:String = "didDisplayMoreApps";
	
	// Rewarded video events
	private static inline var SHOULD_DISPLAY_REWARDED_VIDEO:String = "shouldDisplayRewardedVideo";
	private static inline var DID_CACHE_REWARDED_VIDEO:String = "didCacheRewardedVideo";
	private static inline var DID_FAIL_TO_LOAD_REWARDED_VIDEO:String = "didFailToLoadRewardedVideo";
	private static inline var DID_DISMISS_REWARDED_VIDEO:String = "didDismissRewardedVideo";
	private static inline var DID_CLOSE_REWARDED_VIDEO:String = "didCloseRewardedVideo";
	private static inline var DID_CLICK_REWARDED_VIDEO:String = "didClickRewardedVideo";
	private static inline var DID_COMPLETE_REWARDED_VIDEO:String = "didCompleteRewardedVideo";
	private static inline var DID_DISPLAY_REWARDED_VIDEO:String = "didDisplayRewardedVideo";
	
	private static inline var WILL_DISPLAY_VIDEO:String = "willDisplayVideo";
	
	// Misc
	private static inline var DID_FAIL_TO_RECORD_CLICK:String = "didFailToRecordClick";
	
	public function notify(inEvent:Dynamic):Void {
		var type:String = "";
		var location:String = ""; 
		var uri:String = "";
		var reward_coins:Int = 0;
		
		if (Reflect.hasField(inEvent, "type")) {
			type = Std.string (Reflect.field (inEvent, "type"));
		}
		
		if (Reflect.hasField(inEvent, "location")) {
			location = Std.string (Reflect.field (inEvent, "location"));
		}
		
		if (Reflect.hasField(inEvent, "uri")) {
			uri = Std.string (Reflect.field (inEvent, "uri"));
		}
		
		if (Reflect.hasField(inEvent, "reward_coins")) {
			reward_coins = cast (Reflect.field (inEvent, "reward_coins"));
		}
		
		switch(type) {
			case SHOULD_REQUEST_INTERSTITIAL:
				shouldRequestInterstitial(location);
			case SHOULD_DISPLAY_INTERSTITIAL:
				shouldDisplayInterstitial(location);
			case DID_CACHE_INTERSTITIAL:
				didCacheInterstitial(location);
			case DID_FAIL_TO_LOAD_INTERSTITIAL:
				didFailToLoadInterstitial(location);
			case DID_DISMISS_INTERSTITIAL:
				didDismissInterstitial(location);
			case DID_CLOSE_INTERSTITIAL:
				didCloseInterstitial(location);
			case DID_CLICK_INTERSTITIAL:
				didClickInterstitial(location);
			case DID_DISPLAY_INTERSTITIAL:
				didDisplayInterstitial(location);
				
			case SHOULD_REQUEST_MORE_APPS:
				shouldRequestMoreApps(location);
			case SHOULD_DISPLAY_MORE_APPS:
				shouldDisplayMoreApps(location);
			case DID_FAIL_TO_LOAD_MORE_APPS:
				didFailToLoadMoreApps(location);
			case DID_CACHE_MORE_APPS:
				didCacheMoreApps(location);
			case DID_DISMISS_MORE_APPS:
				didDismissMoreApps(location);
			case DID_CLOSE_MORE_APPS:
				didCloseMoreApps(location);
			case DID_CLICK_MORE_APPS:
				didClickMoreApps(location);
			case DID_DISPLAY_MORE_APPS:
				didDisplayMoreApps(location);
				
			case SHOULD_DISPLAY_REWARDED_VIDEO:
				shouldDisplayRewardedVideo(location);
			case DID_CACHE_REWARDED_VIDEO:
				didCacheRewardedVideo(location);
			case DID_FAIL_TO_LOAD_REWARDED_VIDEO:
				didFailToLoadRewardedVideo(location);
			case DID_DISMISS_REWARDED_VIDEO:
				didDismissRewardedVideo(location);
			case DID_CLOSE_REWARDED_VIDEO:
				didCloseRewardedVideo(location);
			case DID_CLICK_REWARDED_VIDEO:
				didClickRewardedVideo(location);
			case DID_COMPLETE_REWARDED_VIDEO:
				didCompleteRewardedVideo(location, reward_coins);
			case DID_DISPLAY_REWARDED_VIDEO:
				didDisplayRewardedVideo(location);
				
			case WILL_DISPLAY_VIDEO:
				willDisplayVideo(location);
				
			case DID_FAIL_TO_RECORD_CLICK:
				didFailToRecordClick(uri);
				
			default:
			{
				trace("Unhandled Chartboost event. There shouldn't be any of these. Event type was [" + type + "]");
			}
		}
	}
	#end
}
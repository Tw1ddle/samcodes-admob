#import <UIKit/UIKit.h>
#import <CoreFoundation/CoreFoundation.h>
#include <ctype.h>
#include <objc/runtime.h>

#include "SamcodesAdMob.h"

#import "GADInterstitial.h"
#import "GADBannerView.h"

extern "C" void sendAdMobEvent(const char* type, const char* location);

@interface AdMobImplementation : NSObject <GADInterstitialDelegate, GADBannerViewDelegate> {
}

-(GADInterstitial*)getInterstitialForAdUnit:(NSString*)location;
-(GADBannerView*)getBannerForAdUnit:(NSString*)location;

@end

@implementation AdMobImplementation

static NSMutableDictionary* bannerDictionary;
static NSMutableDictionary* interstitialDictionary;
static NSMutableArray* testDevices;
static int bannerPosition;

+ (AdMobImplementation*)sharedInstance {
   static AdMobImplementation* sharedInstance = nil;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
	  bannerPosition = 1; // Defaults to banners on top of screen
      sharedInstance = [[AdMobImplementation alloc] init];	  
	  bannerDictionary = [[NSMutableDictionary alloc] init];
	  interstitialDictionary = [[NSMutableDictionary alloc] init];
	  testDevices = [[NSMutableArray alloc] init];
	  [testDevices addObject:GAD_SIMULATOR_ID];
   });

   return sharedInstance;
}

-(GADInterstitial*)getInterstitialForAdUnit:(NSString*)location {
	GADInterstitial* interstitial = (GADInterstitial*)([interstitialDictionary objectForKey:location]);
	
	if(interstitial != nil && !interstitial.hasBeenUsed) {
		return interstitial;
	} else {
		interstitial.delegate = nil;
		
		GADInterstitial* new_interstitial = [[GADInterstitial alloc] init];
		new_interstitial.delegate = self;
		new_interstitial.adUnitID = location;
		[interstitialDictionary setObject:new_interstitial forKey:location];
		
		return new_interstitial;
	}
}

-(GADBannerView*)getBannerForAdUnit:(NSString*)location {
	GADBannerView* banner = (GADBannerView*)([bannerDictionary objectForKey:location]);
	
	if(banner == nil) {
		if([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeLeft ||
		[UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationLandscapeRight) {
			banner = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerLandscape];
		} else {
			banner = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait];
		}
		
		banner.adUnitID = location;
		banner.delegate = self;
		banner.rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
		[bannerDictionary setObject:banner forKey:location];
	}
	
	CGRect frame = banner.frame;
	int autoresizingMask = 0;
	
	if(bannerPosition == 0) {
		frame.origin.y = banner.rootViewController.view.bounds.size.height - frame.size.height;
		autoresizingMask += UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
		autoresizingMask += UIViewAutoresizingFlexibleTopMargin;
	} else if(bannerPosition == 1) {
		frame.origin.y = 0;
		autoresizingMask += UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
		autoresizingMask += UIViewAutoresizingFlexibleBottomMargin;
	}
	
	banner.frame = frame;
	banner.autoresizingMask = autoresizingMask;
	
	return banner;
}

- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
	sendAdMobEvent("onInterstitialLoaded", [ad.adUnitID cStringUsingEncoding:[NSString defaultCStringEncoding]]);
}

- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error {
	sendAdMobEvent("onInterstitialFailedToLoad", [ad.adUnitID cStringUsingEncoding:[NSString defaultCStringEncoding]]);
}

- (void)interstitialWillPresentScreen:(GADInterstitial *)ad {
	sendAdMobEvent("onInterstitialOpened", [ad.adUnitID cStringUsingEncoding:[NSString defaultCStringEncoding]]);
}

- (void)interstitialWillDismissScreen:(GADInterstitial *)ad {
	sendAdMobEvent("onInterstitialClosed", [ad.adUnitID cStringUsingEncoding:[NSString defaultCStringEncoding]]);
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)ad {
}

- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad {
	sendAdMobEvent("onInterstitialLeftApplication", [ad.adUnitID cStringUsingEncoding:[NSString defaultCStringEncoding]]);
}

- (void)adViewDidReceiveAd:(GADBannerView *)adView {
	sendAdMobEvent("onBannerLoaded", [adView.adUnitID cStringUsingEncoding:[NSString defaultCStringEncoding]]);
}

- (void)adView:(GADBannerView *)adView didFailToReceiveAdWithError:(GADRequestError *)error {
	if(adView.superview) {
		[adView removeFromSuperview];
	}
	
	adView.hidden = true;
	
	sendAdMobEvent("onBannerFailedToLoad", [adView.adUnitID cStringUsingEncoding:[NSString defaultCStringEncoding]]);
}

- (void)adViewWillPresentScreen:(GADBannerView *)adView {	
	sendAdMobEvent("onBannerOpened", [adView.adUnitID cStringUsingEncoding:[NSString defaultCStringEncoding]]);
}

- (void)adViewWillDismissScreen:(GADBannerView *)adView {
	sendAdMobEvent("onBannerClosed", [adView.adUnitID cStringUsingEncoding:[NSString defaultCStringEncoding]]);
}

- (void)adViewDidDismissScreen:(GADBannerView *)adView {
}

- (void)adViewWillLeaveApplication:(GADBannerView *)adView {
	sendAdMobEvent("onBannerLeftApplication", [adView.adUnitID cStringUsingEncoding:[NSString defaultCStringEncoding]]);
}

@end

extern "C" void sendAdMobEvent(const char* type, const char* location);

namespace samcodesadmob
{
    void initAdMob(const char* testDeviceHash)
    {
		if(testDeviceHash != nil) {
			NSString *nsTestDeviceHash = [[NSString alloc] initWithUTF8String:testDeviceHash];
			[testDevices addObject:nsTestDeviceHash];
		}
    }
	
	void showInterstitial(const char* location)
	{
        NSString *nsLocation = [[NSString alloc] initWithUTF8String:location];
		AdMobImplementation *instance = [AdMobImplementation sharedInstance];
		GADInterstitial* interstitial = [instance getInterstitialForAdUnit:nsLocation];
		
		if([interstitial isReady]) {
			[interstitial presentFromRootViewController:[[[UIApplication sharedApplication] keyWindow] rootViewController]];
		} else {
			// TODO could add timer that repeatedly request ad caching here, but it is better to make users cache their ads first...
			NSLog(@"Not showing ad - make sure it has been cached first");
		}
    }
	
    void cacheInterstitial(const char* location)
    {
        NSString *nsLocation = [[NSString alloc] initWithUTF8String:location];
		AdMobImplementation *instance = [AdMobImplementation sharedInstance];
		GADInterstitial* interstitial = [instance getInterstitialForAdUnit:nsLocation];
		
		GADRequest *request = [GADRequest request];
		request.testDevices = testDevices;
		[interstitial loadRequest:request];
    }
	
	void setBannerPosition(int position)
	{
		bannerPosition = position;
	}
	
    bool hasCachedInterstitial(const char* location)
    {
        NSString *nsLocation = [[NSString alloc] initWithUTF8String:location];
		AdMobImplementation *instance = [AdMobImplementation sharedInstance];
		GADInterstitial* interstitial = [instance getInterstitialForAdUnit:nsLocation];
		
		return [interstitial isReady];
    }
	
	void refreshBanner(const char* location)
	{
		NSString *nsLocation = [[NSString alloc] initWithUTF8String:location];
		AdMobImplementation *instance = [AdMobImplementation sharedInstance];
		GADBannerView* banner = [instance getBannerForAdUnit:nsLocation];
		
		GADRequest *request = [GADRequest request];
		request.testDevices = testDevices;
		[banner loadRequest:request];
	}
	
    void showBanner(const char* location)
    {
        NSString *nsLocation = [[NSString alloc] initWithUTF8String:location];
		AdMobImplementation *instance = [AdMobImplementation sharedInstance];
		GADBannerView* banner = [instance getBannerForAdUnit:nsLocation];
		
		if(!banner.superview) {
			[banner.rootViewController.view addSubview:banner];
		}
        
		banner.hidden = false;
    }
	
    void hideBanner(const char* location)
    {
        NSString *nsLocation = [[NSString alloc] initWithUTF8String:location];
		AdMobImplementation *instance = [AdMobImplementation sharedInstance];
		GADBannerView* banner = [instance getBannerForAdUnit:nsLocation];
		
		if(banner.superview) {
			[banner removeFromSuperview];
		}
		
		banner.hidden = true;
    }
}
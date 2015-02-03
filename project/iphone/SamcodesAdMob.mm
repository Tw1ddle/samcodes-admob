#import <UIKit/UIKit.h>
#import <CoreFoundation/CoreFoundation.h>
#include <ctype.h>
#include <objc/runtime.h>

#include "SamcodesAdMob.h"

#import "GADInterstitial.h"
#import "GADBannerView.h"

@interface AdMobImplementation : NSObject <GADInterstitialDelegate, GADBannerViewDelegate> {
}

@implementation AdMobImplementation

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
	sendAdMobEvent("onInterstitialClosed, [ad.adUnitID cStringUsingEncoding:[NSString defaultCStringEncoding]]);
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
		
		// TODO
    }
	
	void showInterstitial(const char* location)
	{
        NSString *nsLocation = [[NSString alloc] initWithUTF8String:location];
		
    }
	
    void cacheInterstitial(const char* location)
    {
        NSString *nsLocation = [[NSString alloc] initWithUTF8String:location];
		
    }
	
    bool hasCachedInterstitial(const char* location)
    {
        NSString *nsLocation = [[NSString alloc] initWithUTF8String:location];
		
    }
	
    bool showBanner(const char* location)
    {
        NSString *nsLocation = [[NSString alloc] initWithUTF8String:location];
		
    }
	
    bool hideBanner(const char* location)
    {
        NSString *nsLocation = [[NSString alloc] initWithUTF8String:location];
		
    }
}
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
}

- (void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error {
}

- (void)interstitialWillPresentScreen:(GADInterstitial *)ad {
}

- (void)interstitialWillDismissScreen:(GADInterstitial *)ad {
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)ad {
}

- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad {
}

- (void)adViewDidReceiveAd:(GADBannerView *)view {
}

- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error {
}

- (void)adViewWillPresentScreen:(GADBannerView *)adView {
}

- (void)adViewWillDismissScreen:(GADBannerView *)adView {
}

- (void)adViewDidDismissScreen:(GADBannerView *)adView {
}

- (void)adViewWillLeaveApplication:(GADBannerView *)adView {
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
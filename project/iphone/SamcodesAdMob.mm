#import <UIKit/UIKit.h>
#import <CoreFoundation/CoreFoundation.h>
#include <ctype.h>
#include <objc/runtime.h>

#include "SamcodesAdMob.h"

#import "GADInterstitial.h"
extern "C" {
    #import "GADBannerView.h"
}

@interface InterstitialListener : NSObject <GADInterstitialDelegate> {
	@public
	GADInterstitial *ad;
}

- (void)showInterstitial:(NSString*)location;

@implementation InterstitialListener

- (id)initWithID:(const char*)ID {
	self = [super init];
	ad = [[GADInterstitial alloc] init];
	ad.delegate = self;
	ad.adUnitID = [[NSString alloc] initWithUTF8String:ID];
	GADRequest *request = [GADRequest request];
	request.testDevices = @[ GAD_SIMULATOR_ID ];
	[ad performSelector:@selector(loadRequest:) withObject:request afterDelay:1];
	return self;
}

- (void)showInterstitial:(NSString*)location {
    if (ad != nil && ad.isReady) {
        [ad presentFromRootViewController:[[[UIApplication sharedApplication] keyWindow] rootViewController]];
    }
}

@end

extern "C" void sendAdMobEvent(const char* type, const char* location);

namespace samcodeschartboost
{	
    void initAdMob(const char *testDeviceHash)
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
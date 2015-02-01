#import <UIKit/UIKit.h>
#import <CoreFoundation/CoreFoundation.h>
#include <ctype.h>
#include <objc/runtime.h>

#import "Chartboost.h"
#include "SamcodesAdMob.h"

extern "C" void sendChartboostEvent(const char* type, const char* location, const char* uri, int reward_coins);

@interface MyChartboostDelegate : NSObject<ChartboostDelegate>
@end

@implementation MyChartboostDelegate

// Called before requesting an interstitial via the Chartboost API server.
- (BOOL)shouldRequestInterstitial:(CBLocation)location
{
	sendChartboostEvent("shouldRequestInterstitial", [location cStringUsingEncoding:[NSString defaultCStringEncoding]], "", 0);
    
    return YES;
}

// Called before an interstitial will be displayed on the screen.
- (BOOL)shouldDisplayInterstitial:(CBLocation)location
{
	sendChartboostEvent("shouldDisplayInterstitial", [location cStringUsingEncoding:[NSString defaultCStringEncoding]], "", 0);
    
    return YES;
}

// Called after an interstitial has been displayed on the screen.
- (void)didDisplayInterstitial:(CBLocation)location
{
	sendChartboostEvent("didDisplayInterstitial", [location cStringUsingEncoding:[NSString defaultCStringEncoding]], "", 0);
}

// Called after an interstitial has been loaded from the Chartboost API
// servers and cached locally.
- (void)didCacheInterstitial:(CBLocation)location
{
	sendChartboostEvent("didCacheInterstitial", [location cStringUsingEncoding:[NSString defaultCStringEncoding]], "", 0);
}

// Called after an interstitial has attempted to load from the Chartboost API
// servers but failed.
 - (void)didFailToLoadInterstitial:(CBLocation)location withError:(CBLoadError)error
 {
	 sendChartboostEvent("didFailToLoadInterstitial", [location cStringUsingEncoding:[NSString defaultCStringEncoding]], "", 0);
 }

// Called after a click is registered, but the user is not forwarded to the App Store.
- (void)didFailToRecordClick:(CBLocation)location withError:(CBClickError)error
{
	sendChartboostEvent("didFailToRecordClick", "", "", 0);
}

// Called after an interstitial has been dismissed.
- (void)didDismissInterstitial:(CBLocation)location
{
	sendChartboostEvent("didDismissInterstitial", [location cStringUsingEncoding:[NSString defaultCStringEncoding]], "", 0);
}

// Called after an interstitial has been closed.
- (void)didCloseInterstitial:(CBLocation)location
{
	sendChartboostEvent("didCloseInterstitial", [location cStringUsingEncoding:[NSString defaultCStringEncoding]], "", 0);
}

// Called after an interstitial has been clicked.
- (void)didClickInterstitial:(CBLocation)location
{
	sendChartboostEvent("didClickInterstitial", [location cStringUsingEncoding:[NSString defaultCStringEncoding]], "", 0);
}

// Called before a MoreApps page will be displayed on the screen.
- (BOOL)shouldDisplayMoreApps:(CBLocation)location
{
	sendChartboostEvent("shouldDisplayMoreApps", [location cStringUsingEncoding:[NSString defaultCStringEncoding]], "", 0);
    
    return YES;
}

// Called after a MoreApps page has been displayed on the screen.
- (void)didDisplayMoreApps:(CBLocation)location
{
	sendChartboostEvent("didDisplayMoreApps", [location cStringUsingEncoding:[NSString defaultCStringEncoding]], "", 0);
}

// Called after a MoreApps page has been loaded from the Chartboost API
// servers and cached locally.
- (void)didCacheMoreApps:(CBLocation)location
{
	sendChartboostEvent("didCacheMoreApps", [location cStringUsingEncoding:[NSString defaultCStringEncoding]], "", 0);
}

// Called after a MoreApps page has been dismissed.
- (void)didDismissMoreApps:(CBLocation)location
{
	sendChartboostEvent("didDismissMoreApps", [location cStringUsingEncoding:[NSString defaultCStringEncoding]], "", 0);
}

// Called after a MoreApps page has been closed.
- (void)didCloseMoreApps:(CBLocation)location
{
	sendChartboostEvent("didCloseMoreApps", [location cStringUsingEncoding:[NSString defaultCStringEncoding]], "", 0);
}

// Called after a MoreApps page has been clicked.
- (void)didClickMoreApps:(CBLocation)location
{
	sendChartboostEvent("didClickMoreApps", [location cStringUsingEncoding:[NSString defaultCStringEncoding]], "", 0);
}

// Called after a MoreApps page attempted to load from the Chartboost API
// servers but failed.
- (void)didFailToLoadMoreApps:(CBLocation)location withError:(CBLoadError)error
{
	sendChartboostEvent("didFailToLoadMoreApps", [location cStringUsingEncoding:[NSString defaultCStringEncoding]], "", 0);
}

// Called before a rewarded video will be displayed on the screen.
- (BOOL)shouldDisplayRewardedVideo:(CBLocation)location
{
	sendChartboostEvent("shouldDisplayRewardedVideo", [location cStringUsingEncoding:[NSString defaultCStringEncoding]], "", 0);
    
    return YES;
}

// Called after a rewarded video has been displayed on the screen.
- (void)didDisplayRewardedVideo:(CBLocation)location
{
	sendChartboostEvent("didDisplayRewardedVideo", [location cStringUsingEncoding:[NSString defaultCStringEncoding]], "", 0);
}

// Called after a rewarded video has been loaded from the Chartboost API
// servers and cached locally.
- (void)didCacheRewardedVideo:(CBLocation)location
{
	sendChartboostEvent("didCacheRewardedVideo", [location cStringUsingEncoding:[NSString defaultCStringEncoding]], "", 0);
}

// Called after a rewarded video has attempted to load from the Chartboost API
// servers but failed.
- (void)didFailToLoadRewardedVideo:(CBLocation)location withError:(CBLoadError)error
{
	sendChartboostEvent("didFailToLoadRewardedVideo", [location cStringUsingEncoding:[NSString defaultCStringEncoding]], "", 0);
}

// Called after a rewarded video has been dismissed.
- (void)didDismissRewardedVideo:(CBLocation)location
{
	sendChartboostEvent("didDismissRewardedVideo", [location cStringUsingEncoding:[NSString defaultCStringEncoding]], "", 0);
}

// Called after a rewarded video has been closed.
- (void)didCloseRewardedVideo:(CBLocation)location
{
	sendChartboostEvent("didCloseRewardedVideo", [location cStringUsingEncoding:[NSString defaultCStringEncoding]], "", 0);
}

// Called after a rewarded video has been clicked.
- (void)didClickRewardedVideo:(CBLocation)location
{
	sendChartboostEvent("didClickRewardedVideo", [location cStringUsingEncoding:[NSString defaultCStringEncoding]], "", 0);
}

// Called after a rewarded video has been viewed completely and user is eligible for reward.
- (void)didCompleteRewardedVideo:(CBLocation)location withReward:(int)reward
{
	sendChartboostEvent("didCompleteRewardedVideo", [location cStringUsingEncoding:[NSString defaultCStringEncoding]], "", reward);
}

// Implement to be notified of when a video will be displayed on the screen for 
// a given CBLocation. You can then do things like mute effects and sounds.
- (void)willDisplayVideo:(CBLocation)location
{
	sendChartboostEvent("willDisplayVideo", [location cStringUsingEncoding:[NSString defaultCStringEncoding]], "", 0);
}

// Whether Chartboost should show ads in the first session
// Defaults to YES
- (BOOL)shouldRequestInterstitialsInFirstSession
{
	return YES;
}

/*
// Use the following if you're seeing the Apple keyboard covering Chartboost interstitials
- (BOOL)shouldDisplayInterstitial:(NSString *)location
{
    NSLog(@"about to display interstitial at location %@", location);
    [self.window endEditing:YES];
    return YES;
}

// Called after the App Store sheet is dismissed, when displaying the embedded app sheet.
- (void)didCompleteAppStoreSheetFlow
{
}

// Called if Chartboost SDK pauses click actions awaiting confirmation from the user. Use
// to implement an age gate in your game.
- (void)didPauseClickForConfirmation
{
}
*/

@end

namespace samcodeschartboost
{	
    void initChartboost(const char *appId, const char *appSignature)
    {
        MyChartboostDelegate *myObject = [MyChartboostDelegate new];
        
        NSString *nsAppId = [[NSString alloc] initWithUTF8String:appId];
        NSString *nsSignature = [[NSString alloc] initWithUTF8String:appSignature];
        
        [Chartboost startWithAppId:nsAppId
                      appSignature:nsSignature
                          delegate:myObject];
    }
	
	void showInterstitial(const char* location)
	{
        NSString *nsLocation = [[NSString alloc] initWithUTF8String:location];
        [Chartboost showInterstitial:nsLocation];
    }
	
    void cacheInterstitial(const char* location)
    {
        NSString *nsLocation = [[NSString alloc] initWithUTF8String:location];
        [Chartboost cacheInterstitial:nsLocation];
    }
	
    bool hasCachedInterstitial(const char* location)
    {
        NSString *nsLocation = [[NSString alloc] initWithUTF8String:location];
        return [Chartboost hasInterstitial:nsLocation];
    }
	
	void showMoreApps(const char* location)
	{
        NSString *nsLocation = [[NSString alloc] initWithUTF8String:location];
        [Chartboost showMoreApps:nsLocation];
	}
	
    void cacheMoreApps(const char* location)
	{
        NSString *nsLocation = [[NSString alloc] initWithUTF8String:location];
        [Chartboost cacheMoreApps:nsLocation];
	}
	
    bool hasCachedMoreApps(const char* location)
	{
        NSString *nsLocation = [[NSString alloc] initWithUTF8String:location];
        return [Chartboost hasMoreApps:nsLocation];
	}
	
	void showRewardedVideo(const char* location)
	{
        NSString *nsLocation = [[NSString alloc] initWithUTF8String:location];
        [Chartboost showRewardedVideo:nsLocation];
	}
	
    void cacheRewardedVideo(const char* location)
	{
        NSString *nsLocation = [[NSString alloc] initWithUTF8String:location];
        [Chartboost cacheRewardedVideo:nsLocation];
	}
	
    bool hasCachedRewardedVideo(const char* location)
	{
        NSString *nsLocation = [[NSString alloc] initWithUTF8String:location];
        return [Chartboost hasRewardedVideo:nsLocation];
	}
}
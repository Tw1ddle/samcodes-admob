#ifndef CHARTBOOSTEXT_H
#define CHARTBOOSTEXT_H

namespace samcodeschartboost
{
    void initChartboost(const char *appId, const char *appSignature);
	void showInterstitial(const char* location);
    void cacheInterstitial(const char* location);
    bool hasCachedInterstitial(const char* location);
	void showMoreApps(const char* location);
    void cacheMoreApps(const char* location);
    bool hasCachedMoreApps(const char* location);
	void showRewardedVideo(const char* location);
    void cacheRewardedVideo(const char* location);
    bool hasCachedRewardedVideo(const char* location);
}

#endif
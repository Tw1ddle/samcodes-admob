#ifndef SAMCODESADMOB_H
#define SAMCODESADMOB_H

namespace samcodesadmob
{
	void initAdMob(const char* testDeviceHash);
	void showInterstitial(const char* location);
	void cacheInterstitial(const char* location);
	bool hasInterstitial(const char* location);
	void setBannerPosition(int horizontal, int vertical);
	void refreshBanner(const char* location);
	void showBanner(const char* location);
	void hideBanner(const char* location);
}

#endif
#ifndef SAMCODESADMOB_H
#define SAMCODESADMOB_H

namespace samcodesadmob
{
	void initAdMob(const char* testDeviceHash);
	void showInterstitial(const char* location);
	void cacheInterstitial(const char* location);
	bool hasCachedInterstitial(const char* location);
	void setBannerPosition(int position);
	void refreshBanner(const char* location);
	void showBanner(const char* location);
	void hideBanner(const char* location);
}

#endif
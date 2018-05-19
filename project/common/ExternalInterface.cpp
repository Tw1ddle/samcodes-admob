#ifndef STATIC_LINK
#define IMPLEMENT_API
#endif

#if defined(HX_WINDOWS) || defined(HX_MACOS) || defined(HX_LINUX)
#define NEKO_COMPATIBLE
#endif

#include <hx/CFFI.h>
#include <hx/CFFIPrime.h>

#include "SamcodesAdMob.h"

using namespace samcodesadmob;

#ifdef IPHONE

AutoGCRoot* adMobEventHandle = 0;

void samcodesadmob_init_admob(HxString hashedDeviceId)
{
	initAdMob(hashedDeviceId.c_str());
}
DEFINE_PRIME1v(samcodesadmob_init_admob);

void samcodesadmob_set_listener(value onEvent)
{
	if(adMobEventHandle == 0) {
		adMobEventHandle = new AutoGCRoot(onEvent);
	} else {
		adMobEventHandle->set(onEvent);
	}
}
DEFINE_PRIME1v(samcodesadmob_set_listener);

void samcodesadmob_show_interstitial(HxString location)
{
	showInterstitial(location.c_str());
}
DEFINE_PRIME1v(samcodesadmob_show_interstitial);

void samcodesadmob_cache_interstitial(HxString location)
{
	cacheInterstitial(location.c_str());
}
DEFINE_PRIME1v(samcodesadmob_cache_interstitial);

bool samcodesadmob_has_interstitial(HxString location)
{
	return hasInterstitial(location.c_str());
}
DEFINE_PRIME1(samcodesadmob_has_interstitial);

void samcodesadmob_set_banner_position(int horizontal, int vertical)
{
	setBannerPosition(horizontal, vertical);
}
DEFINE_PRIME2v(samcodesadmob_set_banner_position);

void samcodesadmob_refresh_banner(HxString location)
{
	refreshBanner(location.c_str());
}
DEFINE_PRIME1v(samcodesadmob_refresh_banner);

void samcodesadmob_show_banner(HxString location)
{
	showBanner(location.c_str());
}
DEFINE_PRIME1v(samcodesadmob_show_banner);

void samcodesadmob_hide_banner(HxString location)
{
	hideBanner(location.c_str());
}
DEFINE_PRIME1v(samcodesadmob_hide_banner);

extern "C" void samcodesadmob_main()
{
	val_int(0);
}
DEFINE_ENTRY_POINT(samcodesadmob_main);

extern "C" int samcodesadmob_register_prims()
{
	return 0;
}

extern "C" void sendAdMobEvent(const char* type, const char* location)
{
	if(adMobEventHandle == 0)
	{
		return;
	}
	value o = alloc_empty_object();
	alloc_field(o, val_id("type"), alloc_string(type));
	alloc_field(o, val_id("location"), alloc_string(location));
	val_call1(adMobEventHandle->get(), o);
}

#endif
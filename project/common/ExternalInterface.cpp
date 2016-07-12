#ifndef STATIC_LINK
#define IMPLEMENT_API
#endif

#if defined(HX_WINDOWS) || defined(HX_MACOS) || defined(HX_LINUX)
#define NEKO_COMPATIBLE
#endif

#include <hx/CFFI.h>
#include "SamcodesAdMob.h"

using namespace samcodesadmob;

#ifdef IPHONE

AutoGCRoot* adMobEventHandle = 0;

static value samcodesadmob_set_listener(value onEvent)
{
	adMobEventHandle = new AutoGCRoot(onEvent);
	return alloc_null();
}
DEFINE_PRIM(samcodesadmob_set_listener, 1);

static value samcodesadmob_init_admob(value hashed_device_id)
{
    initAdMob(val_string(hashed_device_id));
    return alloc_null();
}
DEFINE_PRIM(samcodesadmob_init_admob, 1);

static value samcodesadmob_show_interstitial(value location)
{
    showInterstitial(val_string(location));
    return alloc_null();
}
DEFINE_PRIM(samcodesadmob_show_interstitial, 1);

static value samcodesadmob_cache_interstitial(value location)
{
    cacheInterstitial(val_string(location));
    return alloc_null();
}
DEFINE_PRIM(samcodesadmob_cache_interstitial, 1);

static value samcodesadmob_has_interstitial(value location)
{
    return alloc_bool(hasInterstitial(val_string(location)));
}
DEFINE_PRIM(samcodesadmob_has_interstitial, 1);

static value samcodesadmob_set_banner_position(value horizontal, value vertical)
{
	setBannerPosition(val_int(horizontal), val_int(vertical));
	return alloc_null();
}
DEFINE_PRIM(samcodesadmob_set_banner_position, 2);

static value samcodesadmob_refresh_banner(value location)
{
	refreshBanner(val_string(location));
	return alloc_null();
}
DEFINE_PRIM(samcodesadmob_refresh_banner, 1);

static value samcodesadmob_show_banner(value location)
{
	showBanner(val_string(location));
	return alloc_null();
}
DEFINE_PRIM(samcodesadmob_show_banner, 1);

static value samcodesadmob_hide_banner(value location)
{
	hideBanner(val_string(location));
	return alloc_null();
}
DEFINE_PRIM(samcodesadmob_hide_banner, 1);

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
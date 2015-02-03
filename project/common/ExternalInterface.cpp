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

static value set_listener(value onEvent)
{
	adMobEventHandle = new AutoGCRoot(onEvent);
	return alloc_null();
}
DEFINE_PRIM(set_listener, 1);

static value init_admob(value hashed_device_id)
{
    initAdMob(val_string(id), val_string(signature));
    return alloc_null();
}
DEFINE_PRIM(init_admob, 1);

static value show_interstitial(value location)
{
    showInterstitial(val_string(location));
    return alloc_null();
}
DEFINE_PRIM(show_interstitial, 1);

static value cache_interstitial(value location)
{
    cacheInterstitial(val_string(location));
    return alloc_null();
}
DEFINE_PRIM(cache_interstitial, 1);

static value has_cached_interstitial(value location)
{
    return alloc_bool(hasCachedInterstitial(val_string(location)));
}
DEFINE_PRIM(has_cached_interstitial, 1);

static value show_banner(value location)
{
	showBanner(val_string(location));
	return alloc_null();
}
DEFINE_PRIM(show_banner, 1);

static value hide_banner(value location)
{
	hideBanner(val_string(location));
	return alloc_null();
}
DEFINE_PRIM(hide_banner, 1);

extern "C" void samcodesadmob_main()
{
	val_int(0);
}
DEFINE_ENTRY_POINT(samcodesadmob_main);

extern "C" int samcodesadmob_register_prims()
{ 
	return 0; 
}

// TODO need to do this more cleanly
extern "C" void sendAdmobEvent(const char* type, const char* location)
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
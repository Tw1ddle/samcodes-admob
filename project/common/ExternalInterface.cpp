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

AutoGCRoot* chartboostEventHandle = 0;

static value set_listener(value onEvent)
{
	chartboostEventHandle = new AutoGCRoot(onEvent);
	return alloc_null();
}
DEFINE_PRIM(set_listener, 1);

static value init_chartboost(value id, value signature)
{
    initChartboost(val_string(id), val_string(signature));
    return alloc_null();
}
DEFINE_PRIM(init_chartboost, 2);

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

static value show_more_apps(value location)
{
	showMoreApps(val_string(location));
	return alloc_null();
}
DEFINE_PRIM(show_more_apps, 1);

static value cache_more_apps(value location)
{
	cacheMoreApps(val_string(location));
	return alloc_null();
}
DEFINE_PRIM(cache_more_apps, 1);

static value has_cached_more_apps(value location)
{
	return alloc_bool(hasCachedMoreApps(val_string(location)));
}
DEFINE_PRIM(has_cached_more_apps, 1);

static value show_rewarded_video(value location)
{
	showRewardedVideo(val_string(location));
	return alloc_null();
}
DEFINE_PRIM(show_rewarded_video, 1);

static value cache_rewarded_video(value location)
{
	cacheRewardedVideo(val_string(location));
	return alloc_null();
}
DEFINE_PRIM(cache_rewarded_video, 1);

static value has_cached_rewarded_video(value location)
{
	return alloc_bool(hasCachedRewardedVideo(val_string(location)));
}
DEFINE_PRIM(has_cached_rewarded_video, 1);

extern "C" void samcodeschartboost_main()
{
	val_int(0);
}
DEFINE_ENTRY_POINT(samcodeschartboost_main);

extern "C" int samcodeschartboost_register_prims()
{ 
	return 0; 
}

// TODO need to do this more cleanly
extern "C" void sendChartboostEvent(const char* type, const char* location, const char* uri, int reward_coins)
{
    if(chartboostEventHandle == 0)
    {
        return;
    }
    
	value o = alloc_empty_object();
    alloc_field(o, val_id("type"), alloc_string(type));
    alloc_field(o, val_id("location"), alloc_string(location));
	alloc_field(o, val_id("uri"), alloc_string(uri));
	alloc_field(o, val_id("reward_coins"), alloc_int(reward_coins));
	val_call1(chartboostEventHandle->get(), o);
}

#endif
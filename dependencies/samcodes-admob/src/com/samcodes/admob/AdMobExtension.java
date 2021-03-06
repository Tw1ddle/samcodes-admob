package com.samcodes.admob;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.ImageView;
import org.haxe.extension.Extension;
import org.haxe.lime.HaxeObject;
import java.util.HashMap;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.Semaphore;
import java.util.concurrent.atomic.AtomicBoolean;
import android.widget.RelativeLayout;
import android.view.Gravity;

import com.google.android.gms.ads.*;

public class AdMobExtension extends Extension 
{
	private static String TAG = "AdMobExtension";
	private static String testDeviceId = "::ENV_AdmobTestDeviceId::";
	private static RelativeLayout bannerLayout = null;
	public static RelativeLayout getLayout() {
		if(bannerLayout == null) {
			bannerLayout = new RelativeLayout(mainActivity);
			bannerLayout.setGravity(Gravity.TOP | Gravity.CENTER_HORIZONTAL);
			RelativeLayout.LayoutParams p = new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.MATCH_PARENT, RelativeLayout.LayoutParams.MATCH_PARENT);					
			mainActivity.addContentView(bannerLayout, p);
			bannerLayout.bringToFront();
		}
		
		return bannerLayout;
	}
	
	// Assumes 1:1 mapping from ad unit ids to ads
	private static HashMap<String, AdView> unitIdToBannerView = new HashMap<String, AdView>();
	private static HashMap<String, InterstitialAd> unitIdToInterstitial = new HashMap<String, InterstitialAd>();
	
	public static HaxeObject callback = null;
	public static void setListener(HaxeObject haxeCallback) {
		Log.i(TAG, "Setting Haxe AdMob listener object");
		callback = haxeCallback;
	}
	
	public static void callHaxe(final String name, final Object[] args) {
		if(callback == null) {
			Log.w(TAG, "AdMob callback object is null, ignoring AdMob callback");
			return;
		}
		
		callbackHandler.post(new Runnable() {
			public void run() {
				Log.d(TAG, "Calling " + name + " from Java");
				callback.call(name, args);
			}
		});
	}
	
	@Override
	public void onResume() {
		for (AdView v : unitIdToBannerView.values()) {
			if(v != null) {
				v.resume();
			}
		}
		super.onResume();
	}
	
	@Override
	public void onPause() {
		for (AdView v : unitIdToBannerView.values()) {
			if(v != null) {
				v.pause();
			}
		}
		super.onPause();
	}
	
	@Override
	public void onDestroy() {
		for (AdView v : unitIdToBannerView.values()) {
			if(v != null) {
				v.destroy();
			}
		}
		super.onDestroy();
	}
	
	public static void setBannerPosition(final int horizontal, final int vertical) {
		mainActivity.runOnUiThread(new Runnable() {
			public void run() {
				Log.d(TAG, "Setting banner position");
				AdMobExtension.getLayout().setGravity(horizontal | vertical);
			}
		});
	}
	
	public static void refreshBanner(final String id) {
		final AdView view = getBannerViewForUnitId(id);
		
		if(view == null) {
			return;
		}
		
		mainActivity.runOnUiThread(new Runnable() {
			public void run() {
				AdRequest request = null;
				
				if(!testDeviceId.equals("null")) {
					request = new AdRequest.Builder().addTestDevice(AdRequest.DEVICE_ID_EMULATOR).addTestDevice(testDeviceId).build();
				} else {
					request = new AdRequest.Builder().addTestDevice(AdRequest.DEVICE_ID_EMULATOR).build();
				}
				
				if(view.getAdListener() == null) {
					view.setAdListener(new BannerListener(id));
				} else if(view.getAdListener().getClass().equals(BannerListener.class) == false) {
					view.setAdListener(new BannerListener(id));
				}
				
				Log.d(TAG, "Preparing to show banner with id " + id);
				view.loadAd(request);
			}
		});
	}
	
	public static void showBanner(final String id) {		
		final AdView view = getBannerViewForUnitId(id);
		
		if(view == null) {
			return;
		}
		
		mainActivity.runOnUiThread(new Runnable() {
			public void run() {
				Log.d(TAG, "Showing banner with id " + id);
				AdView view = AdMobExtension.getBannerViewForUnitId(id);
				view.setVisibility(View.VISIBLE);
				AdMobExtension.getLayout().removeAllViews();
				AdMobExtension.getLayout().addView(view);
				AdMobExtension.getLayout().bringToFront();
			}
		});
	}
	
	public static void hideBanner(final String id) {
		final AdView view = getBannerViewForUnitId(id);
		
		if(view == null) {
			return;
		}
		
		mainActivity.runOnUiThread(new Runnable() {
			public void run() {
				Log.d(TAG, "Hiding banner with id " + id);
				view.setVisibility(View.INVISIBLE);
				getLayout().removeAllViews();
				getLayout().bringToFront();
			}
		});
	}
	
	public static boolean hasInterstitial(String id) {
		final InterstitialAd ad = getInterstitialForUnitId(id);
		
		if(ad == null) {
			return false;
		}
		
		// AdMob checking if an ad is loaded has to happen on the UI thread
		// Since this is probably a fast operation wait for the result
		final Semaphore mutex = new Semaphore(0);
		final AtomicBoolean isLoaded = new AtomicBoolean();
		
		mainActivity.runOnUiThread(new Runnable() {
			public void run() {
				isLoaded.set(ad.isLoaded());
				mutex.release();
			}
		});
		
		try {
			mutex.acquire();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		
		return isLoaded.get();
	}
	
	public static void cacheInterstitial(final String id) {
		final InterstitialAd ad = getInterstitialForUnitId(id);
		
		if(ad != null) {
			mainActivity.runOnUiThread(new Runnable() {
				public void run() {
					AdRequest request = null;
					
					if(!testDeviceId.equals("null")) {
						request = new AdRequest.Builder().addTestDevice(AdRequest.DEVICE_ID_EMULATOR).addTestDevice(testDeviceId).build();
					} else {
						request = new AdRequest.Builder().addTestDevice(AdRequest.DEVICE_ID_EMULATOR).build();
					}
					
					if(ad.getAdListener() == null) {
						ad.setAdListener(new InterstitialListener(id));
					} else if(ad.getAdListener().getClass().equals(InterstitialListener.class) == false) {
						ad.setAdListener(new InterstitialListener(id));
					}
					
					Log.d(TAG, "Caching interstitial with id " + id);
					ad.loadAd(request);
				}
			});
		}
	}
	
	public static void showInterstitial(final String id) {
		final InterstitialAd ad = getInterstitialForUnitId(id);
		
		if(ad == null) {
			return;
		}
		
		if(!hasInterstitial(id)) {
			Log.d(TAG, "Not showing interstitial because it hasn't cached yet");
			return;
		}
			
		mainActivity.runOnUiThread(new Runnable() {
			public void run() {
				Log.d(TAG, "Preparing to show interstitial");
				
				if(ad.getAdListener() == null) {
					ad.setAdListener(new InterstitialListener(id));
				} else if(ad.getAdListener().getClass().equals(InterstitialListener.class) == false) {
					ad.setAdListener(new InterstitialListener(id));
				}
				
				Log.d(TAG, "Showing interstitial with ad unit id " + ad.getAdUnitId());
				ad.show();
			}
		});
	}
	
	private static InterstitialAd addInterstitialForUnitId(final String id) {
		final InterstitialAd ad = new InterstitialAd(mainActivity);
		
		if(ad.getAdUnitId() == null) {
			ad.setAdUnitId(id);
		} else if(ad.getAdUnitId().equals(id) == false) {
			ad.setAdUnitId(id);
		}
		
		unitIdToInterstitial.put(id, ad);
		
		return ad;
	}
	
	private static AdView addBannerViewForUnitId(final String id) {		
		final AdView ad = new AdView(mainActivity);
		
		if(ad.getAdUnitId() == null) {
			ad.setAdUnitId(id);
		} else if(ad.getAdUnitId().equals(id) == false) {
			ad.setAdUnitId(id);
		}
		
		ad.setAdSize(AdSize.SMART_BANNER);
		
		unitIdToBannerView.put(id, ad);
		
		return ad;
	}
	
	public static AdView getBannerViewForUnitId(String id) {
		AdView ad = unitIdToBannerView.get(id);
		
		if(ad == null) {
			Log.i(TAG, "Could not get banner view with id, adding a new one...");
			ad = addBannerViewForUnitId(id);
		}
		
		return ad;
	}
	
	private static InterstitialAd getInterstitialForUnitId(String id) {
		InterstitialAd ad = unitIdToInterstitial.get(id);
		
		if(ad == null) {
			Log.i(TAG, "Could not get interstitial with id " + id + " adding a new one...");
			ad = addInterstitialForUnitId(id);
		}
		
		return ad;
	}
}
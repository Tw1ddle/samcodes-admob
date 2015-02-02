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

import com.google.android.gms.ads.*;

public class AdMobExtension extends Extension 
{
	private static String TAG = "AdMobExtension";
	private static String testDeviceId = "::ENV_AdmobTestDeviceId::";
	
	// Assumes 1:1 mapping from ad unit ids to ads
	private HashMap<String, AdView> unitIdToBannerView = new Hashmap<String, AdView>();
	private HashMap<String, InterstitialAd> unitIdToInterstitial = new Hashmap<String, InterstitialAd>();
	
	public static HaxeObject callback = null;
	public static void setListener(HaxeObject haxeCallback) {
		Log.i(TAG, "Setting Haxe AdMob listener object");
		callback = haxeCallback;
	}
	
	private class MyBannerListener extends AdListener {
		private String id;
		
		public MyBannerListener(String id) {
			this.id = id;
		}
		
		public void callHaxe(final String name, final Object[] args) {
			if(callback != null) {
				callbackHandler.post(new Runnable() {
					public void run() {
						Log.d(TAG, "Calling " + name + " from Java");
						callback.call(name, args);
					}
				});
			} else {
				Log.w(TAG, "AdMob callback object is null, ignoring AdMob callback");
			}
		}
		
		/** Called when an ad is clicked and about to return to the application. */
		@Override
		public void onAdClosed() {
			Log.d(TAG, "onBannerClosed");
			
			callHaxe("onBannerClosed", new Object[] {id});
		}
		
		/** Called when an ad failed to load. */
		@Override
		public void onAdFailedToLoad(int error) {
			Log.d(TAG, "onBannerFailedToLoad: " + getErrorReason(error));
			
			callHaxe("onBannerFailedToLoad", new Object[] {id});
		}
		
		/**
		* Called when an ad is clicked and going to start a new Activity that will
		* leave the application (e.g. breaking out to the Browser or Maps
		* application).
		*/
		@Override
		public void onAdLeftApplication() {
			Log.d(TAG, "onBannerLeftApplication");
			
			callHaxe("onBannerLeftApplication", new Object[] {id});
		}
		
		/**
		* Called when an Activity is created in front of the app (e.g. an
		* interstitial is shown, or an ad is clicked and launches a new Activity).
		*/
		@Override
		public void onAdOpened() {
			Log.d(TAG, "onBannerOpened");
			
			callHaxe("onBannerOpened", new Object[] {id});
		}

		/** Called when an ad is loaded. */
		@Override
		public void onAdLoaded() {
			Log.d(TAG, "onBannerLoaded");
			
			callHaxe("onBannerLoaded", new Object[] {id});
		}
	}
	
	private class MyInterstitialListener extends AdListener {
		private String id;
		
		public MyInterstitialListener(String id) {
			this.id = id;
		}
		
		public void callHaxe(final String name, final Object[] args) {
			if(callback != null) {
				callbackHandler.post(new Runnable() {
					public void run() {
						Log.d(TAG, "Calling " + name + " from Java");
						callback.call(name, args);
					}
				});
			} else {
				Log.w(TAG, "AdMob callback object is null, ignoring AdMob callback");
			}
		}
		
		/** Called when an ad is clicked and about to return to the application. */
		@Override
		public void onAdClosed() {
			Log.d(TAG, "onInterstitialClosed");
			
			callHaxe("onInterstitialClosed", new Object[] {id});
		}
		
		/** Called when an ad failed to load. */
		@Override
		public void onAdFailedToLoad(int error) {
			Log.d(TAG, "onInterstitialFailedToLoad: " + getErrorReason(error));
			
			callHaxe("onInterstitialFailedToLoad", new Object[] {id});
		}
		
		/**
		* Called when an ad is clicked and going to start a new Activity that will
		* leave the application (e.g. breaking out to the Browser or Maps
		* application).
		*/
		@Override
		public void onAdLeftApplication() {
			Log.d(TAG, "onInterstitialLeftApplication");
			
			callHaxe("onInterstitialLeftApplication", new Object[] {id});
		}
		
		/**
		* Called when an Activity is created in front of the app (e.g. an
		* interstitial is shown, or an ad is clicked and launches a new Activity).
		*/
		@Override
		public void onAdOpened() {
			Log.d(TAG, "onInterstitialOpened");
			
			callHaxe("onInterstitialOpened", new Object[] {id});
		}

		/** Called when an ad is loaded. */
		@Override
		public void onAdLoaded() {
			Log.d(TAG, "onInterstitialLoaded");
			
			callHaxe("onInterstitialLoaded", new Object[] {id});
		}
	}
	
	@Override
	public void onCreate (Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
	}
	
	@Override
	public void onStart() {
		super.onStart();
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
	
	public void showBanner(String id) {
		AdView view = getBannerViewForUnitId(id);
		
		if(view != null) {
			view.show();
		}
	}
	
	public void hideBanner(String id) {
		AdView view = getBannerViewForUnitId(id);
		
		if(view != null) {
			view.hide();
		}
	}
	
	public boolean hasCachedInterstitial(String id) {
		InterstitialAd ad = getInterstitialForUnitId();
		
		if(ad == null) {
			return false;
		}
		
		return ad.isLoaded();
	}
	
	public void cacheInterstitial(String id) {
		InterstitialAd ad = getInterstitialForUnitId();
		
		if(ad != null) {
			AdRequest request = null;
			
			if(testDeviceId != "null") {
				AdRequest request = new AdRequest.Builder()
				.addTestDevice(testDeviceId)
				.build();
			} else {
				AdRequest request = new AdRequest.Builder()
				.build();
			}

			ad.loadAd(request);
		}
	}
	
	public void showInterstitial(String id) {
		InterstitialAd ad = getInterstitialForUnitId();
		
		if(ad != null) {
			ad.show();
		}
	}
	
	private InterstitialAd addInterstitialForUnitId(String id) {
		if(unitIdToInterstitial.containsKey(id)) {
			Log.e(TAG, "This interstitial is already in the ad unit id->interstitial map, replacing it...");
		}
		
		InterstitialAd ad = new InterstitialAd(mainActivity);
		ad.setAdUnitId(id);
		ad.setAdListener(new MyAdListener(id));
		
		return ad;
	}
	
	private AdView addBannerViewForUnitId(String id) {
		if(unitIdToBannerView.containsKey(id)) {
			Log.e(TAG, "This banner is already in the ad unit id->bannerview map, replacing it...");
		}
		
		AdView ad = new AdView(mainActivity);
		ad.setAdUnitId(id);
		ad.setAdSize(size);
		ad.setAdListener(new MyAdListener(id));
		
		unitIdToBannerView.put(id, ad);
		
		return ad;
	}
	
	private AdView getBannerViewForUnitId(String id) {
		AdView ad = unitIdToBannerView.get(id);
		
		if(ad == null) {
			Log.i(TAG, "Could not get banner view with id, adding a new one...");
			ad = addBannerViewForUnitId(id);
		}
		
		return ad;
	}
	
	private InterstitialAd getInterstitialForUnitId(String id) {
		AdView ad = unitIdToInterstitial.get(id);
		
		if(ad == null) {
			Log.i(TAG, "Could not get interstitial with id " + id + " adding a new one...");
			ad = addInterstitialForUnitId(id);
		}
		
		return ad;
	}
}
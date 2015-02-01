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
	
	public static HaxeObject callback = null;
	public static void setListener(HaxeObject haxeCallback) {
		Log.i(TAG, "Setting Haxe AdMob listener object");
		callback = haxeCallback;
	}
	
	private HashMap<String, AdView> idToView = new Hashmap<String, AdView>();
	
	private class MyAdListener extends AdListener {
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
			Log.d(TAG, "onAdClosed");
		}
		
		/** Called when an ad failed to load. */
		@Override
		public void onAdFailedToLoad(int error) {
			Log.d(TAG, "onAdFailedToLoad: " + getErrorReason(error));
		}
		
		/**
		* Called when an ad is clicked and going to start a new Activity that will
		* leave the application (e.g. breaking out to the Browser or Maps
		* application).
		*/
		@Override
		public void onAdLeftApplication() {
			Log.d(TAG, "onAdLeftApplication");
		}

		/**
		* Called when an Activity is created in front of the app (e.g. an
		* interstitial is shown, or an ad is clicked and launches a new Activity).
		*/
		@Override
		public void onAdOpened() {
			Log.d(TAG, "onAdOpened");
		}

		/** Called when an ad is loaded. */
		@Override
		public void onAdLoaded() {
			Log.d(TAG, "onAdLoaded");
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
		super.onResume();
	}
	
	@Override
	public void onPause() {
		super.onPause();
	}
	
	@Override
	public void onStop() {
		super.onStop();
	}
	
	@Override
	public void onDestroy() {
		super.onDestroy();
	}
	
	public static boolean hasCachedInterstitial(String id) {
		return false;
	}

	public static void cacheInterstitial(String id) {
	}
	
	public static void showInterstitial(String id) {
	}
	
	public static boolean hasCachedBanner(String id) {
		return false;
	}
	
	public static void cacheBanner(String id) {
	}
	
	public static void showBanner(String id) {
	}
	
	private AdView getViewForId(String id) {
		return 
	}
}
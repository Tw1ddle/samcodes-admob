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

import com.google.android.gms.ads.*;

class BannerListener extends AdListener {
	private static String TAG = "BannerListener";
	
	private String id;
	
	public BannerListener(String id) {
		this.id = id;
	}
	
	/** Called when an ad is clicked and about to return to the application. */
	@Override
	public void onAdClosed() {
		Log.d(TAG, "onBannerClosed");
		
		AdMobExtension.callHaxe("onBannerClosed", new Object[] {id});
	}
	
	/** Called when an ad failed to load. */
	@Override
	public void onAdFailedToLoad(int error) {
		Log.d(TAG, "onBannerFailedToLoad: " + AdMobExtension.getErrorReason(error));
		
		Log.d(TAG, "Hiding banner with id " + id);
		AdView view = AdMobExtension.getBannerViewForUnitId(id);
		view.setVisibility(View.INVISIBLE);
		AdMobExtension.getLayout().removeView(view);
		AdMobExtension.getLayout().bringToFront();
		
		AdMobExtension.callHaxe("onBannerFailedToLoad", new Object[] {id});
	}
	
	/**
	* Called when an ad is clicked and going to start a new Activity that will
	* leave the application (e.g. breaking out to the Browser or Maps
	* application).
	*/
	@Override
	public void onAdLeftApplication() {
		Log.d(TAG, "onBannerLeftApplication");
		
		AdMobExtension.callHaxe("onBannerLeftApplication", new Object[] {id});
	}
	
	/**
	* Called when an Activity is created in front of the app (e.g. an
	* interstitial is shown, or an ad is clicked and launches a new Activity).
	*/
	@Override
	public void onAdOpened() {
		Log.d(TAG, "onBannerOpened");
		
		AdMobExtension.callHaxe("onBannerOpened", new Object[] {id});
	}

	/** Called when an ad is loaded. */
	@Override
	public void onAdLoaded() {
		Log.d(TAG, "onBannerLoaded");
		
		AdMobExtension.callHaxe("onBannerLoaded", new Object[] {id});
	}
}
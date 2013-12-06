/**
 * Copyright (C) 2012 30ideas (http://30ide.as)
 * MIT licensed
 * 
 * @author Josemando Sobral
 * @created Jul 2nd, 2012.
 * improved by Hongbo LU
 */
package org.apache.cordova.screenshot;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;
import org.json.JSONArray;
import org.json.JSONException;

import android.graphics.Bitmap;
import android.os.Environment;
import android.view.View;

public class Screenshot extends CordovaPlugin {

	@Override
	public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
	 	// starting on ICS, some WebView methods
		// can only be called on UI threads
		if (action.equals("saveScreenshot")) {
			super.cordova.getActivity().runOnUiThread(new Runnable() {
				@Override
				public void run() {
					View view = webView.getRootView();

					view.setDrawingCacheEnabled(true);
					Bitmap bitmap = Bitmap.createBitmap(view.getDrawingCache());
					view.setDrawingCacheEnabled(false);

					try {
						File folder = new File(Environment.getExternalStorageDirectory(), "Pictures");
						if (!folder.exists()) {
							folder.mkdirs();
						}

						File f = new File(folder, "screenshot_" + System.currentTimeMillis() + ".png");

						FileOutputStream fos = new FileOutputStream(f);
						bitmap.compress(Bitmap.CompressFormat.PNG, 100, fos);
						callbackContext.success();

					} catch (IOException e) {
						callbackContext.error(e.getMessage()));
					}
				}
			});
			return true;
		}
		callbackContext.error("action not found");
		return false;
		
	}

}

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
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONException;

import android.graphics.Bitmap;
import android.os.Environment;
import android.view.View;

public class Screenshot extends CordovaPlugin {

	@Override
	public boolean execute(String action, JSONArray args, final CallbackContext callbackContext) throws JSONException {
	 	// starting on ICS, some WebView methods
		// can only be called on UI threads
		final String format = (String) args.get(0);
		final Integer quality = (Integer) args.get(1);
		if (action.equals("saveScreenshot")) {
			super.cordova.getActivity().runOnUiThread(new Runnable() {
				@Override
				public void run() {
					View view = webView.getRootView();
					try {
						if(format.equals("png") || format.equals("jpg")){
							view.setDrawingCacheEnabled(true);
							Bitmap bitmap = Bitmap.createBitmap(view.getDrawingCache());
							view.setDrawingCacheEnabled(false);
							File folder = new File(Environment.getExternalStorageDirectory(), "Pictures");
							if (!folder.exists()) {
								folder.mkdirs();
							}

							File f = new File(folder, "screenshot_" + System.currentTimeMillis() + "."+format);

							FileOutputStream fos = new FileOutputStream(f);
							if(format.equals("png")){
								bitmap.compress(Bitmap.CompressFormat.PNG, 100, fos);
							}
							if(format.equals("jpg")){
								bitmap.compress(Bitmap.CompressFormat.JPEG, quality == null?100:quality, fos);
							}
							JSONObject jsonRes = new JSONObject();
							jsonRes.put("filePath",f.getAbsolutePath());
				                        PluginResult result = new PluginResult(PluginResult.Status.OK, jsonRes);
				                        callbackContext.sendPluginResult(result);
						}else{
							callbackContext.error("format "+format+" not found");
							
						}

					} catch (JSONException e) {
						callbackContext.error(e.getMessage());
						
					} catch (IOException e) {
						callbackContext.error(e.getMessage());
						
					}
				}
			});
			return true;
		}
		callbackContext.error("action not found");
		return false;
		
	}

}

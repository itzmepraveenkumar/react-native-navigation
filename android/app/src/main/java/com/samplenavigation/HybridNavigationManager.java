package com.samplenavigation;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

import com.facebook.react.bridge.Arguments;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.ReadableMapKeySetIterator;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.modules.core.DeviceEventManagerModule;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by Dojo on 3/3/17.
 */

public class HybridNavigationManager extends ReactContextBaseJavaModule {

    public HybridNavigationManager(ReactApplicationContext reactContext) {
        super(reactContext);
    }

    public String getName() {
        return "HybridNavigationManager";
    }

    @ReactMethod
    public void navigate(String name, String type, String data) {
        Intent intent = new Intent(getReactApplicationContext(), MainActivity.class);
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        Bundle bundle = new Bundle();
        bundle.putString("name",name);
        bundle.putString("type",type);
        if (data != null) {
            bundle.putString("params",data);
        }
        intent.putExtras(bundle);
        getReactApplicationContext().startActivity(intent);
    }

    @ReactMethod
    public void goBack(String name, String type, ReadableMap data) {
        getCurrentActivity().finish();
        sendEvent("EVENTBACK",data);
    }

    @ReactMethod
    public void sendJSEvent(String eventName, ReadableMap params) {
        this.sendEvent(eventName,params);
    }

    @ReactMethod
    public void enableBack(String flag) {
        MainActivity curActivity = (MainActivity) getCurrentActivity();
        if ("1".equals(flag)) {
            curActivity.isBackButton = true;
        }
        else {
            curActivity.isBackButton = false;
        }
    }

    @ReactMethod
    public void saveEventInAnalytics(String eventName, String properties) {

    }

    private Map<String, String> recursivelyDeconstructReadableMap(ReadableMap readableMap) {
        ReadableMapKeySetIterator iterator = readableMap.keySetIterator();
        Map<String, String> deconstructedMap = new HashMap<>();
        while (iterator.hasNextKey()) {
            String key = iterator.nextKey();
            deconstructedMap.put(key, readableMap.getString(key));
        }
        return deconstructedMap;
    }

    private void sendEvent(String eventName, ReadableMap params) {
        if (params != null) {
            WritableMap data = Arguments.createMap();
            data.merge(params);
            getReactApplicationContext().getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class).emit(eventName, data);
        }
    }
}

package com.example.selected_photo_access;

import static androidx.core.content.ContextCompat.startActivity;

import android.Manifest;
import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.os.Build;
import android.provider.Settings;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import java.sql.Array;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.embedding.android.FlutterFragmentActivity;

/**
 * SelectedPhotoAccessPlugin
 */
public class SelectedPhotoAccessPlugin implements FlutterPlugin, MethodCallHandler, PluginRegistry.RequestPermissionsResultListener, ActivityAware {
    private static final String TAG = "SelectedPhotoAccessPlug";
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;

    private static final String CHANNEL_NAME = "my_permission_plugin";
    private static final int REQUEST_CODE = 123;

    private static final int PERMISSION_DENIED = 0;
    private static final int PERMISSION_PARTIAL = 1;
    private static final int PERMISSION_GRANTED = 2;


    private Context context;
    private PluginRegistry.RequestPermissionsResultListener permissionResultListener;

    private Activity activity;

    private MethodChannel.Result permissionResult;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "selected_photo_access");
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }


    @Override
    public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
        context = binding.getActivity().getApplicationContext();
        permissionResultListener = this;
        binding.addRequestPermissionsResultListener(permissionResultListener);
        activity = binding.getActivity();
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        context = null;
    }

    @Override
    public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
        context = binding.getActivity().getApplicationContext();
        permissionResultListener = this;
        binding.addRequestPermissionsResultListener(permissionResultListener);
        activity = binding.getActivity();
    }

    @Override
    public void onDetachedFromActivity() {
        context = null;
    }

    private Activity getActivity() {
        if (context instanceof FlutterFragmentActivity) {
            return (FlutterFragmentActivity) context;
        }
        return activity;
    }


    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        final ArrayList<String> android13 = new ArrayList<>();
        final ArrayList<String> android14 = new ArrayList<>();
        final ArrayList<String> other = new ArrayList<>();

        switch (call.method) {
            case "requestPermissions":
                android14.clear();
                android13.clear();
                other.clear();

                if (call.argument("android13") != null) {
                    android13.addAll(call.argument("android13"));
                }
                if (call.argument("android14") != null) {
                    android14.addAll(call.argument("android14"));
                }
                if (call.argument("other") != null) {
                    other.addAll(call.argument("other"));
                }
                requestPermissions(result, android13, android14, other, false);
                break;
            case "checkPermissionStates":
                android14.clear();
                android13.clear();
                other.clear();

                if (call.argument("android13") != null) {
                    android13.addAll(call.argument("android13"));
                }
                if (call.argument("android14") != null) {
                    android14.addAll(call.argument("android14"));
                }
                if (call.argument("other") != null) {
                    other.addAll(call.argument("other"));
                }
                requestPermissions(result, android13, android14, other, true);
                break;
            case "getSdkVersion":
                sdkVersion(result);
                break;
            case "openAppSettings":
                openAppSettings();
                break;
            default:
                result.notImplemented();
        }
    }

    private void sdkVersion(MethodChannel.Result result) {
        result.success(Build.VERSION.SDK_INT);
    }

    private void openAppSettings() {
        Intent intent = new Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS);
        Uri uri = Uri.fromParts("package", getActivity().getPackageName(), null);
        intent.setData(uri);
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        context.startActivity(intent);
    }

    private void requestPermissions(MethodChannel.Result result, ArrayList android13, ArrayList android14, ArrayList other, boolean checkPermissons) {
        this.permissionResult = result;
        final ArrayList<String> permissionsToRequest = new ArrayList<>();

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) {
            if (android14.isEmpty()) {
                permissionsToRequest.add(Manifest.permission.READ_MEDIA_IMAGES);
                permissionsToRequest.add(Manifest.permission.READ_MEDIA_VIDEO);
                permissionsToRequest.add(Manifest.permission.READ_MEDIA_VISUAL_USER_SELECTED);
            } else {
                permissionsToRequest.addAll(android14);
            }
        } else if (Build.VERSION.SDK_INT == Build.VERSION_CODES.TIRAMISU) {
            if (android13.isEmpty()) {
                permissionsToRequest.add(Manifest.permission.READ_MEDIA_IMAGES);
                permissionsToRequest.add(Manifest.permission.READ_MEDIA_VIDEO);
                permissionsToRequest.add(Manifest.permission.READ_MEDIA_AUDIO);
            } else {
                permissionsToRequest.addAll(android13);
            }
        } else {
            if (other.isEmpty()) {
                permissionsToRequest.add(Manifest.permission.READ_EXTERNAL_STORAGE);
            } else {
                permissionsToRequest.addAll(other);
            }
        }
        if (checkPermissons) {
            checkPermissions(getActivity(), permissionsToRequest);
            return;
        }
        ActivityCompat.requestPermissions(getActivity(), permissionsToRequest.toArray(new String[permissionsToRequest.toArray().length]), REQUEST_CODE);
    }

    public void checkPermissions(Context context, ArrayList<String> permissionsToCheck) {
        final Map<String, Integer> permissionStatusMap = new HashMap<>();

        for (String permission : permissionsToCheck) {
            int grantResult = ContextCompat.checkSelfPermission(context, permission);

            if (grantResult == PackageManager.PERMISSION_DENIED) {
                final boolean isNotPermanentlyDenied = ActivityCompat.shouldShowRequestPermissionRationale(getActivity(), permission);
                if (isNotPermanentlyDenied) {
                    grantResult = -2;
                }
            }

            // Map the permission to its grant status
            permissionStatusMap.put(permission, grantResult);
        }

        if (permissionResult != null) {
            permissionResult.success(permissionStatusMap);
        }
        permissionResult = null;
    }

    @Override
    public boolean onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        if (requestCode == REQUEST_CODE) {
            final Map<String, Integer> permissionStatusMap = new HashMap<>();

            for (int i = 0; i < grantResults.length; i++) {
                String permission = permissions[i];
                int grantResult = grantResults[i];
                if (grantResult == PackageManager.PERMISSION_DENIED) {
                    final boolean isNotPermanentlyDenied = ActivityCompat.shouldShowRequestPermissionRationale(getActivity(), permission);
                    if (isNotPermanentlyDenied) {
                        grantResult = -2;
                    }
                }
                // Map the permission to its grant status
                permissionStatusMap.put(permission, grantResult);
            }
            if (permissionResult != null)
                permissionResult.success(permissionStatusMap);
            permissionResult = null;
            return true;
        }
        return false;
    }


}

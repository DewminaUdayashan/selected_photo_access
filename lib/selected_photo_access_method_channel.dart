import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:selected_photo_access/permission.dart';

import 'selected_photo_access_platform_interface.dart';

/// An implementation of [SelectedPhotoAccessPlatform] that uses method channels.
class MethodChannelSelectedPhotoAccess extends SelectedPhotoAccessPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('selected_photo_access');

  @override
  Future<Map<String, int>> checkPermissionStates({
    List<Permission>? android13,
    List<Permission>? android14,
    List<Permission>? other,
  }) async {
    final map = <String, List>{};
    if (android13 != null) {
      map['android13'] =
          android13.map((permission) => permission.value).toList();
    }
    if (android14 != null) {
      map['android14'] =
          android14.map((permission) => permission.value).toList();
    }
    if (other != null) {
      map['other'] = other.map((permission) => permission.value).toList();
    }
    return Map<String, int>.from(
        await methodChannel.invokeMethod('checkPermissionStates', map));
  }

  @override
  Future<Map<String, int>> requestPermission({
    List<Permission>? android13,
    List<Permission>? android14,
    List<Permission>? other,
  }) async {
    final map = <String, List>{};
    if (android13 != null) {
      map['android13'] =
          android13.map((permission) => permission.value).toList();
    }
    if (android14 != null) {
      map['android14'] =
          android14.map((permission) => permission.value).toList();
    }
    if (other != null) {
      map['other'] = other.map((permission) => permission.value).toList();
    }
    return Map<String, int>.from(
        await methodChannel.invokeMethod('requestPermissions', map));
  }

  @override
  Future<int> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod("getSdkVersion");
    return version;
  }

  @override
  Future<void> openAppSettings() {
    return methodChannel.invokeMapMethod("openAppSettings");
  }
}

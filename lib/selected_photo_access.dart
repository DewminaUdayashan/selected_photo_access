import 'package:selected_photo_access/permission.dart';
import 'package:selected_photo_access/permission_status.dart';

import 'selected_photo_access_platform_interface.dart';
export 'permission_extensions.dart';
export 'permission_extensions.dart';
export 'permission.dart';
export 'permission_status.dart';
export 'version_codes.dart';

class SelectedPhotoAccess {
  // Method to request permissions
  static Future<Map<Permission, PermissionStatus>> requestPermissions({
    List<Permission>? android13,
    List<Permission>? android14,
    List<Permission>? other,
  }) async {
    final results =
        await SelectedPhotoAccessPlatform.instance.requestPermission(
      android13: android13,
      android14: android14,
      other: other,
    );
    return results.map((key, value) => MapEntry(
          Permission.parsePermission(key),
          PermissionStatus.parseStates(value),
        ));
  }

  static Future<Map<Permission, PermissionStatus>> checkPermissionStates({
    List<Permission>? android13,
    List<Permission>? android14,
    List<Permission>? other,
  }) async {
    final results =
        await SelectedPhotoAccessPlatform.instance.checkPermissionStates(
      android13: android13,
      android14: android14,
      other: other,
    );
    return results.map((key, value) => MapEntry(
          Permission.parsePermission(key),
          PermissionStatus.parseStates(value),
        ));
  }

  @override
  static Future<int> getPlatformVersion() {
    return SelectedPhotoAccessPlatform.instance.getPlatformVersion();
  }

  @override
  static Future<void> openAppSettings() {
    return SelectedPhotoAccessPlatform.instance.openAppSettings();
  }
}

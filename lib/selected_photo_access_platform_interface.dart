import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:selected_photo_access/permission.dart';

import 'selected_photo_access_method_channel.dart';

abstract class SelectedPhotoAccessPlatform extends PlatformInterface {
  /// Constructs a SelectedPhotoAccessPlatform.
  SelectedPhotoAccessPlatform() : super(token: _token);

  static final Object _token = Object();

  static SelectedPhotoAccessPlatform _instance =
      MethodChannelSelectedPhotoAccess();

  /// The default instance of [SelectedPhotoAccessPlatform] to use.
  ///
  /// Defaults to [MethodChannelSelectedPhotoAccess].
  static SelectedPhotoAccessPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SelectedPhotoAccessPlatform] when
  /// they register themselves.
  static set instance(SelectedPhotoAccessPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<Map<String, int>> requestPermission({
    List<Permission>? android13,
    List<Permission>? android14,
    List<Permission>? other,
  }) {
    throw UnimplementedError('requestPermission() has not been implemented.');
  }

  Future<Map<String, int>> checkPermissionStates({
    List<Permission>? android13,
    List<Permission>? android14,
    List<Permission>? other,
  }) {
    throw UnimplementedError(
        'checkPermissionStates() has not been implemented.');
  }

  Future<int> getPlatformVersion() =>
      throw UnimplementedError('getPlatformVersion() has not been implemented.');

  Future<void> openAppSettings() =>
      throw UnimplementedError('openAppSettings() has not been implemented.');
}

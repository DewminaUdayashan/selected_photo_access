import 'package:flutter/material.dart';
import 'package:selected_photo_access/permission.dart';
import 'package:selected_photo_access/permission_status.dart';
import 'package:selected_photo_access/selected_photo_access.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Selected photo access example app'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () async {
                    // Request permissions for media access based on Android version
                    final Map<Permission, PermissionStatus> permissionResults =
                        await SelectedPhotoAccess.requestPermissions();
                    if (permissionResults.isAllGranted) {
                      // User has granted all permissions you've requested
                      return;
                    } else {
                      final int version =
                          await SelectedPhotoAccess.getPlatformVersion();

                      if (version >= Android.upsideDownCake.sdkInt) {
                        // Running on Android 14 or later
                        if (permissionResults.isPartialAccess ?? false) {
                          // User has partially granted permissions
                          // Handle this case to let the user add more media
                          // You can request permissions again to pop up the media selection sheet
                          // For better user experience, add a separate button if the user has granted partial access
                        } else {
                          // Full permission granted
                        }
                      }
                    }
                  },
                  child: const Text('Request Permissions'),
                ),
                OutlinedButton(
                  onPressed: () async {
                    /// Check permission status
                    final Map<Permission, PermissionStatus> permissionResults =
                        await SelectedPhotoAccess.checkPermissionStates();

                    if (permissionResults
                        .containsValue(PermissionStatus.permanentlyDenied)) {
                      /// Permission(s) permanently denied. you have to open app settings to grant permissions.
                      SelectedPhotoAccess.openAppSettings();
                      return;
                    }
                    if (permissionResults
                            .containsKey(Permission.readMediaVideo) ||
                        permissionResults
                            .containsKey(Permission.readMediaImages) ||
                        permissionResults.containsKey(
                            Permission.readMediaVisualUserSelected)) {
                      // Android 14 and later: Determine if the permission is partial or full
                      final isPartial =
                          permissionResults[Permission.readMediaImages] ==
                                  PermissionStatus.denied &&
                              permissionResults[Permission.readMediaVideo] ==
                                  PermissionStatus.denied &&
                              permissionResults[
                                      Permission.readMediaVisualUserSelected] ==
                                  PermissionStatus.granted;

                      /// Handle the rest...
                      if (!isPartial) {
                        ///...
                      } else {
                        ///...
                      }
                    } else {
                      /// Android 13 or lower
                    }
                  },
                  child: const Text('Check Permissions'),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

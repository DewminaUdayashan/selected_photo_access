import 'package:selected_photo_access/permission.dart';
import 'package:selected_photo_access/permission_status.dart';

extension PermissionResultExtension on Map<Permission, PermissionStatus> {
  bool? get isPartialAccess {
    if (containsKey(Permission.readMediaVideo) ||
        containsKey(Permission.readMediaImages) ||
        containsKey(Permission.readMediaVisualUserSelected)) {
      return (this[Permission.readMediaImages] == PermissionStatus.denied ||
              this[Permission.readMediaImages] ==
                  PermissionStatus.permanentlyDenied) &&
          (this[Permission.readMediaVideo] == PermissionStatus.denied ||
              this[Permission.readMediaVideo] ==
                  PermissionStatus.permanentlyDenied) &&
          this[Permission.readMediaVisualUserSelected] ==
              PermissionStatus.granted;
    } else {
      return null;
    }
  }

  bool get isAllGranted {
    return !containsValue(PermissionStatus.permanentlyDenied) &&
        !containsValue(PermissionStatus.denied);
  }
}

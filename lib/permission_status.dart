enum PermissionStatus {
  granted,
  denied,
  permanentlyDenied;

  static parseStates(int value) {
    switch (value) {
      case 0:
        return PermissionStatus.granted;
      case -1:
        return PermissionStatus.denied;
      case -2:
        return PermissionStatus.permanentlyDenied;
      default:
        throw ArgumentError('Invalid permission value: $value');
    }
  }
}

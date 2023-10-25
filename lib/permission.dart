enum Permission {
  readMediaImages('android.permission.READ_MEDIA_IMAGES'),
  readMediaVideo('android.permission.READ_MEDIA_VIDEO'),
  readMediaAudio('android.permission.READ_MEDIA_AUDIO'),
  readMediaVisualUserSelected(
      'android.permission.READ_MEDIA_VISUAL_USER_SELECTED'),
  readExternalStorage('android.permission.READ_EXTERNAL_STORAGE');

  static Permission parsePermission(String value) {
    switch (value) {
      case 'android.permission.READ_MEDIA_IMAGES':
        return Permission.readMediaImages;
      case 'android.permission.READ_MEDIA_VIDEO':
        return Permission.readMediaVideo;
      case 'android.permission.READ_MEDIA_AUDIO':
        return Permission.readMediaAudio;
      case 'android.permission.READ_MEDIA_VISUAL_USER_SELECTED':
        return Permission.readMediaVisualUserSelected;
      case 'android.permission.READ_EXTERNAL_STORAGE':
        return Permission.readExternalStorage;
      default:
        throw ArgumentError('Invalid permission value: $value');
    }
  }

  const Permission(this.value);

  final String value;
}

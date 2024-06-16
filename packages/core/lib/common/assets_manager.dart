class AssetsManager {
  static const _iconBasePath = "assets/icons";
  static const _imageBasePath = "assets/images";

  static const logoImage = "$_imageBasePath/logo.png";
  static const googleLogin = "$_imageBasePath/continue_with_google.png";

  static String getIcon(String iconPath) {
    return "$_iconBasePath/$iconPath";
  }
}

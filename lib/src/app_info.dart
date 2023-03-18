class AppInfo {
  final String appName;
  final String appVersion;
  final String platform;
  final String environment;
  String? appLanguage;
  String? preferredAndroidMarket;
  String? otherAndroidMarketUrl;
  String? preferredIosStore;
  String? otherIosStoreUrl;

  AppInfo({
    required this.appName,
    required this.appVersion,
    required this.platform,
    required this.environment,
    this.appLanguage,
    this.preferredAndroidMarket,
    this.otherAndroidMarketUrl,
    this.preferredIosStore,
    this.otherIosStoreUrl,
  });
}
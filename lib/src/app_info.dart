class AppInfo {
  final String appName;
  final String appVersion;
  final String platform;
  final String environment;
  String? appLanguage;

  AppInfo({
    required this.appName,
    required this.appVersion,
    required this.platform,
    required this.environment,
    this.appLanguage,
  });
}
class VersionCheck {
  final bool found;
  final bool forceUpgrade;
  final String message;

  const VersionCheck({
    required this.found,
    required this.forceUpgrade,
    required this.message,
  });

  factory VersionCheck.fromJson(Map<String, dynamic> json) {
    return VersionCheck(
      found: json['found'],
      forceUpgrade: json['forceUpgrade'],
      message: json['message'],
    );
  }
}
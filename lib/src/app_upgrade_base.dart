import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'app_upgrade.dart';
import 'app_info.dart';
import 'dialog_config.dart';

class AppUpgradeBase extends StatefulWidget {
  final String xApiKey;
  final AppInfo appInfo;
  final DialogConfig? dialogConfig;
  final bool? debug;

  AppUpgradeBase({
    Key? key,
    required this.xApiKey,
    required this.appInfo,
    this.dialogConfig,
    this.debug,
  }) : super(key: key) {

    AppUpgrade().xApiKey = xApiKey;
    AppUpgrade().appInfo = appInfo;
    if (dialogConfig != null) {
      AppUpgrade().dialogConfig = dialogConfig!;
    }

    if (debug != null) {
      AppUpgrade().debug = debug!;
    }
  }

  Widget? build(BuildContext context, AppUpgradeBaseState state) {
    return null;
  }

  @override
  AppUpgradeBaseState createState() => AppUpgradeBaseState();
}

class AppUpgradeBaseState extends State<AppUpgradeBase> {
  final _initialized = AppUpgrade().initialize();

  Future<bool> get initialized => _initialized;

  @override
  Widget build(BuildContext context) => widget.build(context, this)!;
}

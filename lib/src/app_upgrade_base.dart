import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'app_upgrader.dart';
import 'app_info.dart';
import 'dialog_config.dart';

class AppUpgradeBase extends StatefulWidget {
  final http.Client? client;
  final String xApiKey;
  final AppInfo appInfo;
  final DialogConfig? dialogConfig;
  final bool? debug;

  AppUpgradeBase({
    Key? key,
    this.client,
    required this.xApiKey,
    required this.appInfo,
    this.dialogConfig,
    this.debug,
  }) : super(key: key) {
    
    if (client != null) {
      AppUpgrader().client = client;
    }

    AppUpgrader().xApiKey = xApiKey;
    AppUpgrader().appInfo = appInfo;
    if (dialogConfig != null) {
      AppUpgrader().dialogConfig = dialogConfig!;
    }

    if (debug != null) {
      AppUpgrader().debug = debug!;
    }
  }

  Widget? build(BuildContext context, AppUpgradeBaseState state) {
    return null;
  }

  @override
  AppUpgradeBaseState createState() => AppUpgradeBaseState();
}

class AppUpgradeBaseState extends State<AppUpgradeBase> {
  final _initialized = AppUpgrader().initialize();

  Future<bool> get initialized => _initialized;

  @override
  Widget build(BuildContext context) => widget.build(context, this)!;
}

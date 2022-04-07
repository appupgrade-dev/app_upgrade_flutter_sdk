import 'package:flutter/material.dart';
import 'app_info.dart';
import 'app_upgrade_base.dart';
import 'app_upgrader.dart';
import 'dialog_config.dart';

class AppUpgradeAlert extends AppUpgradeBase {
  final Widget? child;

  AppUpgradeAlert({
    Key? key,
    this.child,
    required String xApiKey,
    required AppInfo appInfo,
    DialogConfig? dialogConfig,
    bool? debug,
  }) : super(
          key: key,
          xApiKey: xApiKey,
          appInfo: appInfo,
          dialogConfig: dialogConfig,
          debug: debug,
        );

  @override
  Widget build(BuildContext context, AppUpgradeBaseState state) {
    return FutureBuilder(
        future: state.initialized,
        builder: (BuildContext context, AsyncSnapshot<bool> processed) {
          if (processed.connectionState == ConnectionState.done &&
              processed.data != null &&
              processed.data!) {
            AppUpgrader().checkVersion(context: context);
          }
          return child!;
        });
  }
}

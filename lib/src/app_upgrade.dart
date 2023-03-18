import 'dart:async';
import 'package:app_upgrade_flutter_sdk/app_upgrade_flutter_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'app_info.dart';
import 'app_upgrade_api.dart';
import 'dialog_config.dart';
import 'dart:io' show Platform;
import 'preferred_android_market.dart';
import 'package:package_info_plus/package_info_plus.dart';

typedef BoolCallback = bool Function();

class AppUpgrade {
  static AppUpgrade _singleton = AppUpgrade._internal();

  bool _initCalled = false;

  // Required
  String xApiKey = '';
  late AppInfo appInfo;
  DialogConfig dialogConfig = DialogConfig();

  // Defaults
  String defaultDialogTitle = 'Please update';
  String defaultUpdateButtonTitle = 'Update Now';
  String defaultLaterButtonTitle = 'Later';

  bool debug = false;

  factory AppUpgrade() {
    return _singleton;
  }

  AppUpgrade._internal();

  Future<bool> initialize() async {
    if (_initCalled) {
      return true;
    }

    _initCalled = true;

    return true;
  }

  Future<void> checkVersion({required BuildContext context}) async {
    if (debug) {
      print('App Upgrade: Checking for version from App Upgrade');
    }

    final appUpgrade = new AppUpgradeApi();

    var version = await appUpgrade.versionCheck(xApiKey, appInfo);
    if (version == null && debug) {
      print('App Upgrade: API Error, version is set to null');
    }

    if (version != null && debug) {
      print('App Upgrade: API Response');
      print(version);
    }

    if (version != null && version.found == true) {
      if (version.forceUpgrade == true) {
        if (debug) {
          print('App Upgrade: Version force upgrade is required.');
        }
        // show force upgrade dialog
        Future.delayed(const Duration(milliseconds: 0), () {
          _showDialog(
              context: context,
              title: dialogConfig.title ?? defaultDialogTitle,
              message: version.message,
              canDismissDialog: false,
              appInfo: appInfo);
        });
      } else {
        if (debug) {
          print(
              'App Upgrade: Version force upgrade is not required but upgrade is recommended.');
        }
        // show upgrade dialog
        Future.delayed(const Duration(milliseconds: 0), () {
          _showDialog(
              context: context,
              title: dialogConfig.title ?? defaultDialogTitle,
              message: version.message,
              canDismissDialog: true,
              appInfo: appInfo);
        });
      }
    } else {
      // force upgrade not required
      if (debug) {
        print(
            'App Upgrade: Version information not found. No action required.');
      }
    }
  }

  void _showDialog(
      {required BuildContext context,
      required String title,
      required String message,
      required bool canDismissDialog,
      required AppInfo appInfo}) {
    if (debug) {
      print('App Upgrade: Showing Dialog, title: $title');
      print('App Upgrade: Showing Dialog, message: $message');
      print('App Upgrade: Showing Dialog, canDismissDialog: $canDismissDialog');
    }
    showDialog(
      barrierDismissible: canDismissDialog,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => _shouldPopScope(),
          child: dialogConfig.dialogStyle == DialogStyle.material
              ? _alertDialog(title, message, canDismissDialog, context, appInfo)
              : _cupertinoAlertDialog(
                  title, message, canDismissDialog, context, appInfo),
        );
      },
    );
  }

  bool _shouldPopScope() {
    return false;
  }

  AlertDialog _alertDialog(String title, String message, bool canDismissDialog,
      BuildContext context, AppInfo appInfo) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(message),
        ],
      )),
      actions: <Widget>[
        if (canDismissDialog == true)
          TextButton(
              child: Text(
                  dialogConfig.laterButtonTitle ?? defaultLaterButtonTitle),
              onPressed: () => onUserLater(context)),
        TextButton(
            child: Text(
                dialogConfig.updateButtonTitle ?? defaultUpdateButtonTitle),
            onPressed: () => onUserUpdate(context, appInfo)),
      ],
    );
  }

  CupertinoAlertDialog _cupertinoAlertDialog(String title, String message,
      bool canDismissDialog, BuildContext context, AppInfo appInfo) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Column(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(message),
        ],
      ),
      actions: <Widget>[
        if (canDismissDialog == true)
          CupertinoDialogAction(
              child: Text(
                  dialogConfig.laterButtonTitle ?? defaultLaterButtonTitle),
              onPressed: () => onUserLater(context)),
        CupertinoDialogAction(
            isDefaultAction: true,
            child: Text(
                dialogConfig.updateButtonTitle ?? defaultUpdateButtonTitle),
            onPressed: () => onUserUpdate(context, appInfo))
      ],
    );
  }

  void onUserLater(BuildContext context) {
    if (debug) {
      print('App Upgrade: Later button');
    }

    if (dialogConfig.onLaterCallback != null) {
      dialogConfig.onLaterCallback!();
    }
    _pop(context);
  }

  void onUserUpdate(BuildContext context, AppInfo appInfo) async {
    if (debug) {
      print('App Upgrade: Update button');
    }

    try {
      if (dialogConfig.onUpdateCallback != null) {
        dialogConfig.onUpdateCallback!();
      }

      String url = '';
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String appId = packageInfo.packageName;

      if (Platform.isAndroid) {
        if (appInfo.preferredAndroidMarket == PreferredAndroidMarket.google) {
          url = "https://play.google.com/store/apps/details?id=$appId";
        } else if (appInfo.preferredAndroidMarket ==
            PreferredAndroidMarket.huawei) {
          url = "appmarket://details?id=$appId";
        } else if (appInfo.preferredAndroidMarket ==
            PreferredAndroidMarket.amazon) {
          url = "https://www.amazon.com/gp/mas/dl/android?p=$appId";
        } else if (appInfo.preferredAndroidMarket ==
                PreferredAndroidMarket.other &&
            appInfo.otherAndroidMarketUrl != null) {
          url = appInfo.otherAndroidMarketUrl!;
        } else {
          url = "https://play.google.com/store/apps/details?id=$appId";
        }

        try {
          await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
        } catch (e) {
          if (debug) {
            print(
                'App Upgrade Error: Could not open the preferred android market. Defaulting to Google Playstore.');
          }
          await launchUrl(
              Uri.parse('https://play.google.com/store/apps/details?id=$appId'),
              mode: LaunchMode.externalApplication);
        }
      } else if (Platform.isIOS) {
        if (appInfo.preferredIosStore == PreferredIosStore.other && appInfo.otherIosStoreUrl != null) {
          url = appInfo.otherIosStoreUrl!;
        } else {
          url = "https://apps.apple.com/app/id/$appId";
        }
        try {
          await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
        } catch (e) {
          if (debug) {
            print('App Upgrade: launch to store failed: $e');
          }
        }
      }
    } catch (e) {
      if (debug) {
        print('App Upgrade: launch to store failed: $e');
      }
    }
  }

  void _pop(BuildContext context) {
    Navigator.of(context).pop();
  }
}

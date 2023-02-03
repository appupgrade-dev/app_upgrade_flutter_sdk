import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_redirect/store_redirect.dart';
import 'app_info.dart';
import 'app_upgrade_api.dart';
import 'dialog_config.dart';

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
          );
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
          );
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
      required bool canDismissDialog}) {
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
              ? _alertDialog(title, message, canDismissDialog, context)
              : _cupertinoAlertDialog(
                  title, message, canDismissDialog, context),
        );
      },
    );
  }

  bool _shouldPopScope() {
    return false;
  }

  AlertDialog _alertDialog(String title, String message, bool canDismissDialog,
      BuildContext context) {
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
              child: Text(dialogConfig.laterButtonTitle ?? defaultLaterButtonTitle),
              onPressed: () => onUserLater(context)),
        TextButton(
            child: Text(
                dialogConfig.updateButtonTitle ?? defaultUpdateButtonTitle),
            onPressed: () => onUserUpdate(context)),
      ],
    );
  }

  CupertinoAlertDialog _cupertinoAlertDialog(String title, String message,
      bool canDismissDialog, BuildContext context) {
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
            onPressed: () => onUserUpdate(context))
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

  void onUserUpdate(BuildContext context) async {
    if (debug) {
      print('App Upgrade: Update button');
    }

    try {
      if (dialogConfig.onUpdateCallback != null) {
        dialogConfig.onUpdateCallback!();
      }
      StoreRedirect.redirect();
    } catch (e) {
      if (debug) {
        print('App Upgrade: launch to app store failed: $e');
      }
    }
  }

  void _pop(BuildContext context) {
    Navigator.of(context).pop();
  }
}

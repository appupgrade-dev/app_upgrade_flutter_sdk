# App Upgrade: Flutter SDK

Flutter SDK for [App Upgrade](https://appupgrade.dev)

App Upgrade is a service let your users know when to upgrade your apps or force them to upgrade the app.

[![Twitter](https://img.shields.io/twitter/follow/app_upgrade?style=social)](https://twitter.com/app_upgrade)
[![YouTube](https://img.shields.io/youtube/channel/subscribers/UC0ZVJPYHFVuMwEsro4VZKXw?style=social)](https://www.youtube.com/channel/UC0ZVJPYHFVuMwEsro4VZKXw)

Many times we need to force upgrade mobile apps on users' mobile. Having faced this issue multiple times decided to find a better way to tackle this problem. After doing some research on how people are doing this there are so many custom solutions or checking with the play store or AppStore API if there is a new version available. Although this works if we just want to nudge users that there is a new version available. It doesn't solve the problem where we want to make a decision.. whether it's a soft graceful update or we want to force update. So here is this product that will make developers' life easy. We can set custom messages.. see the versions in beautify dashboard, and many exciting features in the roadmap ahead.

App Upgrade is a cross platform solution to getting users to easily update your app.

##### Stores Supported:

| Apple App Store | Google Play Store | Amazon App Store | Huawei AppGallery | Other Android Markets                                                              |
| --------------- | ----------------- | ---------------- | ----------------- | ---------------------------------------------------------------------------------- |
| **✓**           | **✓**             | **✓**            | **✓**             | **✓** If your app market place isn't one of these you can pass your own store URL. |

## Installation

With flutter

```
flutter pub add app_upgrade_flutter_sdk
```

Import the package

```
import 'package:app_upgrade_flutter_sdk/app_upgrade_flutter_sdk.dart';
```

## How to use it.

1. Register on App Upgrade and follow the instructions to create project and get the x-api-key.

2. Wrap the body widget with the `AppUpgradeAlert` widget, provide x-api-key, appInfo of your app and rest will be handled.

```dart
import 'package:flutter/material.dart';
import 'package:app_upgrade_flutter_sdk/app_upgrade_flutter_sdk.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    AppInfo appInfo = AppInfo(
      appId: 'com.android.com' or '1549468967', // Your app id in play store or app store
      appName: 'Wallpaper app', // Your app name
      appVersion: '1.0.0', // Your app version
      platform: 'android', // App Platform, android or ios
      environment: 'production', // Environment in which app is running, production, staging or development etc.
      appLanguage: 'en' // App language ex: en, es etc. Optional.
    );

    return MaterialApp(
      title: 'App Upgrade Flutter Example',
      home: Scaffold(
          appBar: AppBar(
            title: Text('App Upgrade Flutter Example'),
          ),
          body: AppUpgradeAlert(
            xApiKey: 'ZWY0ZDhjYjgtYThmMC00NTg5LWI0NmUtMjM5OWZkNjkzMzQ5', // Your x-api-key
            appInfo: appInfo,
            child: Center(child: Text('Hello World!')),
          )
      ),
    );
  }
}
```

Optionally you can also provide dialog cofiguration such as dialogStyle (material or cupertino). Full details is below.

```
  dialogStyle: DialogStyle.material, // cupertino or material, default is material
  title: 'App update required!', // Title that will be shown in the Diaglog. Default is "App Update Required!"
  updateButtonTitle: 'Update Now', // Update button title. Default is "Update"
  laterButtonTitle: 'Later' // Later button title. Default is "Later"
  onUpdateCallback: () {} //Optional, If the user clicks on the Update button the SDK will call the onUpdateCallback.
  onLaterCallback: () {} //Optional, If the user clicks on the Later button the SDK will call the onLaterCallback.
```

Example with Dialog Config:

```dart
import 'package:flutter/material.dart';
import 'package:app_upgrade_flutter_sdk/app_upgrade_flutter_sdk.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    AppInfo appInfo = AppInfo(
      appId: 'com.android.com' or '1549468967', // Your app id in play store or app store
      appName: 'Wallpaper app',
      appVersion: '1.0.0',
      platform: 'android',
      environment: 'production',
      appLanguage: 'en' // App language ex: en, es etc. Optional.
    );

    DialogConfig dialogConfig = DialogConfig(
      dialogStyle: DialogStyle.material,
      title: 'App update required!',
      updateButtonTitle: 'Update Now',
      laterButtonTitle: 'Later'
      onLaterCallback: () { print("Later callback") }
    );

    return MaterialApp(
      title: 'App Upgrade Flutter Example',
      home: Scaffold(
          appBar: AppBar(
            title: Text('App Upgrade Flutter Example'),
          ),
          body: AppUpgradeAlert(
            xApiKey: 'MmQwMDU3YWEtNmEzOC00NjQ4LThlYWItNWQ4YTI3YzZdfjdkfdkfdg5',
            appInfo: appInfo,
            dialogConfig: dialogConfig,
            child: Center(child: Text('Hello World!')),
          )
      ),
    );
  }
}
```

### Example with store other than app store or play store.

If you want users to redirect to store other than app store or playstore. You can add these additional parameters **preferredAndroidMarket** see the example below.

```dart
import 'package:flutter/material.dart';
import 'package:app_upgrade_flutter_sdk/app_upgrade_flutter_sdk.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    AppInfo appInfo = AppInfo(
      appId: 'com.android.com' or '1549468967', // Your app id in play store or app store
      appName: 'Wallpaper app', // Your app name
      appVersion: '1.0.0', // Your app version
      platform: 'android', // App Platform, android or ios
      environment: 'production', // Environment in which app is running, production, staging or development etc.
      appLanguage: 'en' // App language ex: en, es etc. Optional.
      preferredAndroidMarket: PreferredAndroidMarket.amazon // or PreferredAndroidMarket.huawei or PreferredAndroidMarket.other If not provided default is Google playstore. Optional
    );

    return MaterialApp(
      title: 'App Upgrade Flutter Example',
      home: Scaffold(
          appBar: AppBar(
            title: Text('App Upgrade Flutter Example'),
          ),
          body: AppUpgradeAlert(
            xApiKey: 'ZWY0ZDhjYjgtYThmMC00NTg5LWI0NmUtMjM5OWZkNjkzMzQ5', // Your x-api-key
            appInfo: appInfo,
            child: Center(child: Text('Hello World!')),
          )
      ),
    );
  }
}
```

- preferredAndroidMarket: PreferredAndroidMarket.amazon // or PreferredAndroidMarket.huawei or PreferredAndroidMarket.other If not provided default is Google playstore. If SDK fails to open preferred market place in case marketplace is not available then default Google playstore will be open.

If you want to redirect user to some other android market place you can use the following example:

```
preferredAndroidMarket: PreferredAndroidMarket.other
otherAndroidMarketUrl: 'https://someotherandroidmarket.com/app/id'// Required if preferredAndroidMarket is Other.
```

```dart
import 'package:flutter/material.dart';
import 'package:app_upgrade_flutter_sdk/app_upgrade_flutter_sdk.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    AppInfo appInfo = AppInfo(
      appId: 'com.android.com' or '1549468967', // Your app id in play store or app store
      appName: 'Wallpaper app', // Your app name
      appVersion: '1.0.0', // Your app version
      platform: 'android', // App Platform, android or ios
      environment: 'production', // Environment in which app is running, production, staging or development etc.
      appLanguage: 'en' // App language ex: en, es etc. Optional.
      preferredAndroidMarket: PreferredAndroidMarket.other // or PreferredAndroidMarket.Huawei or PreferredAndroidMarket.Other If not provided default is Google playstore. Optional
      otherAndroidMarketUrl: 'https://someotherandroidmarket.com/app/id'// Required if preferredAndroidMarket is other.
    );

    return MaterialApp(
      title: 'App Upgrade Flutter Example',
      home: Scaffold(
          appBar: AppBar(
            title: Text('App Upgrade Flutter Example'),
          ),
          body: AppUpgradeAlert(
            xApiKey: 'ZWY0ZDhjYjgtYThmMC00NTg5LWI0NmUtMjM5OWZkNjkzMzQ5', // Your x-api-key
            appInfo: appInfo,
            child: Center(child: Text('Hello World!')),
          )
      ),
    );
  }
}
```

For IOS, if you want to redirect user to some other store you can use the following parameters:

- preferredIosStore: PreferredIosStore.other
- otherIosStoreUrl: "https://otheriosstoreurl.com/app/id"// Required if preferredIosStore is Other.

### Note:

1. For opening the app store/playstore the app should be live.
2. It might not be able to open the app store/playstore in simulator. You can try it in physical device.
3. You can find a sample app from here [app_upgrade_flutter_demo_app](https://github.com/appupgrade-dev/app_upgrade_flutter_demo_app)
4. Read detailed blog on how to integrate from here [How to upgrade/force upgrade Flutter app](https://appupgrade.dev/blog/how-to-force-upgrade-flutter-app)

## Screenshot of alert - material

![image](https://raw.githubusercontent.com/appupgrade-dev/app-upgrade-assets/main/images/forceupgrade_flutter_material.png)

## Screenshot of Cupertino alert

![image](https://raw.githubusercontent.com/appupgrade-dev/app-upgrade-assets/main/images/forceupgrade_flutter_cupertino.png)

## Force upgrade screenshot Example

Only update button is enable. User cannot skip it.

![image](https://raw.githubusercontent.com/appupgrade-dev/app-upgrade-assets/main/images/forceupgrade_flutter_.png)

### Debugging

You can provide debug true to enable debug logs

```dart
import 'package:flutter/material.dart';
import 'package:upgrader/upgrader.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    AppInfo appInfo = AppInfo(
      appId: 'com.android.com' or '1549468967', // Your app id in play store or app store
      appName: 'Wallpaper app', // Your app name
      appVersion: '1.0.0', // Your app version
      platform: 'android', // App Platform, android or ios
      environment: 'production', // Environment in which app is running, production, staging or development etc.
      appLanguage: 'en' // App language ex: en, es etc. Optional.
    );

    return MaterialApp(
      title: 'App Upgrade Flutter Example',
      home: Scaffold(
          appBar: AppBar(
            title: Text('App Upgrade Flutter Example'),
          ),
          body: AppUpgradeAlert(
            xApiKey: 'MmQwMDU3YWEtNmEzOC00NjQ4LThlYWItNWQ4YTI3YzZdfjdkfdkfdg5', // Your x-api-key
            appInfo: appInfo,
            debug: true, // You can specify debug true to print debug logs
            child: Center(child: Text('Hello World!')),
          )
      ),
    );
  }
}
```

## App Upgrade

For more information visit [App Upgrade](https://appupgrade.dev)

### Changelog

Please see [CHANGELOG](CHANGELOG.md) for more information what has changed recently.

### Contributing

Please see [CONTRIBUTING](CONTRIBUTING.md) and [CODE OF CONDUCT](CODE_OF_CONDUCT.md) for details.

### License

The MIT License (MIT). Please see [License File](LICENSE) for more information.

## Need help?

If you're looking for help, try our [Documentation](https://appupgrade.dev/docs/) or our [FAQ](https://appupgrade.dev/docs/app-upgrade-faq).
If you need support please write to us at support@appupgrade.dev

### Happy Coding!!!

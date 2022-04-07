# App Upgrade: Flutter SDK

Flutter SDK for [App Upgrade](https://appupgrade.dev)

App Upgrade is a service let your users know when to upgrade your apps or force them to upgrade the app.

[![Twitter](https://img.shields.io/twitter/follow/app_upgrade?style=social)](https://twitter.com/app_upgrade)
[![YouTube](https://img.shields.io/youtube/channel/subscribers/UC0ZVJPYHFVuMwEsro4VZKXw?style=social)](https://www.youtube.com/channel/UC0ZVJPYHFVuMwEsro4VZKXw)

Many times we need to force upgrade mobile apps on users' mobile. Having faced this issue multiple times decided to find a better way to tackle this problem. After doing some research on how people are doing this there are so many custom solutions or checking with the play store or AppStore API if there is a new version available. Although this works if we just want to nudge users that there is a new version available. It doesn't solve the problem where we want to make a decision.. whether it's a soft graceful update or we want to force update. So here is this product that will make developers' life easy. We can set custom messages.. see the versions in beautify dashboard, and many exciting features in the roadmap ahead.

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
import 'package:upgrader/upgrader.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
    AppInfo appInfo = AppInfo(
      appName: 'Wallpaper app', // Your app name
      appVersion: '1.0.0', // Your app version
      platform: 'android', // App Platform, android or ios
      environment: 'production', // Environment in which app is running, production, staging or development etc.
    );
    
    return MaterialApp(
      title: 'Upgrader Example',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Upgrader Example'),
          ),
          body: AppUpgradeAlert(
            xApiKey: 'MmQwMDU3YWEtNmEzOC00NjQ4LThlYWItNWQ4YTI3YzZdfjdkfdkfdg5', // Your x-api-key
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
```

Example with Dialog Config:
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
      appName: 'Wallpaper app',
      appVersion: '1.0.0',
      platform: 'android',
      environment: 'production',
    );
    
    DialogConfig dialogConfig = DialogConfig(
      dialogStyle: DialogStyle.material,
      title: 'App update required!',
      updateButtonTitle: 'Update Now',
      laterButtonTitle: 'Later'
    );
    
    return MaterialApp(
      title: 'Upgrader Example',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Upgrader Example'),
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

## Screenshot of alert - material

![image](https://raw.githubusercontent.com/appupgrade-dev/app_upgrade_flutter_sdk/main/screenshots/material.png)

## Screenshot of Cupertino alert

![image](https://raw.githubusercontent.com/appupgrade-dev/app_upgrade_flutter_sdk/main/screenshots/cupertino.png)

## Force upgrade screenshot Example
Only update button is enable. User cannot skip it.

![image](https://raw.githubusercontent.com/appupgrade-dev/app_upgrade_flutter_sdk/main/screenshots/forceupgrade.png)

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
      appName: 'Wallpaper app', // Your app name
      appVersion: '1.0.0', // Your app version
      platform: 'android', // App Platform, android or ios
      environment: 'production', // Environment in which app is running, production, staging or development etc.
    );
    
    return MaterialApp(
      title: 'Upgrader Example',
      home: Scaffold(
          appBar: AppBar(
            title: Text('Upgrader Example'),
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

## App Upgrade Docs
For more information visit [App Upgrade](https://appupgrade.dev)

### Changelog

Please see [CHANGELOG](CHANGELOG.md) for more information what has changed recently.

### Contributing

Please see [CONTRIBUTING](CONTRIBUTING.md) and [CODE OF CONDUCT](CODE_OF_CONDUCT.md) for details.

### License

The MIT License (MIT). Please see [License File](LICENSE) for more information.

### Happy Coding!!!

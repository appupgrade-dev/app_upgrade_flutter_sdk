import 'dart:io';

import 'package:flutter/material.dart';
import 'package:app_upgrade_flutter_sdk/app_upgrade_flutter_sdk.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    AppInfo appInfo = AppInfo(
        appId: 'com.example.app',
        appName: 'Wallpaper app',
        appVersion: '1.0.0',
        platform: 'android',
        environment: 'production',
        appLanguage: 'es',
        // preferredAndroidMarket: PreferredAndroidMarket.huawei, // or PrefferedAndroidMarket.huawei or PrefferedAndroidMarket.other If not provided default android marketplace is Google playstore. Optional
        // otherAndroidMarketUrl: 'https://otherandroidmarketplaceurl.com/app/id', // Required only if PreferredAndroidMarket is other.
        // preferredIosStore: PreferredIosStore.other,
        // otherIosStoreUrl: "https://otheriosstoreurl.com/app/id"
    );

    // This is Optional.
    DialogConfig dialogConfig = DialogConfig(
        dialogStyle: DialogStyle.material, //Optional
        title: 'App update required!', //Optional
        updateButtonTitle: 'Update Now', //Optional
        laterButtonTitle: 'Later', //Optional
        onUpdateCallback: () {
          print('Update Callback');
        }, //Optional
        onLaterCallback: () {
          print('Later Callback');
        } //Optional
        );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: AppUpgradeAlert(
        xApiKey: 'ZWY0ZDhjYjgtYThmMC00NTg5LWI0NmUtMjM5OWZkNjkzMzQ5',
        appInfo: appInfo,
        dialogConfig: dialogConfig,
        debug: true,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

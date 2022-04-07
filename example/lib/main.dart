import 'dart:io';

import 'package:flutter/material.dart';
import 'package:app_upgrade_flutter_sdk/app_upgrade.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
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
      appName: 'Wallpaper app',
      appVersion: '1.0.0',
      platform: 'android',
      environment: 'production',
    );

    // This is Optional.
    DialogConfig dialogConfig = DialogConfig(
        dialogStyle: DialogStyle.cupertino,
        title: 'App update required!',
        updateButtonTitle: 'Update Now',
        laterButtonTitle: 'Later'
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: AppUpgradeAlert(
        xApiKey: 'MmQwMDU3YWEtNmEzOC00NjQ4LThlYWItNWQ4YTI3YzZjNDg5',
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

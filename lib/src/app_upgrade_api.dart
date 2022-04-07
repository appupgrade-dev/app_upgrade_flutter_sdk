import 'dart:convert';
import 'package:http/http.dart' as http;
import './models/version-check.dart';

class AppUpgradeApi {
  /// App Upgrade API URL
  final String appUpgradeBaseURL = 'https://appupgrade.dev';

  http.Client? client = http.Client();

  bool debug = false;

  Future<VersionCheck?> versionCheck(xApiKey, params) async {
    try {
      var appName = params.appName;
      var appVersion = params.appVersion;
      var platform = params.platform;
      var environment = params.environment;
      
      final response = await client!.get(
        Uri.parse(
            '${appUpgradeBaseURL}/api/v1/versions/check?app_name=${appName}&app_version=${appVersion}&platform=${platform}&environment=${environment}'),
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "x-api-key": xApiKey
        },
      );
      if (response.statusCode == 200) {
        var versionData = VersionCheck.fromJson(jsonDecode(response.body));
        return versionData;
      } else {
        if (debug) {
          print(json.decode(response.body)['message']);
        }
        return null;
      }
    } catch (e) {
      if (debug) {
        print(e);
      }
      return null;
    }
  }
}

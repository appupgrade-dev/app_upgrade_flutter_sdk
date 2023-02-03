import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/retry.dart';
import './models/version-check.dart';

class AppUpgradeApi {
  /// App Upgrade API URL
  final String appUpgradeBaseURL = 'appupgrade.dev';

  final http.Client? client = RetryClient(http.Client());

  bool debug = false;

  Future<VersionCheck?> versionCheck(xApiKey, params) async {
    try {
      final queryParameters = {
        'app_name': params.appName,
        'app_version': params.appVersion,
        'platform': params.platform,
        'environment': params.environment,
        'app_language': params.appLanguage
      };
      
      final response = await client!.get(
        Uri.https(appUpgradeBaseURL, '/api/v1/versions/check', queryParameters),
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "x-api-key": xApiKey,
          "sdk": "flutter" //Telemetry purposes
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

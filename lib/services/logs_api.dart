import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/log.dart';
import 'package:http/http.dart' as http;

import 'logs_access_token.dart';

class LogsApi {
  /// Object with method to fetch logs from the server
  static Future<List<Log>> fetchLogs(String dateFrom, String dateTo) async {
    /// Method to fetch logs

    // Read access token from storage
    const storage = FlutterSecureStorage();
    String accessToken = await getAccessTokenFromMemory(storage);
    const url =
        'https://myhoursdevelopment-api.azurewebsites.net/api/logs/getallbetweendates';
    final uri = Uri.parse(url);
    final headers = {
      'Authorization': 'Bearer $accessToken',
    };
    final params = {
      'dateFrom': dateFrom,
      'dateTo': dateTo,
    };
    final response =
        await http.get(uri.replace(queryParameters: params), headers: headers);
    final body = response.body;
    final json = jsonDecode(body);
    // Save json as a List
    final results = json as List<dynamic>;
    // Use the factory constructor to create a list of Log objects
    final logs = results.map((e) {
      return Log.fromJson(e);
    }).toList();
    return logs;
  }
}

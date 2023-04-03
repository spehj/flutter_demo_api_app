import 'dart:convert';
import 'package:flutter_demo_api_app/auth/secrets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Methods to get the access token from server and save it to secure storage
Future<String> initAccessToken() async {
  /// Function to get access token from secure storage or server

  // Init flutter secure storage
  const storage = FlutterSecureStorage();
  try {
    // Try to read token from memory (secure storage)
    String accessToken = await getAccessTokenFromMemory(storage);

    if (accessToken != '') {
      // Got access token from memory
      return accessToken;
    }
  } catch (e) {
    print('Error reading bearer token from storage: $e');
  }
  // If no token in storage get one from server
  final accessToken = await getAccessToken();

  try {
    // Save access token to secure storage
    await saveAccessToken(accessToken, storage);
    print('Bearer token saved: $accessToken');
  } catch (e) {
    print('Error saving bearer token: $e');
  }
  return accessToken;
}

Future<String> getAccessToken() async {
  /// Get access token from server
  /// Use headers with data from secrets (.env) file


  final apiUrl = Uri.parse(
      'https://myhoursdevelopment-api.azurewebsites.net/api/tokens/login');
  // Add headers
  final body = jsonEncode({
    "grantType": Secrets.grantType,
    "email": Secrets.email,
    "password": Secrets.password,
    "clientId": Secrets.clientId
  });

  // Wait for response with token
  final response = await http
      .post(apiUrl, body: body, headers: {'Content-Type': 'application/json'});
  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    // read access token value
    final bearerToken = jsonResponse['accessToken'];
    return bearerToken;
  } else {
    throw Exception('Failed to get bearer token');
  }
}

Future<void> saveAccessToken(String token, FlutterSecureStorage storage) async {
  /// Save access token to secure storage
  await storage.write(key: 'bearer_token', value: token);
}

Future<String> getAccessTokenFromMemory(FlutterSecureStorage storage) async {
  /// Get access token from the memory if possible
  final token = await storage.read(key: 'bearer_token');
  if (token == null) {
    // Return a default value or throw an error
    return '';
  }
  return token;
}

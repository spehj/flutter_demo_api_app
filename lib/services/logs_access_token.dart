import 'dart:convert';
import 'package:flutter_demo_api_app/auth/secrets.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<String> initAccessToken() async {
  const storage = FlutterSecureStorage();
  try {
    String accessToken = await getAccessTokenFromMemory(storage);

    if (accessToken != '') {
      // print("Got access token from memory: $accessToken");
      return accessToken;
    }
  } catch (e) {
    print('Error reading bearer token from storage: $e');
  }
  // If no token in storage
  final accessToken = await getAccessToken();
  // print("Got access token from server: $accessToken");
  try {
    await saveAccessToken(accessToken, storage);
    print('Bearer token saved: $accessToken');
  } catch (e) {
    print('Error saving bearer token: $e');
  }
  return accessToken;
}

Future<String> getAccessToken() async {
  final apiUrl = Uri.parse(
      'https://myhoursdevelopment-api.azurewebsites.net/api/tokens/login');
  final body = jsonEncode({
    "grantType": Secrets.grantType,
    "email": Secrets.email,
    "password": Secrets.password,
    "clientId": Secrets.clientId
  });

  final response = await http
      .post(apiUrl, body: body, headers: {'Content-Type': 'application/json'});
  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    final bearerToken = jsonResponse['accessToken'];
    return bearerToken;
  } else {
    throw Exception('Failed to get bearer token');
  }
}

Future<void> saveAccessToken(String token, FlutterSecureStorage storage) async {
  await storage.write(key: 'bearer_token', value: token);
}

Future<String> getAccessTokenFromMemory(FlutterSecureStorage storage) async {
  final token = await storage.read(key: 'bearer_token');
  if (token == null) {
    // Return a default value or throw an error
    return '';
  }
  return token;
}

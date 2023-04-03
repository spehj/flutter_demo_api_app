import 'package:flutter_dotenv/flutter_dotenv.dart';

class Secrets{
  /// Read secrets from .env file for authorization
  static String grantType = dotenv.env['GRANT_TYPE'] ?? "no grant type";
  static String email = dotenv.env['EMAIL'] ?? "no email";
  static String password = dotenv.env['PASSWORD'] ?? "no password";
  static String clientId = dotenv.env['CLIENT_ID'] ?? "no client id";
}
import 'package:webauthn_flutter/webauthn_flutter_web.dart';

abstract class WebauthnFlutterPlatform {
  static WebauthnFlutterPlatform instance = WebauthnFlutterWeb();

  Future<Map<String, dynamic>> authenticate();
}


import 'webauthn_flutter_platform_interface.dart';

class WebauthnFlutter {
  /// Calls the platform-specific authenticate method
  static Future<Map<String, dynamic>> authenticate() {
    return WebauthnFlutterPlatform.instance.authenticate();
  }
}
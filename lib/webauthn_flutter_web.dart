// import 'dart:convert';
// import 'dart:js_util' as js_util;
//
// import 'package:flutter_web_plugins/flutter_web_plugins.dart';
//
// import 'webauthn_flutter_platform_interface.dart';
//
// class WebauthnFlutterWeb extends WebauthnFlutterPlatform {
//   static void registerWith(Registrar registrar) {
//     WebauthnFlutterPlatform.instance = WebauthnFlutterWeb();
//   }
//
//   @override
//   Future<Map<String, dynamic>> authenticate() async {
//     try {
//       if (!js_util.hasProperty(js_util.globalThis, 'authenticate')) {
//         print("🔍 js_util.globalThis.authenticate is null at ${DateTime.now()}");
//       }
//       final jsPromise = js_util.callMethod(js_util.globalThis, 'authenticate', []);
//       print("jsPromise: $jsPromise");
//       final result = await js_util.promiseToFuture(jsPromise);
//       print("result: $result");
//       final parsed = jsonDecode(result as String) as Map<String, dynamic>;
//       print("parsed: $parsed");
//       return parsed;
//     } catch (e) {
//       print("❌ Failed to authenticate: $e");
//       return {
//         'success': false,
//         'message': '❌ Failed to authenticate: $e',
//       };
//     }
//   }
// }

import 'dart:convert';
import 'dart:js' as js;
import 'dart:js_util' as js_util;

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'webauthn_flutter_platform_interface.dart';
import 'const/webauthn_authenticate.dart'; // ✅ Import the JS code string

class WebauthnFlutterWeb extends WebauthnFlutterPlatform {
  static void registerWith(Registrar registrar) {
    // ✅ Inject the JS code when plugin registers
    js.context.callMethod('eval', [webauthnAuthenticateJsCode]);

    WebauthnFlutterPlatform.instance = WebauthnFlutterWeb();
  }

  @override
  Future<Map<String, dynamic>> authenticate() async {
    try {
      if (!js_util.hasProperty(js_util.globalThis, 'authenticate')) {
        print("🔍 js_util.globalThis.authenticate is null at ${DateTime.now()}");
      }
      final jsPromise = js_util.callMethod(js_util.globalThis, 'authenticate', []);
      final result = await js_util.promiseToFuture(jsPromise);
      final parsed = jsonDecode(result as String) as Map<String, dynamic>;
      return parsed;
    } catch (e) {
      print("❌ Failed to authenticate: $e");
      return {
        'success': false,
        'message': '❌ Failed to authenticate: $e',
      };
    }
  }
}


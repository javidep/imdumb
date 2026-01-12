import 'package:flutter/material.dart';
import 'package:imdumb/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:imdumb/core/firebase/remote_config_service.dart';
import 'firebase_options.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await RemoteConfigService().init();
  await di.init();
  runApp(const App());
}

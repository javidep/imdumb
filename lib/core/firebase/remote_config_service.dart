import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  static final RemoteConfigService _instance =
  RemoteConfigService._internal();

  factory RemoteConfigService() => _instance;

  RemoteConfigService._internal();

  final FirebaseRemoteConfig _remoteConfig =
      FirebaseRemoteConfig.instance;

  Future<void> init() async {
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );

    await _remoteConfig.setDefaults({
      'splash_text': 'Cargando...',
      'splash_min_time_ms': 1500,
    });

    await _remoteConfig.fetchAndActivate();
  }

  String get splashText =>
      _remoteConfig.getString('splash_text');

  int get splashMinTime =>
      _remoteConfig.getInt('splash_min_time_ms');
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:imdumb/core/firebase/remote_config_service.dart';
import 'package:imdumb/features/movies/presentation/pages/category_list.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final RemoteConfigService _remoteConfig;

  @override
  void initState() {
    super.initState();
    _remoteConfig = RemoteConfigService();
    _goNext();
  }

  Future<void> _goNext() async {
    await Future.delayed(
      Duration(milliseconds: _remoteConfig.splashMinTime),
    );

    if (!mounted) return;

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const CategoryList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(color: Colors.white),
            const SizedBox(height: 24),
            Text(
              _remoteConfig.splashText,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}


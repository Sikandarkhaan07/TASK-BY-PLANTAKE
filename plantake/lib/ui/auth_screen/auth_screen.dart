// ignore_for_file: use_build_context_synchronously

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:plantake/ui/auth_screen/auth_controller.dart';
import 'package:plantake/ui/home_screen/home_screen.dart';

class AuthScreen extends StatefulWidget {
  final FirebaseAnalytics? analytics;
  final FirebaseAnalyticsObserver? observer;
  const AuthScreen(
      {super.key, required this.analytics, required this.observer});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: SizedBox(
            height: 60,
            width: AuthController.btnWidth,
            child: ElevatedButton.icon(
              onPressed: () {
                AuthController.signInWithGoogle().then((userData) async {
                  await widget.analytics!.setUserId(id: userData.user!.uid);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HomeScreen(),
                    ),
                  );
                });
              },
              icon: const Icon(Icons.account_box_outlined),
              label: const Text('Login with Google'),
            ),
          ),
        ),
      ),
    );
  }
}

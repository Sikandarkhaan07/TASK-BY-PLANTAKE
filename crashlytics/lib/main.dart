import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //this will immediately crash the app and show log in dashboard
    // FirebaseCrashlytics.instance.crash();

    //further you can check docs to explore more about it
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CrashLytics',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    FirebaseCrashlytics.instance.crash;
    return Scaffold(
      appBar: AppBar(
        title: const Text('CrashLytic'),
      ),
      body: ElevatedButton(
        onPressed: () {},
        child: const Text('Start'),
      ),
    );
  }
}

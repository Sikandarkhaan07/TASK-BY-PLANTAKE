import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final remoteConfig = FirebaseRemoteConfig.instance;
  bool? showAds;
  String? adld;

  void setRemoteSetting() async {
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(seconds: 0),
      ),
    );
    getData();
  }

  void getData() async {
    await remoteConfig.fetchAndActivate().then((value) {
      showAds = remoteConfig.getBool('showAds');
      adld = remoteConfig.getString('adld');
      setState(() {});
      log('Resp: $value \n ShowAds: $showAds \n adld: $adld');
    });
  }

  @override
  void initState() {
    setRemoteSetting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Remote Config'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'ShowAds: $showAds',
            style: const TextStyle(fontSize: 25),
          ),
          Text(
            'adld: $adld',
            style: const TextStyle(fontSize: 25),
          ),
        ],
      ),
    );
  }
}

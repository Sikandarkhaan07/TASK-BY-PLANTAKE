import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:mediaplayer/mediaplayer/media_player_screen.dart';

import 'homescreen.dart';

Future<void> main() async {
  //initialising music control in nav bar
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Media player',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MediaPlayerScreen(),
    );
  }
}

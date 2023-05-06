import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'notify.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AudioPlayer player;

  void getSong() {
    try {
      player.setAudioSource(
        AudioSource.asset('assets/m1.mp3'),
      );
      player.play();
    } on Exception {
      log('Error occur while playing');
    }
  }

  @override
  void initState() {
    super.initState();
    player = AudioPlayer()..setAsset('assets/m1.mp3');
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Control(player: player),
          TextButton(
            onPressed: () {
              // Notify.createNotification();
            },
            child: const Text('Get Notify'),
          ),
          TextButton(
            onPressed: () {
              getSong();
            },
            child: const Text('Play song'),
          ),
        ],
      ),
    );
  }
}

class Control extends StatelessWidget {
  const Control({super.key, required this.player});
  final AudioPlayer player;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlayerState>(
        stream: player.playerStateStream,
        builder: (context, snapshot) {
          final playerState = snapshot.data;
          final processingState = playerState?.processingState;
          final playing = playerState?.playing;
          if (!(playing ?? false)) {
            return IconButton(
              onPressed: player.play,
              iconSize: 80,
              icon: const Icon(Icons.play_arrow),
            );
          } else if (processingState != ProcessingState.completed) {
            return IconButton(
              onPressed: player.pause,
              iconSize: 80,
              icon: const Icon(Icons.pause_circle_rounded),
            );
          }
          return IconButton(
            onPressed: () {},
            iconSize: 80,
            icon: const Icon(Icons.pause_circle_rounded),
          );
        });
  }
}

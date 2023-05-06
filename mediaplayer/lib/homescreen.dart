import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //audio player object
  final AudioPlayer player = AudioPlayer();

  //method for setting audio and playing it
  void playAudio() {
    player.setAudioSource(AudioSource.asset(
      'assets/m1.mp3',
      tag: const MediaItem(
        id: '1',
        displaySubtitle: 'Playing Music',
        title: 'Media',
        displayTitle: 'Pranayam - Breathing Exercise',
      ),
    ));
    player.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Media Player'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {
            //play music
            playAudio();
          },
          child: const Text('PLAY'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //pause music
          player.pause();
        },
        child: const Icon(Icons.pause),
      ),
    );
  }
}

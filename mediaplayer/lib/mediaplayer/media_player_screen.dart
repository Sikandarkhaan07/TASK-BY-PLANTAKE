import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class MediaPlayerScreen extends StatefulWidget {
  const MediaPlayerScreen({super.key});

  @override
  State<MediaPlayerScreen> createState() => _MediaPlayerScreenState();
}

class _MediaPlayerScreenState extends State<MediaPlayerScreen> {
  //audio player object
  final AudioPlayer player = AudioPlayer();

  //musics
  final List<String> musics = [
    'assets/m1.mp3',
    'assets/m2.mp3',
    'assets/m3.mp3',
    'assets/m4.mp3',
  ];

  // ignore: prefer_typing_uninitialized_variables
  var name;

  void playAudio() {
    player
      ..setAudioSource(AudioSource.asset(
        name,
        tag: MediaItem(
          id: name,
          displaySubtitle: 'Playing Music',
          title: 'Media',
          displayTitle: 'Pranayam - Breathing Exercise',
        ),
      ))
      //you can set looping option according to your need
      ..play()
      ..setLoopMode(LoopMode.all);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Media Player'),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2)),
            padding: const EdgeInsets.all(10),
            height: MediaQuery.of(context).size.width / 2,
            child: ListView.builder(
              itemCount: musics.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      name = musics[index];
                      playAudio();
                    });
                  },
                  child: Card(
                    elevation: 4,
                    color: Colors.blueAccent,
                    child: ListTile(
                      title: Text(musics[index].substring(7, 9)),
                    ),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              player.pause();
            },
            child: const Text('pause'),
          ),
          Slider(
            value: player.volume,
            onChanged: (value) {
              setState(() {
                player.setVolume(value);
              });
            },
          )
        ],
      ),
    );
  }
}

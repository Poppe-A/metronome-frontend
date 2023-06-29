import 'package:flutter/material.dart';
import 'package:metronome_frontend/models/models.dart';
import 'package:metronome_frontend/homepage.dart';

class App extends StatelessWidget {
  const App({super.key});

static const List<SongModel> songs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Metronome'),
      // ),
      body: const HomePage()
    );
  }
}


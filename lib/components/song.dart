import 'package:flutter/material.dart';

class SongView extends StatelessWidget {
  const SongView({
    super.key,
    required this.name,
    required this.tempo,
  });

  final String name;
  final int tempo;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(name),
        Text(tempo.toString())
      ],
    );
  }
}
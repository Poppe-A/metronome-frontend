import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metronome_frontend/blocs/blinkerCubit/blinkerCubit.dart';

class Blinker extends StatefulWidget {
  final int tempo;
  final List<Widget> children;
  const Blinker({super.key, required this.tempo, required this.children});

  @override
  State<Blinker> createState() => _BlinkerState();
}

class _BlinkerState extends State<Blinker> {
  Color color = Colors.black;
  late Timer mytimer = Timer(const Duration(seconds: 0), () { });

  void _toggleColor() {
    this.setState(() {
      color = color == Colors.black ? Color.fromARGB(255, 188, 17, 5) : Colors.black;
    });
  }

  @override
  initState() {
    super.initState();

    mytimer.cancel();

  //   controller = AnimationController(
  //     duration: const Duration(milliseconds: 500),
  //     vsync: this,
  //   );
  //   final CurvedAnimation curve =
  //       CurvedAnimation(parent: controller, curve: Curves.linear);
  //   animation =
  //       ColorTween(begin: Colors.white, end: Colors.blue).animate(curve);
  //   // Keep the animation going forever once it is started
  //   animation.addStatusListener((status) {
  //     // Reverse the animation after it has been completed
  //     if (status == AnimationStatus.completed) {
  //       controller.repeat();
  //     } else if (status == AnimationStatus.dismissed) {
  //       controller.forward();
  //     }
  //     setState(() {color: Colors.blue;});
  //   });
  //   // Remove this line if you want to start the animation later
  //   // controller.forward();
  }

  @override
  void didUpdateWidget(covariant Blinker oldWidget) {
    super.didUpdateWidget(oldWidget);

    if(mytimer.isActive) mytimer.cancel();
    if (widget.tempo != 0) {
      var duration = (60 / widget.tempo)*1000;
      
      mytimer = Timer.periodic(new Duration(milliseconds: duration.toInt()), (timer) {
        _toggleColor();
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    // _tick = widget._tick;
    return Expanded(
      child: Container(
        color: color,
        child: Column(
          children: widget.children,
        ),
      ),
    );
  }

  @override
  dispose() {
    mytimer.cancel();
    super.dispose();
  }
}
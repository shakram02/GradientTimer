import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer/timer/bloc/timer_bloc.dart';

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(builder: (context, state) {
      final completion = state.remainingTicks / TimerBloc.inititalTicks;
      final endVertical = (completion * 2.0) - 1;

      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0, endVertical),
            end: const Alignment(0, -1),
            colors: [
              Colors.amber.shade50,
              Colors.amberAccent.shade400,
            ],
          ),
        ),
      );
    });
  }
}

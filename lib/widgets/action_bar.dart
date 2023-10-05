import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer/timer/bloc/timer_bloc.dart';

class ActionBar extends StatelessWidget {
  const ActionBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimerBloc, TimerState>(
      buildWhen: (prev, state) {
        // ignore: avoid_print
        print("Runtime:${prev.runtimeType} // ${state.runtimeType}");
        return prev.runtimeType != state.runtimeType;
      },
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ...switch (state) {
              TimerInitial() => [_timerStartButton(context, state)],
              TimerRunProgress() => [
                  _timerPauseButton(context),
                  _timerResetButton(context),
                ],
              TimeRunPaused() => [
                  _timerResumeButton(context),
                  _timerResetButton(context),
                ],
              TimeRunComplete() => [_timerResetButton(context)],
            }
          ],
        );
      },
    );
  }

  FloatingActionButton _timerStartButton(
          BuildContext context, TimerState state) =>
      FloatingActionButton(
        child: const Icon(Icons.play_arrow),
        onPressed: () => context.read<TimerBloc>().add(
              TimerStarted(remainingTicks: state.remainingTicks),
            ),
      );

  FloatingActionButton _timerResumeButton(BuildContext context) =>
      FloatingActionButton(
        child: const Icon(Icons.play_arrow),
        onPressed: () => context.read<TimerBloc>().add(const TimerResumed()),
      );
  FloatingActionButton _timerPauseButton(BuildContext context) =>
      FloatingActionButton(
        child: const Icon(Icons.pause),
        onPressed: () => context.read<TimerBloc>().add(const TimerPaused()),
      );

  FloatingActionButton _timerResetButton(BuildContext context) =>
      FloatingActionButton(
        child: const Icon(Icons.replay),
        onPressed: () => context.read<TimerBloc>().add(const TimerReset()),
      );
}

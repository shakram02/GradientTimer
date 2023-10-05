part of 'timer_bloc.dart';

@immutable
sealed class TimerEvent {
  const TimerEvent();
}

final class TimerStarted extends TimerEvent {
  final int remainingTicks;
  const TimerStarted({required this.remainingTicks});
}

final class TimerPaused extends TimerEvent {
  const TimerPaused();
}

final class TimerResumed extends TimerEvent {
  const TimerResumed();
}

final class TimerReset extends TimerEvent {
  const TimerReset();
}

final class _TimerTicked extends TimerEvent {
  final int remainingTicks;
  const _TimerTicked({required this.remainingTicks});
}

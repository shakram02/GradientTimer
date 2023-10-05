part of 'timer_bloc.dart';

@immutable
sealed class TimerState extends Equatable {
  final int remainingTicks;
  const TimerState(this.remainingTicks);

  @override
  List<Object> get props => [remainingTicks];
}

final class TimerInitial extends TimerState {
  const TimerInitial(super.remainingTicks);
}

final class TimerRunProgress extends TimerState {
  const TimerRunProgress(super.remainingTicks);
}

final class TimeRunPaused extends TimerState {
  const TimeRunPaused(super.remainingTicks);
}

final class TimeRunComplete extends TimerState {
  const TimeRunComplete() : super(0);
}

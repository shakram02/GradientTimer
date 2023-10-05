import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:timer/ticker.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  static const int inititalTicks = 60; // TODO: try to change to 0
  StreamSubscription<int>? _tickerSubscription;
  final Ticker _ticker;

  TimerBloc({required Ticker ticker})
      : _ticker = ticker,
        super(const TimerInitial(inititalTicks)) {
    on<TimerStarted>(_onStarted);
    on<_TimerTicked>(_onTicked);
    on<TimerPaused>(_onPaused);
    on<TimerResumed>(_onResumed);
    on<TimerReset>(_onReset);
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onStarted(TimerStarted event, Emitter<TimerState> emit) async {
    // Emit a new state
    emit(TimerRunProgress(event.remainingTicks));

    _tickerSubscription?.cancel();
    _tickerSubscription =
        _ticker.makeTickStream(maxTicks: event.remainingTicks).listen(
      (remainingTicks) {
        // Tigger an event on bloc
        add(_TimerTicked(remainingTicks: remainingTicks));
      },
    );
  }

  void _onTicked(_TimerTicked event, Emitter<TimerState> emit) {
    emit(
      event.remainingTicks > 0
          ? TimerRunProgress(event.remainingTicks)
          : const TimeRunComplete(),
    );
  }

  void _onPaused(TimerPaused event, Emitter<TimerState> emit) {
    if (state is TimerRunProgress) {
      _tickerSubscription?.pause();
      emit(TimeRunPaused(state.remainingTicks));
    }
  }

  void _onResumed(TimerResumed event, Emitter<TimerState> emit) {
    if (state is TimeRunPaused) {
      _tickerSubscription?.resume();
      emit(TimerRunProgress(state.remainingTicks));
    }
  }

  void _onReset(TimerReset event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    emit(const TimerInitial(inititalTicks));
  }
}

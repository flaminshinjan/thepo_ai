import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'conversation_event.dart';
import 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  final TickerProvider vsync;

  late AnimationController _animationController;

  ConversationBloc(this.vsync) : super(AnimationInitial()) {
    on<StartAnimationEvent>((event, emit) {
      _animationController = AnimationController(
        vsync: vsync,
        duration: const Duration(seconds: 3),
      )..repeat(reverse: true);

      emit(AnimationRunning(_animationController));
    });

    on<StopAnimationEvent>((event, emit) {
      _animationController.stop();
    });
  }

  @override
  Future<void> close() {
    _animationController.dispose();
    return super.close();
  }
}

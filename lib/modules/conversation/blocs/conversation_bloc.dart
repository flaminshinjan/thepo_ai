import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'conversation_event.dart';
import 'conversation_state.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  bool isExpanded = false;

  ConversationBloc() : super(AnimationInitial()) {
    on<ToggleAnimationEvent>((event, emit) {
      isExpanded = !isExpanded;
      emit(AnimationRunning(isExpanded));
    });
    _startContinuousAnimationCycle();
  }
  void _startContinuousAnimationCycle() {
    Future.delayed(const Duration(seconds: 1), () {
      add(ToggleAnimationEvent());
      _startContinuousAnimationCycle();
    });
  }
  @override
  Future<void> close() {
    return super.close();
  }
}

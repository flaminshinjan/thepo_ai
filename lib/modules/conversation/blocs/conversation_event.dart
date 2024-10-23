import 'package:equatable/equatable.dart';

abstract class ConversationEvent extends Equatable {
  const ConversationEvent();

  @override
  List<Object?> get props => [];
}

class StartAnimationEvent extends ConversationEvent {}

class StopAnimationEvent extends ConversationEvent {}

abstract class ConversationState {}

class AnimationInitial extends ConversationState {}

class AnimationRunning extends ConversationState {
  final bool isExpanded;

  AnimationRunning(this.isExpanded);
}

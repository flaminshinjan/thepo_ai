import 'package:flutter/material.dart';

abstract class ConversationState {}

class AnimationInitial extends ConversationState {}

class AnimationRunning extends ConversationState {
  final AnimationController controller;

  AnimationRunning(this.controller);
}

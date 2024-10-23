import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thepo_ai/modules/conversation/blocs/conversation_event.dart';
import 'modules/conversation/views/conversation_view.dart';
import 'modules/conversation/blocs/conversation_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ConversationScreen(),
    );
  }
}

class ConversationScreen extends StatefulWidget {
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConversationBloc(this)..add(StartAnimationEvent()),
      child: ConversationView(),
    );
  }
}

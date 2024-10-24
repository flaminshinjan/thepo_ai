import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'modules/conversation/views/conversation_view.dart';
import 'modules/conversation/blocs/conversation_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Po.ai',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => ConversationBloc(),
        child: ConversationView(),
      ),
    );
  }
}

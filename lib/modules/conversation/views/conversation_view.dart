import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../blocs/conversation_bloc.dart';
import '../blocs/conversation_event.dart';
import '../blocs/conversation_state.dart';

class ConversationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocProvider(
          create: (context) => ConversationBloc(
            context
                .read<TickerProvider>(), // Provide TickerProvider for animation
          )..add(StartAnimationEvent()),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'let’s talk out your problems one at a time.',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                BlocBuilder<ConversationBloc, ConversationState>(
                  builder: (context, state) {
                    if (state is AnimationRunning) {
                      return AnimatedBuilder(
                        animation: state.controller,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: Tween<double>(begin: 0.8, end: 1.0)
                                .animate(CurvedAnimation(
                                    parent: state.controller,
                                    curve: Curves.easeInOut))
                                .value,
                            child: Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Color(0xFFEB8D70),
                                shape: BoxShape.circle,
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return Container(); // Placeholder if animation is not running
                  },
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Color(0xFFEB8D70), // Blob color for the button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 60,
                      vertical: 15,
                    ),
                  ),
                  child: Text(
                    'let\'s chat',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

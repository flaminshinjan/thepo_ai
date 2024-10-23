import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/conversation_bloc.dart';
import '../blocs/conversation_event.dart';
import '../blocs/conversation_state.dart';
import 'package:google_fonts/google_fonts.dart';

class ConversationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<ConversationBloc, ConversationState>(
          builder: (context, state) {
            bool isExpanded = false;

            if (state is AnimationRunning) {
              isExpanded = state.isExpanded;
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween, 
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20.0), // Adjust top padding if needed
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Text(
                          'let’s talk out your problems one at a time.',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 2),
                        width: isExpanded ? 300 : 250,
                        height: isExpanded ? 300 : 250,
                        decoration: BoxDecoration(
                          color: Color(0xFFEB8D70),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 40.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Color(0xFFEB8D70), 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 130,
                          vertical: 20,
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
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

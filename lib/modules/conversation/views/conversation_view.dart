import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:google_fonts/google_fonts.dart';
import '../repositories/conversation_repository.dart';
import '../blocs/conversation_bloc.dart';
import '../blocs/conversation_event.dart';
import '../blocs/conversation_state.dart';

class ConversationView extends StatefulWidget {
  @override
  _ConversationViewState createState() => _ConversationViewState();
}

class _ConversationViewState extends State<ConversationView> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  bool _isLoading = false;
  String _userSpeech = "";
  final ConversationRepository _conversationRepository =
      ConversationRepository();

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _startBlobConversation();
  }

  Future<void> _startBlobConversation() async {
    setState(() {
      _isLoading = true;
    });
    String question = await _conversationRepository
        .generateBlobQuestion("Start the conversation");
    await _conversationRepository.speakBlob(question);
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize();
      if (available) {
        setState(() {
          _isListening = true;
        });
        _speech.listen(onResult: (val) {
          setState(() {
            _userSpeech = val.recognizedWords;
          });
          if (val.hasConfidenceRating && val.confidence > 0) {
            _handleUserResponse(_userSpeech);
          }
        });
      }
    } else {
      setState(() {
        _isListening = false;
      });
      _speech.stop();
    }
  }

  Future<void> _handleUserResponse(String userInput) async {
    setState(() {
      _isLoading = true;
    });
    String blobResponse =
        await _conversationRepository.generateBlobQuestion(userInput);
    await _conversationRepository.speakBlob(blobResponse);
    setState(() {
      _isLoading = false;
    });
  }

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
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
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : _listen, // Disable button when loading
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(
                            0xFFEB8D70), // Button background remains orange
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 130,
                          vertical: 20,
                        ),
                      ),
                      child: _isLoading
                          ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white), // Loader is white
                            )
                          : Text(
                              _isListening ? 'Listening...' : 'Talk to Blob',
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
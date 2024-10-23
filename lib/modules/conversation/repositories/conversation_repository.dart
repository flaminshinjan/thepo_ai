import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:just_audio/just_audio.dart';

class ConversationRepository {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Future<String> generateBlobQuestion(String context) async {
    // OpenAI API to generate questions and answers
    try {
      final response = await http.post(
        Uri.https('api.openai.com', '/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer ', // Replace with actual OpenAI key
        },
        body: jsonEncode({
          'model': 'gpt-4o',
          'messages': [
            {
              'role': 'system',
              'content':
                  'You are a compassionate and friendly mental health professional. Your tone is supportive, non-judgmental, and empathetic, and you provide advice and suggestions in a way that promotes well-being and mental health.'
            },
            {'role': 'user', 'content': context},
          ],
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return responseData['choices'][0]['message']['content'];
      } else {
        print("Error: Failed to fetch question from OpenAI API.");
        print("Response body: ${response.body}");
        return "Sorry, I couldn't process that.";
      }
    } catch (e) {
      print("Exception occurred during OpenAI API call: $e");
      return "Sorry, something went wrong.";
    }
  }

  Future<void> speakBlob(String text) async {
    try {
      // Make the API request to Eleven Labs
      final response = await http.post(
        Uri.https(
            'api.elevenlabs.io', '/v1/text-to-speech/Xb7hH8MSUJpSbSDYk0k2'),
        headers: {
          'Content-Type': 'application/json',
          'xi-api-key': '',
        },
        body: jsonEncode({
          'text': text,
          'voice_settings': {
            'stability': 0.5,
            'similarity_boost': 0.5,
          },
        }),
      );

      if (response.statusCode == 200 &&
          response.headers['content-type']?.contains('audio') == true) {
        final bytes = response.bodyBytes;

        // Get the directory to store the audio file
        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/output.mp3');

        // Write the bytes to a file
        await file.writeAsBytes(bytes);

        // Use just_audio to play the audio file
        await _audioPlayer.setFilePath(file.path);
        await _audioPlayer.play();
      } else {
        print("Error: Failed to fetch valid audio data.");
        print("Response body (error): ${response.body}");
      }
    } catch (e) {
      print("Exception occurred during TTS: $e");
    }
  }
}

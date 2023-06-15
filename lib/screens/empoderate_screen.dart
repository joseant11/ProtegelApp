import 'package:flutter/material.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

class ChatGPT {
  final String apiKey;
  String prompt;
  final int maxTokens;
  final double temperature;
  final List<String> stop;

  ChatGPT({
    required this.apiKey,
    required this.prompt,
    this.maxTokens = 50,
    this.temperature = 0.6,
    this.stop = const ['\n\n'],
  });

  Future<String> generateMessage() async {
    // API call to generate response from ChatGPT goes here
    return "Hello, how can I help?";
  }

  void addMessage(String message) {
    prompt = prompt + '\n' + message;
  }
}

class EmpoderateScreen extends StatefulWidget {
  @override
  _EmpoderateScreenState createState() => _EmpoderateScreenState();
}

class _EmpoderateScreenState extends State<EmpoderateScreen> {
  List<String> tipoAgresion = [
    'Fisica',
    'Sexual',
    'Psicologica',
    'Economica',
    'Digital',
    'Verbal',
  ];

  var chat = ChatGPT(
    apiKey: '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',
    prompt: 'Hola, ¿en qué puedo ayudarte?',
    maxTokens: 50,
    temperature: 0.6,
    stop: ['\n\n'],
  );

  List<String> chatHistory = [];

  TextEditingController _textEditingController = TextEditingController();

  Widget _buildChatWidget() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: chatHistory.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(chatHistory[index]),
              );
            },
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          height: 60,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    hintText: 'Escribe tu mensaje aquí',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  String message = _textEditingController.text.trim();
                  chat.addMessage(message);
                  chat.generateMessage().then((value) {
                    setState(() {
                      chatHistory.add(value);
                    });
                  });
                  _textEditingController.clear();
                },
                child: Text('Enviar'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Empoderate'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Selecciona el tipo de agresion',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tipoAgresion.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tipoAgresion[index]),
                  onTap: () {
                    String message =
                        '${tipoAgresion[index]}: Escribe aquí tu mensaje';
                    chat.addMessage(message);
                    chat.generateMessage().then((value) {
                      setState(() {
                        chatHistory.add(value);
                      });
                    });
                  },
                );
              },
            ),
          ),
          _buildChatWidget(),
        ],
      ),
    );
  }
}

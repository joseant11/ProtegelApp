// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class EmpoderateScreen extends StatefulWidget {
//   @override
//   _EmpoderateScreenState createState() => _EmpoderateScreenState();
// }

// class _EmpoderateScreenState extends State<EmpoderateScreen> {
//   List<Map<String, dynamic>> messages = [];
//   TextEditingController _controller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Chat de Ayuda'),
//         backgroundColor: Color(0xff5C4DB1),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: messages.length,
//               itemBuilder: (BuildContext context, int index) {
//                 bool isUserMessage = messages[index]['isUserMessage'];
//                 return ListTile(
//                   title: Container(
//                     padding: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: isUserMessage
//                           ? Color(0xff5C4DB1)
//                           : Color(0xffDFDEFF),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Text(
//                       messages[index]['message'],
//                       style: TextStyle(
//                         color: isUserMessage ? Colors.white : Colors.black,
//                       ),
//                     ),
//                   ),
//                   leading: isUserMessage ? null : Icon(Icons.assistant),
//                   trailing: isUserMessage ? Icon(Icons.person) : null,
//                 );
//               },
//             ),
//           ),
//           Container(
//             padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//             child: TextField(
//               controller: _controller,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 suffixIcon: IconButton(
//                   onPressed: _sendMessage,
//                   icon: Icon(Icons.send),
//                   color: Color(0xff5C4DB1),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _sendMessage() async {
//     String message = _controller.text;
//     _controller.clear();
//     setState(() {
//       messages.add({'message': message, 'isUserMessage': true});
//     });

//     String url = 'https://api.openai.com/v1/chat/completions';
//     var response = await http.post(
//       Uri.parse(url),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer <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>',
//       },
//       body: json.encode({
//         'prompt': message,
//       }),
//     );

//     if (response.statusCode == 200) {
//       String serverMessage = json.decode(response.body)['choices'][0]['text'];
//       setState(() {
//         messages.add({'message': serverMessage, 'isUserMessage': false});
//       });
//     }
//   }
// }
import "package:flutter/material.dart";
import 'package:flutter_chat_app/screens/message_display.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  IO.Socket? socket;

  void connect() {
    socket = IO.io('http://192.168.43.251:3000', <String, dynamic> {
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket!.onConnect((_) {
      print('Front-end connected.');
      // socket!.emit('msg', 'test');
    });
    socket!.on('event', (data) => print(data));
    socket!.onDisconnect((_) => print('disconnect'));
    socket!.on('fromServer', (_) => print(_));
  }

  @override
  void initState() {
    super.initState();
    connect();
  }
  @override
  void dispose() {
    socket!.disconnect();
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        toolbarHeight: 65,
        shadowColor: Colors.white,
        centerTitle: true,
        backgroundColor: Colors.teal,
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 23,
        ),
        leading: const Icon(
          Icons.menu,
        ),
        title: const Text(
          "Socket IO Chat App",
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...List.generate(
                    1,
                    (index) => const MessageDisplay(sentByMe: false, message: "Hello my name is code karma and I am doing you a favor by letting you live."),
                  ),
                  ...List.generate(
                    1,
                    (index) => const MessageDisplay(sentByMe: true, message: "Well, fear me if you dare."),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 13,
              vertical: 8
            ),
            child: TextFormField(
              style: TextStyle(
                color: Colors.grey[900],
              ),
              controller: _controller,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.teal.shade900
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Colors.teal.shade500,
                  ),
                ),
                icon: GestureDetector(
                  onTap: connect,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.telegram_outlined,
                      color: Colors.teal[700],
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}
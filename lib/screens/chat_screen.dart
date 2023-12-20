import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dingo_new/widgets/chat_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/chat_service.dart';
import '../widgets/text_field.dart';

class ChatPage extends StatefulWidget {
  final String reciverUserEmail;
  final String reciverUserID;
  const ChatPage({
    super.key,
    required this.reciverUserEmail,
    required this.reciverUserID,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;
  void sendMessage() async {
    //only send message if there any
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
        widget.reciverUserID,
        _messageController.text,
      );
      //clear the controller after sending the message
      _messageController.clear();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: Navigator.of(context).pop,
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 000000,
        backgroundColor: Colors.transparent,
        title: Text(widget.reciverUserEmail,
            style: Theme.of(context).textTheme.headlineSmall!),
      ),
      body: Column(children: [
        //messages
        Expanded(child: _buildMessageList()),
        //user input
        _builMessageInput(),
      ]),
    );
  }

//build message list
  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
        widget.reciverUserID,
        _fireBaseAuth.currentUser!.uid,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView(
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

//build message input
  Widget _builMessageInput() {
    return Container(
      margin: const EdgeInsets.only(bottom: 18, top: 5),
      child: Row(
        children: [
          Expanded(
            child: MyTextFormField(
              hintText: 'Message',
              obsc: false,
              controller: _messageController,
            ),
          ),
          IconButton(
            onPressed: sendMessage,
            icon: const Icon(Icons.send_rounded),
          ),
        ],
      ),
    );
  }

  //build message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    // Align the message to the left or right depending on who sent the message
    var alignment = (data['senderId'] == _fireBaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: alignment,
        child: Column(
          crossAxisAlignment:
              (data['senderId'] == _fireBaseAuth.currentUser!.uid)
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
          mainAxisAlignment:
              (data['senderId'] == _fireBaseAuth.currentUser!.uid)
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
          children: [
            //Text(data['senderEmail']),
            ChatBubble(
              message: data['message'],
              clr: (data['senderId'] == _fireBaseAuth.currentUser!.uid)
                  ? Colors.red
                  : const Color.fromARGB(255, 0, 0, 0),
            )
          ],
        ),
      ),
    );
  }
}

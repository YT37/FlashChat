import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat/constants.dart';
import 'package:flutter/material.dart';

late User currentUser;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  String? message;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    try {
      final user = auth.currentUser;
      if (user != null) currentUser = user;
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              auth.signOut();
              Navigator.pop(context);
            },
          ),
        ],
        title: Text("Chat"),
        backgroundColor: kUIAccent,
      ),
      body: Builder(
        builder: (context) => SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MessagesStream(),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: kUIAccent, width: 2),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageTextController,
                        minLines: 1,
                        maxLines: 3,
                        onChanged: (value) => message = value,
                        decoration: InputDecoration(
                          contentPadding: screenSize.symmetric(
                            vertical: 10,
                            horizontal: 20,
                          ),
                          hintText: 'Type your message',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        messageTextController.clear();

                        database.collection("messages").add({
                          "text": message,
                          "sender": currentUser.email!.split("@")[0],
                        });
                      },
                      child: Text(
                        'Send',
                        style: TextStyle(
                          color: kUIAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: screenSize.height(18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: database.collection("messages").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        print(snapshot);

        if (snapshot.hasData) {
          final List<QueryDocumentSnapshot> messages = snapshot.data!.docs;
          List<MessageBubble> messageBubbles = [];

          for (var message in messages) {
            final String messageText = message.data()["text"];
            final String messageSender = message.data()["sender"];

            final String loggedInUser = currentUser.email!;

            final MessageBubble messageBubble = MessageBubble(
              sender: messageSender,
              text: messageText,
              isMe: loggedInUser.split("@")[0] == messageSender,
            );
            messageBubbles.add(messageBubble);
          }

          return Expanded(
            child: ListView(
              reverse: true,
              padding: screenSize.symmetric(horizontal: 10, vertical: 20),
              children: messageBubbles,
            ),
          );
        } else
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  "Loading ...",
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String sender;
  final String text;
  final bool isMe;

  MessageBubble({
    required this.sender,
    required this.text,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: screenSize.all(10),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(
                fontSize: screenSize.height(12), color: Colors.black54),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )
                : BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
            elevation: 5,
            color: isMe ? kUIAccent : Colors.lightGreenAccent,
            child: Padding(
              padding: screenSize.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                text,
                style: TextStyle(
                  color: kUIColor,
                  fontSize: screenSize.height(15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

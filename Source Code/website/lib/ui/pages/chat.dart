import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/config/constants.dart';
import '/services/auth.dart';
import '/ui/widgets/input_field.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with RestorationMixin {
  @override
  String get restorationId => "chat_page";

  late final RxList<Map<String, Object>> fields;

  final RestorableTextEditingController _messageController =
      RestorableTextEditingController();

  @override
  void initState() {
    super.initState();

    fields = [
      {
        "value": "message",
        "name": "Message",
        "controller": _messageController,
        "icon": Icons.message,
        "input": TextInputType.name,
        "submit": (_) => submit(context),
        "error": "",
      },
    ].obs;
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    fields.forEach((field) {
      if (field["controller"] != null) {
        registerForRestoration(
          field["controller"]! as RestorableTextEditingController,
          "${field["value"]}_controller",
        );
      }
    });
  }

  @override
  void dispose() {
    fields.forEach((field) {
      if (field["controller"] != null) {
        (field["controller"]! as RestorableTextEditingController).dispose();
      }
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Tooltip(
          message: "Log Out",
          child: IconButton(
            icon: Icon(
              Icons.power_settings_new,
              color: context.theme.colorScheme.error,
            ),
            onPressed: () async => Auth.logout(),
          ),
        ),
        title: const Text("Chat"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _Messages(),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: context.theme.colorScheme.secondary,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Obx(
                    () => Expanded(
                      child: Column(
                        children: List.generate(
                          fields.length,
                          (index) {
                            final Map<String, dynamic> field = fields[index];

                            return InputField(
                              decoration: InputDecoration(
                                label: Text(field["name"]),
                                prefixIcon: Icon(
                                  field["icon"],
                                  color: context.theme.colorScheme.tertiary,
                                ),
                              ),
                              controller: field["controller"],
                              onSubmitted: field["submit"],
                              textInputType: field["input"],
                              error: field["error"],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () => submit(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void submit(BuildContext context) {
    FocusScope.of(context).unfocus();

    database.collection("messages").add(
      {
        "text": _messageController.value.text.trim(),
        "sender": user.username.split("@")[0],
        "time": Timestamp.now(),
      },
    );

    _messageController.value.clear();
  }
}

class _Messages extends StatelessWidget {
  const _Messages();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: database
          .collection("messages")
          .orderBy("time", descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData ||
            snapshot.data == null ||
            snapshot.data!.docs.isEmpty) {
          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Loading ...",
                    textAlign: TextAlign.center,
                    style: context.textTheme.displaySmall,
                  ),
                ),
              ],
            ),
          );
        }

        final List<QueryDocumentSnapshot> docs = snapshot.data!.docs;
        final List<_Message> messages = [];

        for (final QueryDocumentSnapshot doc in docs) {
          messages.add(
            _Message(
              text: doc.get("text"),
              sender: doc.get("sender"),
              time: doc.get("time"),
              isSelf: user.username.split("@")[0] == doc.get("sender"),
            ),
          );
        }

        return Expanded(
          child: ListView(
            reverse: true,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            children: messages,
          ),
        );
      },
    );
  }
}

class _Message extends StatelessWidget {
  final String text;
  final String sender;
  final Timestamp time;
  final bool isSelf;

  const _Message({
    required this.text,
    required this.sender,
    required this.time,
    required this.isSelf,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:
            isSelf ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: context.textTheme.titleSmall,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: isSelf
                ? BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: context.theme.colorScheme.secondary,
                  )
                : BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: context.theme.colorScheme.tertiary,
                  ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: context.textTheme.displaySmall,
                ),
              ],
            ),
          ),
          Text(
            "${time.toDate().hour > 12 ? time.toDate().hour - 12 : time.toDate().hour}:${time.toDate().minute} ${time.toDate().hour > 12 ? "PM" : "AM"}",
            style: context.textTheme.bodySmall!
                .copyWith(color: Colors.grey.shade800),
          ),
        ],
      ),
    );
  }
}
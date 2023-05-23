import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> _messages = [
    Message(text: 'Hi', isMe: false, dateTime: DateTime.now().subtract(Duration(minutes: 50)), isRead: true),
    Message(text: 'Hello', isMe: true, dateTime: DateTime.now().subtract(Duration(minutes: 40)), isRead: true),
    Message(text: 'How are you?', isMe: false, dateTime: DateTime.now().subtract(Duration(minutes: 30)), isRead: true),
    Message(text: 'All Good', isMe: true, dateTime: DateTime.now().subtract(Duration(minutes: 15)), isRead: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: _buildLeadingButton(),
      centerTitle: true,
      title: _buildTitle(),
    );
  }

  Widget _buildLeadingButton() {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  Widget _buildTitle() {
    return Text(
      'Chat',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }

  Widget _buildBody() {
    return _buildMainContent();
  }

  Widget _buildMainContent() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            child: Opacity(opacity: 0.25, child: Image.asset('assets/images/background/bottomRight.png')),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Opacity(opacity: 0.25, child: Image.asset('assets/images/background/topLeft.png')),
          ),
        ),
        Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 20),
                itemCount: _messages.length,
                itemBuilder: (BuildContext context, int index) {
                  final message = _messages[index];
                  return MessageBubble(
                    message: message,
                    isMe: message.isMe,
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 12,
                    child: SizedBox(
                      height: 50,
                      child: Material(
                        elevation: 2,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Write a message',
                            suffixIcon: IconButton(
                              onPressed: () {
                                // Handle button press
                              },
                              icon: Icon(Icons.image_outlined),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 50,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Color(0xFF16caea),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class Message {
  final String text;
  final bool isMe;
  final DateTime dateTime;
  final bool isRead;

  Message({required this.dateTime, required this.text, required this.isMe, required this.isRead});
}

class MessageBubble extends StatelessWidget {
  final Message message;
  final bool isMe;

  MessageBubble({required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: isMe ? 35.0 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!message.isMe)
                SizedBox(
                  child: CircleAvatar(
                    child: ClipOval(
                      child: Image.asset('assets/images/profilePicture.png'),
                    ),
                    backgroundColor: Colors.grey[300],
                    radius: 22,
                  ),
                  height: 50,
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      decoration: BoxDecoration(
                        color: isMe ? Color(0xFF16caea) : Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0),
                          bottomLeft: Radius.circular(isMe ? 8 : 0),
                          bottomRight: Radius.circular(isMe ? 0 : 8.0),
                        ),
                      ),
                      child: Text(
                        message.text,
                        style: TextStyle(
                          color: isMe ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          if (message.isMe) Expanded(child: Container()),
                          Row(
                            children: [
                              Text(
                                DateFormat('d MMM y hh:mm a').format(message.dateTime),
                                style: TextStyle(fontSize: 12),
                              ),
                              if (message.isMe)
                                Icon(
                                  Icons.check,
                                  color: message.isRead ? Color(0xFF16caea) : Colors.blueGrey.shade200,
                                )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

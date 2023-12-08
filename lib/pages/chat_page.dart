import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxiapp/class/app_color.dart';
import 'package:taxiapp/class/model/theme.dart';
import 'package:taxiapp/components/chat_bubble.dart';
import 'package:taxiapp/components/my_text_field.dart';
import 'package:taxiapp/services/auth/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String recieverUserEmail;
  final String receiverUserID;
  const ChatPage(
      {super.key,
      required this.receiverUserID,
      required this.recieverUserEmail});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Provider.of<ThemeNotifier>(context).isDarkMode == true
                            ? AppColors.dark_theme.backgroundColor : Colors.white,
        appBar: AppBar(
            backgroundColor: Provider.of<ThemeNotifier>(context).isDarkMode == true
                            ? AppColors.dark_theme.wigdetColor : Colors.amber,
            title: Text(
              widget.recieverUserEmail,
              style: GoogleFonts.hind(
                textStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )),
        body: Column(
          children: [
            Expanded(
              child: _buildMessageList(),
            ),
            _buildMessageInput(),
            const SizedBox(height: 25)
          ],
        ));
  }

// Widget _buildMessageList() {
//   return StreamBuilder(
//     stream: _chatService.getMessages(_firebaseAuth.currentUser!.uid),
//     builder: (context, snapshot) {
//       if(snapshot.hasError) {
//         return Text('Error ${snapshot.error}');
//       }

//       if(snapshot.connectionState == ConnectionState.waiting) {
//         return const Text('Loading...');
//       }

//       WidgetsBinding.instance!.addPostFrameCallback((_) {
//         _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
//       });

//       return ListView(
//         controller: _scrollController,
//         children: snapshot.data!.docs.map((document) => _buildMessageItem(document)).toList(),
//       );
//     },
//   );
// }

  Widget _buildMessageList() {
    return FutureBuilder<String>(
      future: _chatService.createChatRoomId(
          widget.receiverUserID, _firebaseAuth.currentUser!.uid),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          if (snapshot.hasData) {
            String chatRoomId = snapshot.data!;
            return StreamBuilder<QuerySnapshot>(
              stream: _chatService.getMessages(chatRoomId),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  _scrollController
                      .jumpTo(_scrollController.position.maxScrollExtent);
                });

                return ListView(
                  controller: _scrollController,
                  children: snapshot.data!.docs
                      .map((document) => _buildMessageItem(document))
                      .toList(),
                );
              },
            );
          } else {
            return const Text('Chat Room ID not found');
          }
        }
      },
    );
  }

  // Widget _buildMessageItem(DocumentSnapshot document) {
  //   Map<String, dynamic> data = document.data() as Map<String, dynamic>;

  //   var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid) ? Alignment.centerRight : Alignment.centerLeft ;
  //   return Container(
  //     alignment: alignment,
  //     child: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Column(
  //         crossAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid) ? CrossAxisAlignment.end : CrossAxisAlignment.start ,
  //         mainAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid) ? MainAxisAlignment.end : MainAxisAlignment.start ,
  //         children: [
  //           Text(data['senderEmail']),
  //           const SizedBox(height: 5),
  //           ChatBubble(message: data['message']),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var messageType = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? MessageType.sent
        : MessageType.received;

    var alignment = (messageType == MessageType.sent)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: (messageType == MessageType.sent)
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          mainAxisAlignment: (messageType == MessageType.sent)
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            Text(
              data['senderEmail'],
              style: GoogleFonts.hind(
                textStyle: TextStyle(
                  fontSize: 15.0,
                  color: Provider.of<ThemeNotifier>(context).isDarkMode == true
                            ? Colors.white : Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 5),
            ChatBubble(
              message: data['message'],
              messageType: messageType,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      margin: EdgeInsets.all(15.0),
      height: 61,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35.0),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 3), blurRadius: 5, color: Colors.grey)
                ],
              ),
              child: Row(
                children: [
                  // IconButton(
                  //     icon: Icon(
                  //       Icons.face,
                  //       color: Colors.blueAccent,
                  //     ),
                  //     onPressed: () {}),
                  SizedBox(width: 20,),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                          hintText: "Type Something...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                          onSubmitted: (message) {
                            sendMessage();
                          },
                          style: TextStyle(color: Provider.of<ThemeNotifier>(context).isDarkMode == true
            ? Colors.black : Colors.black ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.photo_camera, color: Colors.black54),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.attach_file, color: Colors.black54),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ),
          SizedBox(width: 15),
          Container(
            padding: const EdgeInsets.all(15.0),
            decoration:
                BoxDecoration(color: Colors.amber, shape: BoxShape.circle),
            child: InkWell(
              child: Icon(
                Icons.send,
                color: Colors.black,
              ),
              onTap: sendMessage,
            ),
          )
        ],
      ),
    );
  }
}

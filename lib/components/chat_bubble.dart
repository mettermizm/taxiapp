import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxiapp/class/app_color.dart';
import 'package:taxiapp/class/model/theme.dart';

enum MessageType {
  sent,
  received,
}

class ChatBubble extends StatelessWidget {
  final String message;
  final MessageType messageType;
  const ChatBubble({
    Key? key,
    required this.message,
    required this.messageType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color bubbleColor = messageType == MessageType.sent
        ? Provider.of<ThemeNotifier>(context).isDarkMode == true
            ? AppColors.dark_theme.wigdetColor
            : Colors.amber
        : Colors.white;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: bubbleColor,
      ),
      child: Text(
        message,
        style: TextStyle(fontSize: 16, color: Provider.of<ThemeNotifier>(context).isDarkMode == true
            ?Colors.white : Colors.black),
      ),
    );
  }
}

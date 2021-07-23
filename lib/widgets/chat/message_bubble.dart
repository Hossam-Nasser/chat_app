import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:master_chat/widgets/chat/new_message.dart';

class MessageBubble extends StatefulWidget {
  final String message;
  final Timestamp time;
  final delivered;
  final bool isMe;
  final String userName;
  final Key key;
  final String userImage;

  MessageBubble(this.message, this.time, this.delivered, this.isMe,
      this.userName,this.userImage, this.key);

  @override
  _MessageBubbleState createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  String convertTime(Timestamp time) {
    return "${time.toDate().hour}:${time.toDate().minute}";
  }



  @override
  Widget build(BuildContext context) {
    final bg = widget.isMe ? Colors.pink : Colors.purple;
    final align = widget.isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end;
    final icon = widget.delivered ? Icons.done_all : Icons.done;
    final radius = widget.isMe
        ? BorderRadius.only(
            topRight: Radius.circular(10.0),
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(10.0),
          )
        : BorderRadius.only(
            topLeft: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(15.0),
          );
    return Column(
      crossAxisAlignment: align,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: .5,
                  spreadRadius: 2.0,
                  color: Colors.black.withOpacity(.12))
            ],
            color: bg,
            borderRadius: radius,
          ),
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.userName,
                    style: TextStyle(fontSize: 20, color:widget.isMe ? Colors.amber:Colors.cyan,fontWeight: FontWeight.w700),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 48.0),
                    child: Text(
                      widget.message,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Row(
                  children: <Widget>[
                    Text(convertTime(widget.time).toString(),
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: 10.0,
                        )),
                    SizedBox(width: 3.0),
                    Icon(
                      icon,
                      size: 12.0,
                      color: Colors.black38,
                    )
                  ],
                ),
              ),
              Positioned(
                  top: -28,
                  right: widget.isMe ? -15 : null,
                  left: !widget.isMe ? -15 : null,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(widget.userImage),
                    radius: 15,
                  )),
            ],
            clipBehavior: Clip.none,
          ),
        ),
      ],
    );
  }
}

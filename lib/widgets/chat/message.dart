import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:master_chat/widgets/chat/message_bubble.dart';

class Message extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat').orderBy('createdAt',descending: true)
          .snapshots(),
      builder: (ctx, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        final docs = snapshot.data.docs;
        final user =  FirebaseAuth.instance.currentUser;
        return ListView.builder(
          reverse: true,
          itemCount: docs.length,
          itemBuilder: (context, index) => MessageBubble(
              docs[index]['text'],
              docs[index]['createdAt'],
              true,
              docs[index]['userId']==user.uid,
              docs[index]['username'],
              docs[index]['userImage'],
              ValueKey(docs[index])),
          );
      },
    );
  }
}

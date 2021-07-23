// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:master_chat/widgets/chat/message.dart';
import 'package:master_chat/widgets/chat/new_message.dart';

class ChatScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Master chat"),
        actions: [
          DropdownButton(
            underline: Container(),
            items: [
              DropdownMenuItem(
                  child: Row(
                children: [
                  Icon(Icons.exit_to_app,color: Colors.white),
                  SizedBox(
                    width: 8,
                  ),
                  Text('Logout',style: TextStyle(color: Colors.white),)
                ],
              ),
                value: 'logout',
              )
            ],
            onChanged: (itemIdentifier){
              if(itemIdentifier == 'logout'){
                FirebaseAuth.instance.signOut();
              }
            },
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: Message()),
            NewMessage()
          ],
        ),
      ),
    );
  }
}

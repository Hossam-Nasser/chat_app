import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();

  late String _enteredMessage = "";

  void _sendMessage() async{
    FocusScope.of(context).unfocus();
    final user =  FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    FirebaseFirestore.instance.collection('chat').add({
        'text': _enteredMessage,
        'createdAt': Timestamp.now(),
        'username': userData['username'],
        'userId': user.uid,
        'userImage': userData['image_url']
        });
    _controller.clear();
    setState(() {
      _enteredMessage="";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30),
      margin: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              autocorrect: true,
              enableSuggestions: true,
              textCapitalization: TextCapitalization.sentences,
              style: TextStyle(color: Colors.white),
              controller: _controller,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor)
                ),
                  hintText: 'send a message...',
              hintStyle: TextStyle(color:  Theme.of(context).primaryColor)),
              onChanged: (val) {
                setState(() {
                  _enteredMessage = val;
                });
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            disabledColor: Colors.white,
            icon: Icon(Icons.send),
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
          ),
        ],
      ),
    );
  }
}

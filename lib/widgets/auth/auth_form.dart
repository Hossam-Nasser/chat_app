import 'dart:io';

import 'package:flutter/material.dart';
import 'package:master_chat/widgets/pickers/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final void Function(String email, String password, String username,File image,
      bool isLogin, BuildContext ctx) submitFun;

  final bool isLoading;

  AuthForm(this.submitFun, this.isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  bool _isLogin = true;
  late String _email = "";
  late String _password = "";
  late String _username = "";
  var  userImageFile;

  void pickImage(File pickedImage){
     userImageFile= pickedImage;
  }

  void submit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (!_isLogin && userImageFile == null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("please pick an image."), backgroundColor: Theme.of(context).errorColor));
      return;
    }

    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFun(
          _email.trim(), _password.trim(), _username.trim(),userImageFile, _isLogin, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if(!_isLogin) UserImagePicker(pickImage),
                TextFormField(
                  autocorrect: false,
                  enableSuggestions: true,
                  textCapitalization: TextCapitalization.none,
                  key: ValueKey('email'),
                  validator: (val) {
                    if (val!.isEmpty || !val.contains('@')) {
                      return "please enter a valid email address";
                    }
                    return null;
                  },
                  onSaved: (val) => _email = val!,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(width: 3, color: Colors.blue)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.green),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 5),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                if (!_isLogin)
                  TextFormField(
                    autocorrect: true,
                    enableSuggestions: false,
                    textCapitalization: TextCapitalization.words,
                    key: ValueKey('username'),
                    validator: (val) {
                      if (val!.isEmpty || !(val.length > 4)) {
                        return "please enter at least 4 char";
                      }
                      return null;
                    },
                    onSaved: (val) => _username = val!,
                    decoration: InputDecoration(
                      labelText: 'User Name',
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(width: 3, color: Colors.blue)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3, color: Colors.green),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 5),
                      ),
                    ),
                  ),
                if (!_isLogin)
                  SizedBox(
                    height: 10,
                  ),
                TextFormField(
                  key: ValueKey('password'),
                  validator: (val) {
                    if (val!.isEmpty || val.length < 7) {
                      return "please enter at least 7 char";
                    }
                    return null;
                  },
                  onSaved: (val) => _password = val!,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(width: 3, color: Colors.blue)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 3, color: Colors.green),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 5),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                !widget.isLoading
                    ? ElevatedButton(
                        onPressed: () => submit(),
                        style: ElevatedButton.styleFrom(
                          elevation: 10.5,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0)),
                        ),
                        child: Text(_isLogin ? 'login' : 'sign up'),
                      )
                    : CircularProgressIndicator(),
                if (!widget.isLoading)SizedBox(
                  height: 10,
                ),
                if (!widget.isLoading)TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(_isLogin
                        ? 'Create new account'
                        : 'I already have an account'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

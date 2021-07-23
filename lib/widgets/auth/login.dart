
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:master_chat/widgets/pickers/user_image_picker.dart';

import '../../animation/fadeanimation.dart';


class HomePage extends StatefulWidget {

  final void Function(String email, String password, String username,File image,
      bool isLogin, BuildContext ctx) submitFun;

  final bool isLoading;

  HomePage(this.submitFun, this.isLoading);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


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
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if(_isLogin)Container(
              height: 400,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -40,
                    height: 300,
                    width: width,
                    child: FadeAnimation(1, Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/background.png'),
                              fit: BoxFit.fill
                          )
                      ),
                    )),
                  ),
                  Positioned(
                    height: 400,
                    width: width+20,
                    child: FadeAnimation(1.3, Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/background-2.png'),
                              fit: BoxFit.fill
                          )
                      ),
                    )),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if(!_isLogin)SizedBox(height: 50,),
                  FadeAnimation(1.5, Text(_isLogin ? 'Login' : 'Sign up', style: TextStyle(color: Color.fromRGBO(49, 39, 79, 1), fontWeight: FontWeight.bold, fontSize: 30),)),
                  if(!_isLogin) UserImagePicker(pickImage),
                  SizedBox(height: 30,),
                  FadeAnimation(1.7, Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(196, 135, 198, .3),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          )
                        ]
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(
                                    color: Colors.white70
                                ))
                            ),
                            child: TextFormField(
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
                                  border: InputBorder.none,
                                  hintText: "Email",
                                  hintStyle: TextStyle(color: Colors.grey)
                              ),
                            ),
                          ),
                          if (!_isLogin) Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(
                                    color: Colors.white70
                                ))
                            ),
                            child: TextFormField(
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
                                  border: InputBorder.none,
                                  hintText: "Username",
                                  hintStyle: TextStyle(color: Colors.grey)
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: TextFormField(
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
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.grey)
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
                  SizedBox(height: 20,),
                  FadeAnimation(1.9,!widget.isLoading ? Container(
                    height: 50,
                    width: 150,
                    margin: EdgeInsets.symmetric(horizontal: 95),
                    child:  ElevatedButton(
                        onPressed: () => submit(),
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromRGBO(49, 39, 79, 1) ,
                          elevation: 10.5,
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0)),
                        ),
                      child: Text(_isLogin ? 'Login' : 'Sign up', style: TextStyle(color: Colors.white),),
                      )

                    ): Center(child: CircularProgressIndicator(color:Color.fromRGBO(49, 39, 79, 1) ,
                  )),
                  ),
                  SizedBox(height: 30,),
                  if(!widget.isLoading) FadeAnimation(2, Center(child:  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(_isLogin
                        ? 'Create account'
                        : 'I already have an account', style: TextStyle(color: Color.fromRGBO(49, 39, 79, .6) , fontWeight: FontWeight.bold),),
                  ))),
                  SizedBox(height: 20,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
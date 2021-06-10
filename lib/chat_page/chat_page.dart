import 'package:chat_online/chat_page/text_composer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';

import 'package:google_sign_in/google_sign_in.dart';

class ChatPage extends StatefulWidget {

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  User _currenUser;

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((user) {
      _currenUser = user;
    });

  }

  Future<User> _getUser() async{
    if(_currenUser != null) return _currenUser;


    try{
      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential =  GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken
      );

      final UserCredential authResult =
      await FirebaseAuth.instance.signInWithCredential(credential);

      final User user = authResult.user;

    }catch (error){

    }
  }



  void _sendMessage({String text, File imgFile}) async{

    final User user = await _getUser();

    if(user == null){
      _scaffoldkey.currentState.showSnackBar(
       SnackBar(
           content: Text("Não foi possivel fazer o Login. Tente novamente!")
       )
      );
    }

    Map<String, dynamic> data = {
      "uid": user.uid,
      "senderName": user.displayName,
      "semderPhotoUrl": user.photoURL
    };

    if(imgFile != null){
      UploadTask task = FirebaseStorage.instance.ref().child(
        DateTime.now().millisecondsSinceEpoch.toString()
      ).putFile(imgFile);

     TaskSnapshot taskSnapshot  = await task;
     String url = await taskSnapshot.ref.getDownloadURL();
     data['imgUrl'] = url;
    }

    if (text != null) data['text'] = text;

    FirebaseFirestore.instance.collection("mensagens").add({
      'text' : text
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text("Chat Online"),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder<QuerySnapshot>(
                // O strem vai retornando dados assim que tiver uma modificação...
                stream: FirebaseFirestore.instance.collection('messagens').snapshots(),
                builder: (context, snapshot){
                  switch(snapshot.connectionState){
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                      List<DocumentSnapshot> documents =
                          snapshot.data.docs.reversed.toList();



                      return ListView.builder(
                        itemCount: documents.length,
                          reverse: true,
                          itemBuilder: (context, index){
                          return ListTile(
                            title: Text(documents[index].data()),
                          );
                          }
                      );
                  }
                },
              )
          ),
          TextComposer(_sendMessage),
        ],
      )
    );
  }
}

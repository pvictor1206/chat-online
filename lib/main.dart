import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'core/app_widget.dart';

void main() async{
  // Sempre colocar esses comandos
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(AppWidget());

  /*
  LENDO DADOS

  ** Apenas um dado
  DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("mensagens").doc("G96QxwEZcsrDhzVLfVMm").get();
  print(snapshot.data());

  ** Varios dados
  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("mensagens").get();
  snapshot.docs.forEach((d) {
    print(d.data());
  });

  ** Mudar
  QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("mensagens").get();
  snapshot.docs.forEach((d) {
    d.reference.update({'read': true});
  });

  ** Retorna em tempo real a informação
  FirebaseFirestore.instance.collection("mensagens").snapshots().listen((dado) {
    print(dado.docs[0].data());
  });

  FirebaseFirestore.instance.collection("mensagens").doc(-----).snapshots().listen((dado) {
    print(dado.docs[0].data());
  });


  --------------------------------------------------------------------------------

  ESCREVENDO DADOS

  (tirar o await?)

  await FirebaseFirestore.instance.collection("mensagens").doc("G96QxwEZcsrDhzVLfVMm").set({
    'texto':'olá',
    'from': 'Paulo',
    'read': false
  });

  await FirebaseFirestore.instance.collection('memsagens').doc().update({
    'texto':'olá',
    'from': 'Paulo',
    'read': false
  });

   */

  // instace faz com que busque o firetore no app inteiro
  //

}
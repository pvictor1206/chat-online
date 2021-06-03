import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'core/app_widget.dart';

void main() {
  runApp(AppWidget());
  FirebaseFirestore.instance.collection("col").doc("doc").set({"texto": "Paulo"});
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat/services/screen_size.dart';
import 'package:flutter/material.dart';

late ScreenSize screenSize;

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore database = FirebaseFirestore.instance;

const kUIAccent = Colors.lightBlueAccent;
const kUIColor = Colors.white;

const kInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32)),
    borderSide: BorderSide(color: Colors.grey),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF63C1A8), width: 2),
    borderRadius: BorderRadius.all(Radius.circular(32)),
  ),
);

// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/foundation.dart';

import '/models/user.dart';

late User user;

const TESTING = kDebugMode;
const IP = "127.0.0.1";

final FirebaseAuth AUTH = FirebaseAuth.instance;
final FirebaseFirestore FIRESTORE = FirebaseFirestore.instance;
final FirebaseAnalytics ANALYTICS = FirebaseAnalytics.instance;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/foundation.dart';

import '/models/user.dart';

late User user;

const TESTING = kDebugMode;
const IP = "localhost";

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore database = FirebaseFirestore.instance;
final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

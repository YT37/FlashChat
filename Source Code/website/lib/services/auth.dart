import 'dart:async';


import 'package:firebase_auth/firebase_auth.dart' hide User;


import 'package:get/get.dart';


import './user_manager.dart';


import '/config/constants.dart';


// ignore: avoid_classes_with_only_static_members


class Auth {

  static Future<List<Map<String, Object>>> handleErrors({

    required RxList<Map<String, Object>> fields,

    required FirebaseAuthException error,

    required StackTrace stack,

  }) async {

    String _field;


    String _msg;


    switch (error.code) {

      case "invalid-email":

        {

          _field = "username";


          _msg = "Wrong Username";

        }


        break;


      case "user-not-found":

        {

          _field = "username";


          _msg = "Username not registered, Sign Up";

        }


        break;


      case "email-already-in-use":

        {

          _field = "username";


          _msg = "Username taken, Try another one";

        }


        break;


      case "wrong-password":

        {

          _field = "password";


          _msg = "Wrong Password";

        }


        break;


      case "weak-password":

        {

          _field = "password";


          _msg =

              "Weak Passwrod, Try adding symbols, numbers or more alphabets.";

        }


        break;


      case "invalid-credential":

        {

          _field = "password";


          _msg = "Wrong Username and/or Password";

        }


        break;


      case "too-many-requests":

        {

          _field = "password";


          _msg = "Too many unsuccessful attempts. Try Again Later...";

        }


        break;


      case "operation-not-allowed":

        {

          _field = "password";


          _msg = "Operation not allowed. Try Again Later...";

        }


        break;


      default:

        {

          _field = "password";


          _msg = "An Undefined Error Occurred, Contact Us!";


          if (!TESTING) {

            await ANALYTICS.logEvent(

              name: "ERROR - Auth (Unexpected)",

              parameters: {

                "error": error.toString(),

                "stack": stack.toString(),

              },

            );

          }

        }


        break;

    }


    fields

        .where((field) => field["value"] == _field)

        .forEach((field) => field["error"] = _msg);


    return fields.toList();

  }


  static Future<void> signup() async {

    await UserManager.addUser(

      id: AUTH.currentUser!.uid,

      username: AUTH.currentUser!.email!,

    );


    if (!TESTING) {

      await ANALYTICS.setUserId(id: AUTH.currentUser!.uid);


      await ANALYTICS.logSignUp(signUpMethod: "Email");

    }


    user = await UserManager.getUser(AUTH.currentUser!.uid);


    await Get.offAndToNamed("/chat");

  }


  static Future<void> login() async {

    if (await UserManager.userExists(AUTH.currentUser!.uid)) {

      user = await UserManager.getUser(AUTH.currentUser!.uid);

    } else {

      await UserManager.addUser(

        id: AUTH.currentUser!.uid,

        username: AUTH.currentUser!.email!,

      );


      user = await UserManager.getUser(AUTH.currentUser!.uid);

    }


    if (!TESTING) {

      await ANALYTICS.setUserId(id: AUTH.currentUser!.uid);


      await ANALYTICS.logLogin();

    }


    await Get.offAndToNamed("/chat");

  }


  static Future<void> logout() async {

    await AUTH.signOut();


    await UserManager.clearUsers();


    await Get.offAndToNamed("/");

  }

}


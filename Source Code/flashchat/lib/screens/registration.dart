import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat/constants.dart';
import 'package:flashchat/widgets/input_field.dart';
import 'package:flashchat/widgets/password_field.dart';
import 'package:flashchat/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FocusNode passwordNode = FocusNode();
  Map<String, String> errors = {"user": "", "pass": ""};

  late InputField userField;
  late PasswordField passField;

  @override
  void initState() {
    super.initState();

    userField = InputField(
      decoration: kInputDecoration.copyWith(
          hintText: "Username", prefixIcon: Icon(Icons.account_circle)),
      onSubmitted: (_) => FocusScope.of(context).requestFocus(passwordNode),
    );

    passField = PasswordField(
      decoration: kInputDecoration.copyWith(
          hintText: "Password", prefixIcon: Icon(Icons.lock)),
      onSubmitted: (_) => submit(context),
      node: passwordNode,
    );
  }

  @override
  void dispose() {
    passwordNode.dispose();
    super.dispose();
  }

  void submit(BuildContext context) async {
    FocusScope.of(context).unfocus();

    String username = "${userField.text.toLowerCase()}";
    String password = passField.pass;

    if (userField.text == "")
      errors["user"] = "Username cannot be empty";
    else
      errors["user"] = "";

    if (password == "")
      errors["pass"] = "The password cannot be empty";
    else
      errors["pass"] = "";

    if (errors.values.where((e) => e.isNotEmpty).length == 0)
      FocusScope.of(context).unfocus();

    try {
      await auth.createUserWithEmailAndPassword(
          email: username, password: password);

      Navigator.pushNamed(context, "/chat");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          errors["user"] = "The username is wrong";
          break;
        case "email-already-in-use":
          errors["user"] = "The username is already registered";
          break;
        case "too-many-requests":
          errors["pass"] = "Too many unsuccessful attempts. Try again later..";
          break;
        default:
          errors["pass"] = "An undefined error occurred";
      }
    }

    userField.setError(errors["user"]);
    passField.setError(errors["pass"]);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kUIColor,
      body: Builder(
        builder: (context) => SafeArea(
          child: Padding(
            padding: screenSize.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  child: Hero(
                    tag: "logo",
                    child: Container(
                      height: screenSize.height(200),
                      child: Image.asset("images/logo.png"),
                    ),
                  ),
                ),
                SizedBox(height: screenSize.height(48)),
                userField,
                passField,
                RoundedButton(
                  color: Colors.blueAccent,
                  text: "Register",
                  onTap: () => submit(context),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';


import 'package:flutter/material.dart';


import 'package:get/get.dart';


import '/config/constants.dart';


import '/services/auth.dart';


import '/services/responsive.dart';


import '/tools/functions.dart';


import '/ui/widgets/input_field.dart';


import '/ui/widgets/rounded_button.dart';


class SignUpPage extends StatefulWidget {

  const SignUpPage({super.key});


  @override

  _SignUpPageState createState() => _SignUpPageState();

}


class _SignUpPageState extends State<SignUpPage> with RestorationMixin {

  @override

  String get restorationId => "sign_up_page";


  late final RxList<Map<String, Object>> fields;


  final RestorableTextEditingController _usernameController =

      RestorableTextEditingController();


  final RestorableTextEditingController _passController =

      RestorableTextEditingController();


  @override

  void initState() {

    super.initState();


    fields = [

      {

        "value": "username",

        "name": "Username",

        "controller": _usernameController,

        "icon": Icons.account_circle,

        "input": TextInputType.name,

        "error": "",

      },

      {

        "value": "password",

        "name": "Password",

        "controller": _passController,

        "icon": Icons.password,

        "input": TextInputType.visiblePassword,

        "submit": (_) => submit(context),

        "hide": true,

        "error": "",

      },

    ].obs;

  }


  @override

  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {

    fields.forEach((field) {

      if (field["controller"] != null) {

        registerForRestoration(

          field["controller"]! as RestorableTextEditingController,

          "${field["value"]}_controller",

        );

      }

    });

  }


  @override

  void dispose() {

    fields.forEach((field) {

      if (field["controller"] != null) {

        (field["controller"]! as RestorableTextEditingController).dispose();

      }

    });


    super.dispose();

  }


  @override

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        leading: IconButton(

          icon: const Icon(Icons.arrow_back),

          onPressed: () => Get.back(),

        ),

      ),

      body: SafeArea(

        child: Padding(

          padding: EdgeInsets.symmetric(

            horizontal: Responsive.isDesktop(context) ? 200 : 20,

          ),

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,

            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [

              Flexible(child: logo(200)),

              const SizedBox(height: 50),

              Obx(

                () => Column(

                  children: List.generate(

                    fields.length,

                    (index) {

                      final Map<String, dynamic> field = fields[index];


                      return InputField(

                        decoration: InputDecoration(

                          label: Text(field["name"]),

                          prefixIcon: Icon(

                            field["icon"],

                            color: context.theme.colorScheme.secondary,

                          ),

                        ),

                        controller: field["controller"],

                        onSubmitted: field["submit"],

                        textInputType: field["input"],

                        hideText: field["hide"] ?? false,

                        error: field["error"],

                      );

                    },

                  ),

                ),

              ),

              const SizedBox(height: 20),

              Hero(

                tag: "signup",

                child: RoundedButton(

                  text: "Sign Up",

                  color: context.theme.colorScheme.tertiary,

                  onTap: () => submit(context),

                ),

              ),

            ],

          ),

        ),

      ),

    );

  }


  Future<void> submit(BuildContext context) async {

    FocusScope.of(context).unfocus();


    final String username = _usernameController.value.text.toLowerCase();


    final String password = _passController.value.text;


    bool errors = false;


    fields.forEach((field) => field["error"] = "");


    fields.forEach(

      (field) {

        if ((field["error"]! as String).isNotEmpty) {

          errors = true;


          return;

        }

      },

    );


    if (!errors && username.isNotEmpty && password.isNotEmpty) {

      try {

        await AUTH.createUserWithEmailAndPassword(

          email: "$username@gmail.com",

          password: password,

        );


        await Auth.signup();

      } on FirebaseAuthException catch (error, stack) {

        errors = true;


        fields.value = await Auth.handleErrors(

          fields: fields,

          error: error,

          stack: stack,

        );

      } catch (error, stack) {

        fields.forEach((field) {

          if (field["value"] == "password") {

            field["error"] = "An Error Occurred, Please Try Again ...";


            errors = true;

          }

        });


        if (!TESTING) {

          await ANALYTICS.logEvent(

            name: "ERROR - Sign Up (Unexpected)",

            parameters: {

              "error": error.toString(),

              "stack": stack.toString(),

            },

          );

        }

      }

    } else if (username.isEmpty || password.isEmpty) {

      fields.forEach((field) {

        if ((field["controller"]! as RestorableTextEditingController)

            .value

            .text

            .isEmpty) {

          field["error"] = "${field["name"]} cannot be empty.";


          errors = true;

        }

      });

    }

  }

}


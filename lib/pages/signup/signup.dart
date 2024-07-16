import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_roof/auth_helper.dart';
import 'package:smart_roof/const/custom_styles.dart';
import 'package:smart_roof/route/routing_constants.dart';
import 'package:smart_roof/widgets/my_password_field.dart';
import 'package:smart_roof/widgets/my_text_button.dart';
import 'package:smart_roof/widgets/my_text_field.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool passwordVisibility = true;

  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordConfirm = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _passwordConfirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:
        const EdgeInsets.only(left: 16, right: 16, top: 40, bottom: 30),
        decoration: const BoxDecoration(
            color: Color.fromRGBO(32, 31, 37, 1)
        ),
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              CupertinoIcons.chevron_back,
                              color: Color.fromRGBO(242, 242, 242, 1),
                              size: 32,
                            )
                          ),
                          const Text(
                            "Register",
                            style: kHeadline,
                          ),
                          const Text(
                            "Create new account to get started.",
                            style: kBodyText2,
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          MyTextField(
                            hintText: 'Email',
                            inputType: TextInputType.emailAddress,
                            textEditingController: _email,
                          ),
                          MyPasswordField(
                            hintText: 'Password',
                            textEditingController: _password,
                            isPasswordVisible: passwordVisibility,
                            onTap: () {
                              setState(() {
                                passwordVisibility = !passwordVisibility;
                              });
                            },
                          ),
                          MyPasswordField(
                            hintText: 'Password Confirm',
                            textEditingController: _passwordConfirm,
                            isPasswordVisible: passwordVisibility,
                            onTap: () {
                              setState(() {
                                passwordVisibility = !passwordVisibility;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account? ",
                          style: kBodyText,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context,
                                signInPageRoute,
                                    (Route<dynamic> route) => false);
                          },
                          child: Text(
                            "Sign In",
                            style: kBodyText.copyWith(
                              color: const Color.fromRGBO(75, 91, 102, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextButton(
                      buttonName: 'Register',
                      onTap: _signUp,
                      bgColor: Colors.white,
                      textColor: Colors.black87,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _signUp() async {
    var email = _email.text.trim();
    var pw = _password.text.trim();
    var pwConfirm = _passwordConfirm.text.trim();

    if (email.isEmpty || pw.isEmpty || pw != pwConfirm) {
      await showOkAlertDialog(
        context: context,
        message: 'Check your email or password',
      );
      return;
    }

    var obj = await AuthHelper.signUp(email, pw);

    if (obj is User && mounted) {
      Navigator.pushNamedAndRemoveUntil(
          context, homePageRoute, (Route<dynamic> route) => false);
    } else if(mounted){
      await showOkAlertDialog(
        context: context,
        message: obj,
      );
    }
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_roof/auth_helper.dart';
import 'package:smart_roof/const/custom_styles.dart';
import 'package:smart_roof/route/routing_constants.dart';
import 'package:flutter_svg/svg.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: AuthHelper.initializeFirebase(context: context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              User? user = AuthHelper.currentUser();
              if (user != null) {
                Future.delayed(Duration.zero, () async {
                  Navigator.pushNamedAndRemoveUntil(context, homePageRoute,
                          (Route<dynamic> route) => false);
                });
              } else {
                return _getScreen(context);
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  _getScreen(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(32, 31, 37, 1)
      ),
      child: Column(
        children: [
          Flexible(
            child: Column(
              children: [
                Center(
                  child: SvgPicture.asset(
                    'assets/icons/caret-up-solid.svg',
                    height: 250,
                    width: 250,
                  )
                ),
                const SizedBox(
                  height: 5,
                ),
                const Text(
                  "WELCOME\nto\nSMART ROOF ",
                  style: kHeadline,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 35,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: const Text(
                    "This app is connected to the hardware smart roof via Firebase. this app can control and gets the readings from sensors.",
                    style: kBodyText,
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 60,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(41, 39, 48, 1),
              borderRadius: BorderRadius.circular(18),
            ),
            child: TextButton(
              style: ButtonStyle(
                overlayColor: WidgetStateProperty.resolveWith(
                      (states) => const Color.fromRGBO(75, 91, 102,1),
                ),
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context,
                    signInPageRoute, (Route<dynamic> route) => false);
              },
              child: const Text(
                'GET STARTED',
                style: kButtonText,
              ),
            )
          )
        ],
      ),
    );
  }
}
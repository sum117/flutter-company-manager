import 'package:companymanager/data.dart';
import 'package:companymanager/services/auth.dart';
import 'package:companymanager/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(Sizes.loginPageContainerPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const FlutterLogo(size: Sizes.logoSize),
            LoginButton(
              color: Colors.blue,
              icon: FontAwesomeIcons.google,
              label: const Text(ButtonLabels.googleLogin),
              loginMethod: AuthService().googleLogin,
            ),
            FutureBuilder(
                future: SignInWithApple.isAvailable(),
                builder: (context, snapshot) {
                  if (snapshot.data == true) {
                    return LoginButton(
                      label: const Text(
                        ButtonLabels.appleLogin,
                        style: TextStyle(color: Colors.black),
                      ),
                      icon: FontAwesomeIcons.apple,
                      color: Colors.white,
                      loginMethod: AuthService().appleLogin,
                    );
                  } else {
                    return Container();
                  }
                }),
            LoginButton(
              color: Colors.deepPurple,
              icon: FontAwesomeIcons.userNinja,
              label: const Text(ButtonLabels.anonymousLogin),
              loginMethod: AuthService().anonymousLogin,
            ),
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final Text label;
  final Function loginMethod;

  const LoginButton(
      {super.key,
      required this.color,
      required this.icon,
      required this.label,
      required this.loginMethod});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: Sizes.mainContainerMargin),
      child: ElevatedButton.icon(
        onPressed: () => loginMethod(),
        icon: Icon(
          icon,
          size: Sizes.buttonIconSize,
          color: color == Colors.white ? Colors.black : Colors.white,
        ),
        label: label,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(Sizes.buttonPadding),
          backgroundColor: color,
        ),
      ),
    );
  }
}

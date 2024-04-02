import 'package:companymanager/companies/companies.dart';
import 'package:companymanager/data.dart';
import 'package:companymanager/login/login.dart';
import 'package:companymanager/services/auth.dart';
import 'package:companymanager/shared/loading.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return const Center(child: Text(FeedbackMessage.genericError));
        } else if (snapshot.hasData) {
          return const CompaniesScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}

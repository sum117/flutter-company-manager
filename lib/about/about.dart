import 'package:companymanager/data.dart';
import 'package:companymanager/routes.dart';
import 'package:companymanager/shared/bottom_nav_bar.dart';
import 'package:companymanager/theme.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppRouteLabel.about),
        backgroundColor: Colors.green,
      ),
      bottomNavigationBar: const BottomNavBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(Sizes.formAddScreenContainerPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...aboutParagraphs.map((paragraph) {
                return Padding(
                  padding: const EdgeInsets.all(
                      Sizes.companyAddScreenParagraphPadding),
                  child: Text(paragraph),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:companymanager/companies/company_create_update.dart';
import 'package:companymanager/companies/company_drawer.dart';
import 'package:companymanager/companies/company_item.dart';
import 'package:companymanager/data.dart';
import 'package:companymanager/routes.dart';
import 'package:companymanager/services/firestore.dart';
import 'package:companymanager/services/models.dart';
import 'package:companymanager/shared/bottom_nav_bar.dart';
import 'package:companymanager/shared/loading.dart';
import 'package:companymanager/theme.dart';
import 'package:flutter/material.dart';

class CompaniesScreen extends StatelessWidget {
  const CompaniesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Company>>(
        future: FirestoreService().getCompanies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else if (snapshot.hasError) {
            return const Center(child: Text(FeedbackMessage.fetchError));
          } else if (snapshot.hasData) {
            var companies = snapshot.data!;
            return Scaffold(
              drawer: CompanyDrawer(companies: companies),
              appBar: AppBar(
                  title: const Text(AppRouteLabel.companies),
                  backgroundColor: Colors.green,
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  const CompanyCreateUpdateScreen()),
                        );
                      },
                    )
                  ]),
              body: GridView.count(
                primary: false,
                padding: const EdgeInsets.all(Sizes.gridViewPadding),
                crossAxisSpacing: Sizes.gridViewCrossAxisSpacing,
                crossAxisCount: Sizes.gridViewCrossAxisCount,
                children: companies
                    .map((company) => CompanyItem(company: company))
                    .toList(),
              ),
              bottomNavigationBar: const BottomNavBar(),
            );
          } else {
            return const Center(child: Text(FeedbackMessage.noCompanies));
          }
        });
  }
}

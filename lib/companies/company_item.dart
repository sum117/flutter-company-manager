import 'package:companymanager/companies/company_create_update.dart';
import 'package:companymanager/data.dart';
import 'package:companymanager/licenses/license.create_update.dart';
import 'package:companymanager/routes.dart';
import 'package:companymanager/services/firestore.dart';
import 'package:companymanager/services/models.dart';
import 'package:companymanager/shared/loading.dart';
import 'package:companymanager/theme.dart';
import 'package:flutter/material.dart';

import '../licenses/license_list.dart';

class CompanyItem extends StatelessWidget {
  final Company company;
  const CompanyItem({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: company.image,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CompanyDetailsScreen(company: company),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: Sizes.companyCardFlexValue,
                child: SizedBox(
                  child: Image.network(company.image, fit: BoxFit.contain),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: Sizes.companyCardTitlePaddingLeft,
                    right: Sizes.companyCardTitlePaddingRight,
                  ),
                  child: Text(
                    company.companyName,
                    style: const TextStyle(
                      height: Sizes.companyCardTitleHeight,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CompanyDetailsScreen extends StatelessWidget {
  final Company company;
  const CompanyDetailsScreen({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Company>(
        future: FirestoreService().getCompany(company.id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const LoadingScreen();
          } else if (snapshot.hasError) {
            return const LoadingScreen();
          }
          var updatedCompany = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              actions: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CompanyCreateUpdateScreen(
                            initialState: updatedCompany),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title:
                              const Text(DialogPrompt.deleteConfirmationTitle),
                          content: const Text(
                              DialogPrompt.deleteConfirmationMessage),
                          actions: [
                            TextButton(
                              onPressed: () {
                                FirestoreService()
                                    .deleteCompany(updatedCompany.id);
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    AppRoutePath.home, (route) => false);
                              },
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: const Text(ButtonLabels.delete),
                            ),
                          ],
                        );
                      },
                    );
                  },
                )
              ],
            ),
            body: ListView(
              children: [
                Hero(
                  tag: updatedCompany.image,
                  child: Image.network(
                    updatedCompany.image,
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.all(Sizes.companyDetailsTitlePadding),
                  child: Text(
                    updatedCompany.companyName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      height: Sizes.companyDetailsTitleHeight,
                      fontSize: Sizes.companyDetailsFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                CompanyDetailsListTiles(company: updatedCompany),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(Sizes.companyDetailsTitlePadding),
                      child: Text(
                        licensesHeaderText,
                        style: TextStyle(
                          height: Sizes.companyDetailsTitleHeight,
                          fontSize: Sizes.companyDetailsFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LicenseCreateUpdateScreen(
                                company: updatedCompany),
                          ),
                        );
                      },
                    )
                  ],
                ),
                LicenseList(company: updatedCompany)
              ],
            ),
          );
        });
  }
}

class CompanyDetailsListTiles extends StatelessWidget {
  final Company company;
  const CompanyDetailsListTiles({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [...companyStepOneFormFields, ...companyStepTwoFormFields]
          .map((field) {
        return ListTile(
          title: Text(companyAddFieldsTranslationMap[field]!),
          subtitle: Text(
            company.getCommonField(field),
          ),
        );
      }).toList(),
    );
  }
}

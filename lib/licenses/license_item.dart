import 'package:companymanager/data.dart';
import 'package:companymanager/licenses/license.create_update.dart';
import 'package:companymanager/routes.dart';
import 'package:companymanager/services/firestore.dart';
import 'package:companymanager/services/models.dart';
import 'package:companymanager/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LicenseItem extends StatelessWidget {
  final License license;
  final Company company;
  const LicenseItem({super.key, required this.license, required this.company});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${license.environmentalAgency} | ${license.number}',
        ),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.penToSquare),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => LicenseCreateUpdateScreen(
                      company: company, initialState: license),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(FontAwesomeIcons.trash),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text(DialogPrompt.deleteConfirmationTitle),
                    content: const Text(DialogPrompt.deleteConfirmationMessage),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(ButtonLabels.cancel),
                      ),
                      TextButton(
                        onPressed: () {
                          FirestoreService().deleteLicense(license.id);
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              AppRoutePath.home, (route) => false);
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
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            width: Sizes.profileImageSize,
            height: Sizes.profileImageSize,
            child: Icon(
              FontAwesomeIcons.certificate,
              color: Colors.green,
              size: Sizes.profileImageSize,
            ),
          ),
          ...licenseFormFields.map((field) {
            return Container(
              padding: const EdgeInsets.all(Sizes.formFieldContainerPadding),
              child: ListTile(
                title: Text(
                  licenseFormFieldsTranslationMap[field] ?? '',
                ),
                subtitle: Text(
                  !licenseTimestampFields.contains(field)
                      ? license.getCommonField(field)
                      : license
                          .getTimestampField(field)
                          .toDate()
                          .toLocal()
                          .toString(),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

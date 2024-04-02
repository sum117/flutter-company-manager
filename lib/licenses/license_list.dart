import 'package:companymanager/data.dart';
import 'package:companymanager/licenses/license_item.dart';
import 'package:companymanager/services/firestore.dart';
import 'package:companymanager/services/models.dart';
import 'package:companymanager/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LicenseList extends StatelessWidget {
  final Company company;
  const LicenseList({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirestoreService().listenToLicenses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text(FeedbackMessage.genericError));
          } else if (snapshot.hasData) {
            var licenses = snapshot.data!;
            return Column(
              children: licenses
                  //only licenses that contain company id
                  .where((license) => license.company == company.id)
                  .map((license) =>
                      LicenseCard(license: license, company: company))
                  .toList(),
            );
          } else {
            return const Center(child: Text(FeedbackMessage.genericError));
          }
        });
  }
}

class LicenseCard extends StatelessWidget {
  final License license;
  final Company company;
  const LicenseCard({
    super.key,
    required this.license,
    required this.company,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      elevation: Sizes.licenseDrawerElevation,
      margin: const EdgeInsets.all(Sizes.licenseDrawerMargin),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  LicenseItem(license: license, company: company),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(Sizes.licenseDrawerPadding),
          child: ListTile(
            leading: const Icon(
              FontAwesomeIcons.certificate,
              color: Colors.green,
            ),
            title: Text(
              license.environmentalAgency,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            subtitle: Text(
              license.number,
              overflow: TextOverflow.fade,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ),
      ),
    );
  }
}

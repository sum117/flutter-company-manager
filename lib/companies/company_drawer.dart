import 'package:companymanager/services/models.dart';
import 'package:companymanager/theme.dart';
import 'package:flutter/material.dart';

import '../licenses/license_list.dart';

class CompanyDrawer extends StatelessWidget {
  final List<Company> companies;
  const CompanyDrawer({super.key, required this.companies});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.separated(
          itemBuilder: (context, index) {
            Company company = companies[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: Sizes.companyDrawerItemPaddingTop,
                    left: Sizes.companyDrawerItemPaddingLeft,
                  ),
                  child: Text(
                    company.companyName,
                    style: const TextStyle(
                      fontSize: Sizes.companyDrawerItemFontSize,
                    ),
                  ),
                ),
                LicenseList(company: company),
              ],
            );
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: companies.length),
    );
  }
}

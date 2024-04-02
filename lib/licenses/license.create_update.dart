import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companymanager/data.dart';
import 'package:companymanager/licenses/license_create_update_state.dart';
import 'package:companymanager/routes.dart';
import 'package:companymanager/services/firestore.dart';
import 'package:companymanager/services/models.dart';
import 'package:companymanager/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LicenseCreateUpdateScreen extends StatelessWidget {
  final Company company;
  final License? initialState;
  const LicenseCreateUpdateScreen(
      {super.key, required this.company, this.initialState});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          initialState != null
              ? licensesUpdateHeaderText
              : licensesAddHeaderText,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Scaffold(
        body: ChangeNotifierProvider(
          create: (_) => LicenseAddState(initialState: initialState),
          builder: (context, _) {
            return LicenseAddForm(
                company: company, isEdit: initialState != null);
          },
        ),
      ),
    );
  }
}

class LicenseAddForm extends StatelessWidget {
  final Company company;
  final bool isEdit;
  const LicenseAddForm(
      {super.key, required this.company, required this.isEdit});

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<LicenseAddState>(context);
    return Form(
      child: Column(
        children: [
          ...licenseFormFields.map((field) {
            if (!licenseTimestampFields.contains(field)) {
              return Container(
                padding: const EdgeInsets.all(Sizes.formFieldContainerPadding),
                child: TextFormField(
                  initialValue: state.license.getCommonField(field) ?? '',
                  decoration: InputDecoration(
                    labelText: licenseFormFieldsTranslationMap[field],
                    filled: true,
                    hintText: licensesFormFieldsPlaceholders[field],
                  ),
                  onChanged: (value) {
                    state.setLicenseField(field, value);
                  },
                ),
              );
            } else {
              var controller = field == 'issuance'
                  ? state.issuanceController
                  : state.validityController;
              return Container(
                padding: const EdgeInsets.all(Sizes.formFieldContainerPadding),
                child: TextFormField(
                  focusNode: AlwaysDisabledFocusNode(),
                  controller: controller,
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    ).then((date) {
                      if (date != null) {
                        state.setLicenseTimestampField(
                            field, Timestamp.fromDate(date));
                        controller.text = date.toIso8601String();
                      }
                    });
                  },
                  decoration: InputDecoration(
                    suffixIcon: const Icon(FontAwesomeIcons.calendarDays),
                    labelText: licenseFormFieldsTranslationMap[field],
                    filled: true,
                    hintText: licensesFormFieldsPlaceholders[field],
                  ),
                ),
              );
            }
          }),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(Sizes.buttonPadding),
                child: ElevatedButton.icon(
                  onPressed: () {
                    state.license.company = company.id;
                    FirestoreService().createUpdateLicense(state.license);
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        AppRoutePath.home, (route) => false);
                  },
                  icon: const Icon(FontAwesomeIcons.floppyDisk,
                      size: Sizes.buttonIconSize),
                  label: Text(isEdit
                      ? ButtonLabels.updateLicense
                      : ButtonLabels.createLicense),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(Sizes.buttonPadding),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

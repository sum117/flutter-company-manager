import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companymanager/services/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LicenseAddState with ChangeNotifier {
  License _license = License(
    issuance: Timestamp.now(),
    validity: Timestamp.now(),
  );
  License? initialState;

  final TextEditingController issuanceController = TextEditingController();
  final TextEditingController validityController = TextEditingController();
  License get license => _license;

  LicenseAddState({this.initialState}) {
    if (initialState != null) {
      _license = initialState!;
      issuanceController.text = _license.issuance.toDate().toString();
      validityController.text = _license.validity.toDate().toString();
    }
  }
  setLicenseField(String field, String value) {
    _license.setCommonField(field, value);
    notifyListeners();
  }

  setLicenseTimestampField(String field, Timestamp value) {
    _license.setTimestampField(field, value);
    notifyListeners();
  }
}

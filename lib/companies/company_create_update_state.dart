import 'package:companymanager/data.dart';
import 'package:companymanager/services/models.dart';
import 'package:flutter/material.dart';

class CompanyCreateUpdateState with ChangeNotifier {
  double _progress = 0;

  double get progress => _progress;
  Company company = Company();
  Company? initialState;
  late final PageController controller;

  CompanyCreateUpdateState({this.initialState}) {
    if (initialState != null) {
      company = initialState!;
      controller = PageController(initialPage: 1);
    } else {
      controller = PageController(initialPage: 0);
    }
  }

  set progress(double newValue) {
    _progress = newValue;
    notifyListeners();
  }

  setCompanyField(String field, String value) {
    company.setCommonField(field, value);
    notifyListeners();
  }

  setCompanyLicenseField(String field, List<String> licenseReferences) {
    company.setLicenseField(field, licenseReferences);
    notifyListeners();
  }

  void previousPage() async {
    await controller.previousPage(
      duration:
          const Duration(milliseconds: AnimationTime.pageChangeMilliseconds),
      curve: Curves.easeInOut,
    );
  }

  void nextPage() async {
    await controller.nextPage(
      duration:
          const Duration(milliseconds: AnimationTime.pageChangeMilliseconds),
      curve: Curves.easeInOut,
    );
    print(controller.page);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'models.g.dart';

const licenseFormFields = [
  'environmentalAgency',
  'number',
  'issuance',
  'validity'
];

const licenseTimestampFields = ['issuance', 'validity'];

@JsonSerializable()
class License {
  String id;
  String company;
  String environmentalAgency;
  String number;
  // it's a timestamp string from Firestore
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  Timestamp issuance;
  @JsonKey(fromJson: _timestampFromJson, toJson: _timestampToJson)
  Timestamp validity;

  static Timestamp _timestampFromJson(dynamic timestamp) {
    return Timestamp.fromMillisecondsSinceEpoch(
        timestamp.millisecondsSinceEpoch);
  }

  static dynamic _timestampToJson(Timestamp timestamp) {
    return timestamp;
  }

  License(
      {this.id = '',
      this.company = '',
      this.environmentalAgency = '',
      this.number = '',
      required this.issuance,
      required this.validity});

  factory License.fromJson(Map<String, dynamic> json) =>
      _$LicenseFromJson(json);

  Map<String, dynamic> toJson() {
    return _$LicenseToJson(this);
  }

  setCommonField(String field, dynamic value) {
    switch (field) {
      case 'company':
        company = value;
        break;
      case 'environmentalAgency':
        environmentalAgency = value;
        break;
      case 'number':
        number = value;
        break;
    }
  }

  getCommonField(String field) {
    switch (field) {
      case 'company':
        return company;
      case 'environmentalAgency':
        return environmentalAgency;
      case 'number':
        return number;
    }
  }

  Timestamp getTimestampField(String field) {
    switch (field) {
      case 'issuance':
        return issuance;
      case 'validity':
        return validity;
      default:
        return Timestamp.now();
    }
  }

  setTimestampField(String field, Timestamp value) {
    switch (field) {
      case 'issuance':
        issuance = value;
        break;
      case 'validity':
        validity = value;
        break;
    }
  }
}

@JsonSerializable()
class User {
  final String uid;
  final List<String?> companies;

  User({this.uid = '', this.companies = const []});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

const companyStepOneFormFields = [
  'companyName',
  'federalTaxNumber',
  'image',
];

const companyStepTwoFormFields = [
  'city',
  'state',
  'neighborhood',
  'complement',
  'zipCode'
];

// so we can display a start screen
const startingScreenPositionalPlaceholder = [];

const companyFormSteps = [
  startingScreenPositionalPlaceholder,
  companyStepOneFormFields,
  companyStepTwoFormFields
];

@JsonSerializable()
class Company {
  String id;
  String companyName;
  String image;
  String city;
  String state;
  String neighborhood;
  String complement;
  //cnpj
  String federalTaxNumber;
  String zipCode;
  List<String> licenses;

  Company(
      {this.id = '',
      this.companyName = '',
      this.image = '',
      this.city = '',
      this.state = '',
      this.neighborhood = '',
      this.complement = '',
      this.federalTaxNumber = '',
      this.zipCode = '',
      this.licenses = const []});

  setCommonField(String field, dynamic value) {
    switch (field) {
      case 'companyName':
        companyName = value;
        break;
      case 'image':
        image = value;
        break;
      case 'city':
        city = value;
        break;
      case 'state':
        state = value;
        break;
      case 'neighborhood':
        neighborhood = value;
        break;
      case 'complement':
        complement = value;
        break;
      case 'federalTaxNumber':
        federalTaxNumber = value;
        break;
      case 'zipCode':
        zipCode = value;
        break;
    }
  }

  getCommonField(String field) {
    switch (field) {
      case 'companyName':
        return companyName;
      case 'image':
        return image;
      case 'city':
        return city;
      case 'state':
        return state;
      case 'neighborhood':
        return neighborhood;
      case 'complement':
        return complement;
      case 'federalTaxNumber':
        return federalTaxNumber;
      case 'zipCode':
        return zipCode;
    }
  }

  setLicenseField(String field, List<String> licenseReferences) {
    if (field == 'licenses') {
      licenses = licenseReferences;
    }
  }

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

  Map<String, dynamic> toJson() {
    return _$CompanyToJson(this);
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

License _$LicenseFromJson(Map<String, dynamic> json) => License(
      id: json['id'] as String? ?? '',
      company: json['company'] as String? ?? '',
      environmentalAgency: json['environmentalAgency'] as String? ?? '',
      number: json['number'] as String? ?? '',
      issuance: License._timestampFromJson(json['issuance']),
      validity: License._timestampFromJson(json['validity']),
    );

Map<String, dynamic> _$LicenseToJson(License instance) => <String, dynamic>{
      'id': instance.id,
      'company': instance.company,
      'environmentalAgency': instance.environmentalAgency,
      'number': instance.number,
      'issuance': License._timestampToJson(instance.issuance),
      'validity': License._timestampToJson(instance.validity),
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      uid: json['uid'] as String? ?? '',
      companies: (json['companies'] as List<dynamic>?)
              ?.map((e) => e as String?)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'uid': instance.uid,
      'companies': instance.companies,
    };

Company _$CompanyFromJson(Map<String, dynamic> json) => Company(
      id: json['id'] as String? ?? '',
      companyName: json['companyName'] as String? ?? '',
      image: json['image'] as String? ?? '',
      city: json['city'] as String? ?? '',
      state: json['state'] as String? ?? '',
      neighborhood: json['neighborhood'] as String? ?? '',
      complement: json['complement'] as String? ?? '',
      federalTaxNumber: json['federalTaxNumber'] as String? ?? '',
      zipCode: json['zipCode'] as String? ?? '',
      licenses: (json['licenses'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
      'id': instance.id,
      'companyName': instance.companyName,
      'image': instance.image,
      'city': instance.city,
      'state': instance.state,
      'neighborhood': instance.neighborhood,
      'complement': instance.complement,
      'federalTaxNumber': instance.federalTaxNumber,
      'zipCode': instance.zipCode,
      'licenses': instance.licenses,
    };

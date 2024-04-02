import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companymanager/services/auth.dart';
// import the user type
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:rxdart/rxdart.dart';

import 'models.dart';

class FirestoreCollections {
  static const String companies = 'company';
  static const String licenses = 'license';
  static const String users = 'user';
}

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Company>> getCompanies([List<String>? companyIds]) async {
    QuerySnapshot<Map<String, dynamic>> snapshot;
    if (companyIds != null) {
      snapshot = await _db
          .collection(FirestoreCollections.companies)
          .where(FieldPath.documentId, whereIn: companyIds)
          .get();
    } else {
      snapshot = await _db.collection(FirestoreCollections.companies).get();
    }
    return snapshot.docs.map((doc) => Company.fromJson(doc.data())).toList();
  }

  Future<Company> getCompany(String companyId) async {
    var snapshot = await _db
        .collection(FirestoreCollections.companies)
        .doc(companyId)
        .get();
    // we must get the DocumentReference as a path string to be able to serialize it
    return Company.fromJson(snapshot.data() ?? {});
  }

  Future<Company> createUpdateCompany(Company company,
      [auth.User? user]) async {
    try {
      var alreadyExists = company.id.isNotEmpty;
      if (alreadyExists) {
        await _db
            .collection(FirestoreCollections.companies)
            .doc(company.id)
            .update(company.toJson());
        return company;
      } else {
        var ref = await _db
            .collection(FirestoreCollections.companies)
            .add(company.toJson());
        await ref.update({'id': ref.id});
        company.id = ref.id;
        if (user != null) {
          var userData = await _db
              .collection(FirestoreCollections.users)
              .doc(user.uid)
              .get();
          var parsedUser = User.fromJson(userData.data() ?? {});
          parsedUser.companies.add(ref.id);
          await updateUser(parsedUser);
        }
        return company;
      }
    } on FirebaseException catch (error) {
      print(error);
      return Company();
    }
  }

  Future<void> deleteCompany(String companyId, [User? user]) async {
    try {
      await _db
          .collection(FirestoreCollections.companies)
          .doc(companyId)
          .delete();
      if (user != null) {
        user.companies.remove(companyId);
        await updateUser(user);
      }
    } on FirebaseException catch (error) {
      print(error);
    }
  }

  Stream<List<License>> listenToLicenses() {
    return _db
        .collection(FirestoreCollections.licenses)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => License.fromJson(doc.data())).toList();
    });
  }

  Future<List<License>> getLicenses([List<String>? licenseIds]) async {
    QuerySnapshot<Map<String, dynamic>> snapshot;
    if (licenseIds != null) {
      snapshot = await _db
          .collection(FirestoreCollections.licenses)
          .where(FieldPath.documentId, whereIn: licenseIds)
          .get();
    } else {
      snapshot = await _db.collection(FirestoreCollections.licenses).get();
    }
    return snapshot.docs.map((doc) => License.fromJson(doc.data())).toList();
  }

  Future<License> getLicense(String licenseId) async {
    var snapshot = await _db
        .collection(FirestoreCollections.licenses)
        .doc(licenseId)
        .get();
    return License.fromJson(snapshot.data() ?? {});
  }

  Future<License> createUpdateLicense(License license) async {
    try {
      var alreadyExists = license.id.isNotEmpty;
      if (alreadyExists) {
        await _db
            .collection(FirestoreCollections.licenses)
            .doc(license.id)
            .update(license.toJson());
        return license;
      } else {
        var ref = await _db
            .collection(FirestoreCollections.licenses)
            .add(license.toJson());
        await ref.update({'id': ref.id});
        license.id = ref.id;
        await updateCompanyLicense(license.company);
        return license;
      }
    } on FirebaseException catch (error) {
      print(error);
      return License(issuance: Timestamp.now(), validity: Timestamp.now());
    }
  }

  Future<License> deleteLicense(String licenseId) async {
    try {
      var license = await getLicense(licenseId);
      await _db
          .collection(FirestoreCollections.licenses)
          .doc(licenseId)
          .delete();

      await _db
          .collection(FirestoreCollections.companies)
          .doc(license.company)
          .update({
        'licenses': FieldValue.arrayRemove([licenseId])
      });
      return license;
    } on FirebaseException catch (error) {
      print(error);
      return License(issuance: Timestamp.now(), validity: Timestamp.now());
    }
  }

  Stream<User> getUserStream() {
    return AuthService().userStream.switchMap((user) {
      if (user == null) {
        return Stream.fromIterable([User()]);
      }
      var ref = _db.collection(FirestoreCollections.users).doc(user.uid);
      return ref.snapshots().map((doc) => User.fromJson(doc.data() ?? {}));
    });
  }

  Future<void> updateCompanyLicense(String companyId) async {
    var ref = _db.collection(FirestoreCollections.companies).doc(companyId);
    var licenses = await _db
        .collection(FirestoreCollections.licenses)
        .where('company', isEqualTo: companyId)
        .get();
    var licenseIds = licenses.docs.map((doc) => doc.id).toList();
    await ref.update({'licenses': licenseIds});
  }

  Future<void> updateUser(User user) async {
    var ref = _db.collection(FirestoreCollections.users).doc(user.uid);
    await ref.set(user.toJson(), SetOptions(merge: true));
  }
}

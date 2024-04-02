import 'package:companymanager/about/about.dart';
import 'package:companymanager/companies/companies.dart';
import 'package:companymanager/home/home.dart';
import 'package:companymanager/login/login.dart';
import 'package:companymanager/profile/profile.dart';

class AppRoutePath {
  static const home = '/';
  static const login = '/login';
  static const about = '/about';
  static const profile = '/profile';
  static const companies = '/companies';
}

class AppRouteLabel {
  static const home = 'Home';
  static const login = 'Login';
  static const about = 'About';
  static const profile = 'Profile';
  static const companies = 'Companies';
}

var appRoutes = {
  AppRoutePath.home: (context) => const HomeScreen(),
  AppRoutePath.login: (context) => const LoginScreen(),
  AppRoutePath.about: (context) => const AboutScreen(),
  AppRoutePath.companies: (context) => const CompaniesScreen(),
  AppRoutePath.profile: (context) => const ProfileScreen(),
};

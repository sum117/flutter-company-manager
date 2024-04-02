import 'package:companymanager/routes.dart';
import 'package:companymanager/services/firestore.dart';
import 'package:companymanager/services/models.dart';
import 'package:companymanager/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider(
      create: (_) => FirestoreService().getUserStream(),
      initialData: User(),
      child: MaterialApp(
        routes: appRoutes,
        theme: appTheme,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase_auth_app/bindings/root_binding.dart';
import 'package:flutter_firebase_auth_app/core/routers.dart';
import 'package:flutter_firebase_auth_app/firebase_options.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return GetMaterialApp(
      title: 'Flutter Firebase Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        textTheme: TextTheme(
          titleLarge: GoogleFonts.kanit(fontSize: 28),
          titleMedium:
              GoogleFonts.kanit(fontSize: 20, fontWeight: FontWeight.w400),
          titleSmall: GoogleFonts.kanit(fontSize: 14),
          bodyLarge: GoogleFonts.kanit(fontSize: 14),
          bodyMedium: GoogleFonts.kanit(fontSize: 18),
          bodySmall: GoogleFonts.kanit(fontSize: 16),
        ),
      ),
      initialBinding: RootBinding(),
      getPages: AppRouter.all,
      initialRoute: RoutePath.splash,
    );
  }
}

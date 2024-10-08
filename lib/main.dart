import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled2/constants/theme/theme.dart';
import 'package:untitled2/views/add_page/add_page.dart';
import 'package:untitled2/views/home_page/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
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
    return ProviderScope(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: myTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => const MyHomePage(
                title: 'Home',
              ),
          '/add': (context) => const AddPage(
                title: 'Add game',
              ),
        },
      ),
    );
  }
}

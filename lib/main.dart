import 'package:nexpay/core/themes/theme.dart';
import 'package:nexpay/features/navigation/pages/navigation_page.dart';
import 'package:nexpay/shared/services/isar/isar_service.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IsarService.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      // onGenerateRoute: AppRoute.onGenerateRoute,
      // initialRoute: FirebaseAuth.instance.currentUser != null
      //     ? RouteName.mainPage
      //     : RouteName.authPage,
      scrollBehavior: const ScrollBehavior().copyWith(
        overscroll: false,
        physics: const BouncingScrollPhysics(),
      ),
      home: NavigationPage(),
    );
  }
}

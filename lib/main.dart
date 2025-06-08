import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nexpay/core/routes/route.dart';
import 'package:nexpay/core/routes/route_name.dart';
import 'package:nexpay/core/themes/theme.dart';
import 'package:nexpay/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:nexpay/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:nexpay/shared/services/isar/isar_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await init();
  final isLoggedIn = await sl<IsarService>().isLoggedIn();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => sl<AuthCubit>()),
      ],
      child: MyApp(isLoggedIn: isLoggedIn),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.isLoggedIn});
  final bool isLoggedIn;
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
      onGenerateRoute: AppRoute.onGenerateRoute,
      initialRoute: widget.isLoggedIn ? RouteName.home : RouteName.onboarding,
      scrollBehavior: const ScrollBehavior().copyWith(
        overscroll: false,
        physics: const BouncingScrollPhysics(),
      ),
      // routes: {
      //   '/': (context) => const OnboardingPage(),
      //   '/auth': (context) =>
      //       const NavigationPage(),
      // },
    );
  }
}

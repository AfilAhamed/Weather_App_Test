import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'package:weather_app_task/features/home/presentation/provider/app_theme_provider.dart';
import 'package:weather_app_task/features/home/presentation/provider/home_provider.dart';
import 'package:weather_app_task/features/home/presentation/view/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('weather_box');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppThemeProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
      ],
      child: Consumer<AppThemeProvider>(
        builder: (context, themeProvider, child) {
          return ToastificationWrapper(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Weather App',
              themeMode: ThemeMode.system,
              theme: themeProvider.appThemeData,
              home: HomeScreen(),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather/core/theme.dart';
import 'package:weather/pages/weather/weather_consult_page.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance!.addObserver(this);
    PreferencesTheme.setTheme();

    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    PreferencesTheme.setTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: PreferencesTheme.theme,
      builder: (BuildContext context, Brightness theme, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(brightness: theme),
        home: const WeatherConsultPage(),
      ),
    );
  }
}

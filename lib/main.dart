import 'package:flutter/material.dart';
import 'package:nepali_wordel/constants/colors.dart';
import 'package:nepali_wordel/pages/settings.dart';
import 'package:nepali_wordel/providers/controller.dart';
import 'package:nepali_wordel/pages/home_page.dart';
import 'package:nepali_wordel/providers/theme_provider.dart';
import 'package:nepali_wordel/utils/theme_preferences.dart';
import 'package:nepali_wordel/constants/themes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Controller()),
        ChangeNotifierProvider(create: (_) => ThemeProvider())
      ],
      child: FutureBuilder(
        initialData: false,
        future: ThemePreferences.getTheme(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Provider.of<ThemeProvider>(context, listen: false)
                  .setTheme(turnOn: snapshot.data as bool);
            });
          }
          return Consumer<ThemeProvider>(
            builder: (_, notifier, __) => MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Nepali Wordel',
              theme: notifier.isDark ? darkTheme : lightTheme,
              home: const HomePage(),
            ),
          );
        },
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nepali_wordel/constants/themes.dart';
import 'package:nepali_wordel/providers/theme_provider.dart';
import 'package:nepali_wordel/utils/theme_preferences.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Settings'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.maybePop(context);
              },
              icon: const Icon(Icons.clear))
        ],
      ),
      body: Column(
        children: [
          Consumer<ThemeProvider>(
            builder: (_, notifier, __) {
              // theme: notifier.isDark ? darkTheme : lightTheme;

              bool _isSwitched = false;
              _isSwitched = notifier.isDark;

              return Consumer<ThemeProvider>(
                builder: (_a, _notifier, __a) {
                  return SwitchListTile(
                    title: Text(
                      'Dark Theme',
                      style: TextStyle(
                          color: _isSwitched ? Colors.white : Colors.black,fontWeight: FontWeight.bold),
                    ),
                    value: _isSwitched,
                    onChanged: (value) {
                      _isSwitched = value;
                      ThemePreferences.saveTheme(isDark: _isSwitched);
                      Provider.of<ThemeProvider>(context, listen: false)
                          .setTheme(turnOn: _isSwitched);
                    },
                  );
                },
              );
            },
          ),
          ListTile(
            leading: const Text('Reset'),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              prefs.remove('stats');
              prefs.remove('chart');
              prefs.remove('row');
              showDialog(
                  context: context,
                  builder: ((context) => const AlertDialog(
                        title: Text(
                          'Statistics Cleared',
                          textAlign: TextAlign.center,
                        ),
                      )));
              // prefs.remove('chart');
              // prefs.remove('row');
              // runQuickBox(context: context, message: 'Statistics Reset');
            },
          )
        ],
      ),
    );
  }

  // ListTile(
  //   leading: const Text('Reset'),
  //   onTap: () async {
  //     final prefs = await SharedPreferences.getInstance();
  //     prefs.remove('stats');
  //     prefs.remove('chart');
  //     prefs.remove('row');
  //     showDialog(
  //         context: context,
  //         builder: ((context) => const AlertDialog(
  //               title: Text(
  //                 'Statistics Cleared',
  //                 textAlign: TextAlign.center,
  //               ),
  //             )));
  //     // prefs.remove('chart');
  //     // prefs.remove('row');
  //     // runQuickBox(context: context, message: 'Statistics Reset');
  //   },
  // )

  // Consumer<ThemeProvider>(
  //   builder: (_, notifier, __) {
  //     _isSwitched = notifier.isDark;
  //     return SwitchListTile(
  //         value: _isSwitched,
  //         onChanged: (value) {
  //           _isSwitched = value;
  //           ThemePreferences.saveTheme(isDark: _isSwitched);
  // Provider.of<ThemeProvider>(context, listen: false)
  //     .setTheme(turnOn: _isSwitched);
  //         });
  //   },
  // )
  //   ]),
  // );
  // }
}

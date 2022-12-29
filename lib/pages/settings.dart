import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nepali_wordel/providers/theme_provider.dart';
import 'package:nepali_wordel/themes/theme_preferences.dart';
import 'package:provider/provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.maybePop(context);
              },
              icon: Icon(Icons.clear))
        ],
      ),
      body: Column(children: [
        Consumer<ThemeProvider>(
          builder: (_, notifier, __) {
            bool _isSwitched = false;

            _isSwitched = notifier.isDark;

            return SwitchListTile(
                value: _isSwitched,
                onChanged: (value) {
                  // setState(() {
                  _isSwitched = value;
                  // });
                  // print('is switched $_isSwitched');
                  ThemePreferences.saveTheme(isDark: _isSwitched);

                  Provider.of<ThemeProvider>(context, listen: false)
                      .setTheme(turnOn: _isSwitched);
                });
          },
        )

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
      ]),
    );
  }
}

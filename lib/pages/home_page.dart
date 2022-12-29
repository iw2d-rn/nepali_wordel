import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nepali_wordel/components/grid.dart';
import 'package:nepali_wordel/constants/worde.dart';
import 'package:nepali_wordel/pages/settings.dart';
import 'package:nepali_wordel/providers/controller.dart';
import 'package:nepali_wordel/data/keys_maps.dart';
import 'package:nepali_wordel/providers/theme_provider.dart';
import 'package:provider/provider.dart';

import '../components/keyboard_row.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String word;

  @override
  void initState() {
    final r = Random().nextInt(words.length);
    word = words[r];
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<Controller>(context, listen: false)
          .setCorrectWord(word: word);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wordel'),
        centerTitle: true,
        elevation: 0,
         actions: [
          IconButton(
              onPressed: () {
                // Provider.of<ThemeProvider>(context,listen: false).setTheme();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Settings()));
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: Column(children: [
        const Divider(
          thickness: 2,
          height: 1,
        ),
        const Expanded(
          flex: 8,
          child: Grid(),
        ),
        Expanded(
            flex: 3,
            child: Column(
              children: const [
                KeyboardRow(
                  min: 1,
                  max: 10,
                ),
                KeyboardRow(
                  min: 11,
                  max: 20,
                ),
                KeyboardRow(
                  min: 21,
                  max: 30,
                ),
                KeyboardRow(
                  min: 31,
                  max: 40,
                ),
                KeyboardRow(
                  min: 41,
                  max: 50,
                ),
                KeyboardRow(
                  min: 51,
                  max: 60,
                ),
                KeyboardRow(
                  min: 61,
                  max: 69,
                ),
              ],
            ))
      ]),
    );
  }
}

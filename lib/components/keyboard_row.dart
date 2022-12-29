import 'package:flutter/material.dart';
import 'package:nepali_wordel/constants/colors.dart';
import 'package:nepali_wordel/constants/keybord_states.dart';
import 'package:nepali_wordel/providers/controller.dart';
import 'package:provider/provider.dart';

import '../data/keys_maps.dart';

class KeyboardRow extends StatelessWidget {
  const KeyboardRow({
    required this.min,
    required this.max,
    Key? key,
  }) : super(key: key);

  final int min, max;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<Controller>(
      builder: (_, notifier, __) {
        int index = 0;
        return IgnorePointer(
          ignoring: notifier.gameCompleted,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: keysMap.entries.map((e) {
              index++;
              if (index >= min && index <= max) {
                // Color color = Colors.grey;
                Color color = Theme.of(context).primaryColorLight;
                Color keyColor = Colors.white;
                if (e.value == KeyboardStates.correct) {
                  color = correctGreen;
                } else if (e.value == KeyboardStates.contains) {
                  color = containsYellow;
                } else if (e.value == KeyboardStates.incorrect) {
                  color = Theme.of(context).primaryColorDark;
                } else {
                  keyColor = Theme.of(context).textTheme.bodyText2?.color ??
                      Colors.black;
                }
                return Padding(
                    padding: EdgeInsets.all(size.width * 0.003),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: SizedBox(
                            child: Container(
                                width: e.key == "ENTER" || e.key == "BACK"
                                    ? size.width * 0.1
                                    : size.width * 0.08,
                                height: size.height * 0.03,
                                child: Material(
                                  color: color,
                                  child: InkWell(
                                      onTap: () {
                                        Provider.of<Controller>(context,
                                                listen: false)
                                            .setKeyTapped(value: e.key);
                                      },
                                      child: Center(
                                          child: e.key == 'BACK'
                                              ? const Icon(
                                                  Icons.backspace_outlined)
                                              : Text(
                                                  e.key,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      ?.copyWith(
                                                        color: keyColor,
                                                      ),
                                                ))),
                                )))));
              } else {
                return const SizedBox();
              }
            }).toList(),
          ),
        );
      },
    );
  }
}

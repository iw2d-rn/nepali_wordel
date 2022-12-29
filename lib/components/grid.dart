import 'package:flutter/material.dart';
import 'package:nepali_wordel/animations/bounce.dart';
import 'package:nepali_wordel/components/tile.dart';
import 'package:nepali_wordel/providers/controller.dart';
import 'package:provider/provider.dart';

class Grid extends StatelessWidget {
  const Grid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics:const NeverScrollableScrollPhysics(),
        padding:const EdgeInsets.fromLTRB(36, 10, 36, 10),
        itemCount: 40,
        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 4, crossAxisSpacing: 4, crossAxisCount: 5),
        itemBuilder: ((context, index) {
          return Consumer<Controller>(
            builder: (_, notifier, __) {
              bool animate = false;
              if (index == notifier.currentTile-1 && !notifier.isBackEnter) {
                animate = true;
              }
              return Bounce(
                  animate: animate,
                  child: Tile(
                    index: index,
                  ));
            },
          );
        }));
  }
}

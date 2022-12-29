import 'package:flutter/material.dart';
import 'package:nepali_wordel/components/tile.dart';

class Grid extends StatelessWidget {
  const Grid({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(36, 10, 36, 10),
        itemCount: 40,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 4, crossAxisSpacing: 4, crossAxisCount: 5),
        itemBuilder: ((context, index) {
          return Tile(index: index,);
        }));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:nepali_wordel/components/stats_chart.dart';
import 'package:nepali_wordel/constants/themes.dart';
import 'package:nepali_wordel/models/chart_model.dart';
import 'package:nepali_wordel/providers/theme_provider.dart';
import 'package:nepali_wordel/utils/calculate_stats.dart';
import 'package:nepali_wordel/components/stats_tile.dart';
import 'package:nepali_wordel/constants/keybord_states.dart';
import 'package:nepali_wordel/data/keys_maps.dart';
import 'package:nepali_wordel/main.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:nepali_wordel/utils/chart_series.dart';
import 'package:provider/provider.dart';

class StatBox extends StatelessWidget {
  const StatBox({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<ThemeProvider>(
      builder: (_, notifier, __) {
        return AlertDialog(
          insetPadding: EdgeInsets.fromLTRB(size.width * 0.08,
              size.height * 0.12, size.width * 0.08, size.height * 0.12),
          backgroundColor: notifier.isDark ? Colors.black : Colors.white,
          // backgroundColor: Colors.black,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              IconButton(
                alignment: Alignment.centerRight,
                onPressed: () {
                  Navigator.maybePop(context);
                },
                icon: Icon(Icons.clear),
                color: notifier.isDark ? Colors.white : Colors.black,
              ),
              Expanded(
                  child: Text(
                "STATISTICS",
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: notifier.isDark ? Colors.white : Colors.black,
                    ),
                textAlign: TextAlign.center,
              )),
              Expanded(
                flex: 2,
                child: FutureBuilder(
                  future: getStats(),
                  builder: (context, snapshot) {
                    List<String> results = ['0', '0', '0', '0', '0'];
                    if (snapshot.hasData) {
                      results = snapshot.data as List<String>;
                    }
                    return Row(
                      children: [
                        StatsTile(
                          heading: 'Played',
                          value: int.parse(results[0]),
                        ),
                        StatsTile(
                            heading: 'Win %', value: int.parse(results[2])),
                        StatsTile(
                            heading: 'Current\nStreak',
                            value: int.parse(results[3])),
                        StatsTile(
                            heading: 'Max\nStreak',
                            value: int.parse(results[4])),
                      ],
                    );
                  },
                ),
              ),
              Expanded(
                flex: 8,
                child: StatsChart(),
              ),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    keysMap.updateAll(
                        (key, value) => value = KeyboardStates.notAnswered);

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp()),
                        (route) => false);
                  },
                  child: Text(
                    'Replay',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

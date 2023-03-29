import 'package:flutter/material.dart';
import 'package:oural_go/ui/cards/daily_percentage_card.dart';
import 'package:oural_go/ui/cards/hour_card.dart';
import 'package:oural_go/ui/cards/price_card.dart';
import 'package:oural_go/ui/cards/probability_card.dart';
import 'package:oural_go/ui/widgets/other/display_dates_sidebar.dart';
import 'package:oural_go/utils/constants.dart';
import 'package:intl/intl.dart';

class DisplayUnlockedTablePrices extends StatelessWidget {
  const DisplayUnlockedTablePrices({
    Key? key,
    required this.hours,
    required this.dates,
    required this.performance,
    required this.numberFormat,
    required this.prices,
    required this.probabilities,
  }) : super(key: key);

  final List<String> hours;
  final List<String> dates;
  final List<List<String>> performance;
  final NumberFormat numberFormat;
  final List<List<double>> prices;
  final List<double> probabilities;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kMainBGcolor,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            DisplayDatesSideBar(dates: dates),
            Padding(
              padding: EdgeInsets.all(kPadding / 2),
              child: Column(
                children: [
                  Row(
                    children: [
                      ...List.generate(
                        hours.length,
                        (index) {
                          return HourCard(
                            hours: hours,
                            index: index,
                          );
                        },
                      ),
                      Container(
                        width: 110,
                        //height: 10,
                        color: kMainBGcolor,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Performance',
                            style: TextStyle(
                              color: kTextColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // hours ^ ^
                  SizedBox(height: kPadding / 2),
                  // prices v v
                  ...List.generate(
                    dates.length,
                    (i) {
                      double dailyPerformance = double.parse(
                          '${(((prices[i][hours.length - 1] - prices[i][0]) / prices[i][0]) * 100)}');
                      double priceMovement =
                          prices[i][hours.length - 1] - prices[i][0];
                      return Column(
                        children: [
                          Row(
                            children: [
                              ...List.generate(
                                hours.length,
                                (j) {
                                  String price =
                                      '\$${numberFormat.format(prices[i][j])}';

                                  Widget icon = Icon(
                                    Icons.add,
                                    size: 12,
                                    color: kMainBGcolor,
                                  );
                                  Color iconBG = kMainBGcolor;

                                  String letter = '';
                                  if (j != hours.length - 1) {
                                    letter = performance[i][j];
                                    icon = determineIcon(letter);
                                    iconBG = determineColor(letter);
                                  }

                                  return PriceCard(
                                    price: price,
                                    iconBG: iconBG,
                                    icon: icon,
                                  );
                                },
                              ),
                              DailyPercentageCard(
                                dailyPerformance: dailyPerformance,
                                priceMovement: priceMovement,
                              ),
                            ],
                          ),
                          i != dates.length - 1
                              ? SizedBox(height: kPadding / 2)
                              : const SizedBox()
                        ],
                      );
                    },
                  ),
                  // prices ^ ^
                  SizedBox(height: kPadding / 2),
                  // probabilities v v
                  Row(
                    children: [
                      ...List.generate(
                        probabilities.length,
                        (index) {
                          String probability =
                              '${(probabilities[index] * 100).toStringAsFixed(2)} %';

                          return ProbabilityCard(
                            probability: probability,
                          );
                        },
                      ),
                      Container(
                        width: 110,
                        height: 10,
                        color: kMainBGcolor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color determineColor(String letter) {
    if (letter == 'U') {
      return kBullish.withOpacity(0.2);
    } else if (letter == 'D') {
      return kBearish.withOpacity(0.2);
    } else {
      return kAccentColor.withOpacity(0.6);
    }
  }

  Widget determineIcon(String letter) {
    if (letter == 'U') {
      return Icon(
        Icons.call_made_rounded,
        color: kBullish,
        size: 16,
      );
    } else if (letter == 'D') {
      return RotationTransition(
        turns: const AlwaysStoppedAnimation(270 / 360),
        child: Icon(
          Icons.call_received_rounded,
          color: kBearish,
          size: 16,
        ),
      );
    } else {
      return Icon(
        //Icons.arrow_right_alt,
        Icons.arrow_forward,
        color: kTextColor,
        size: 16,
      );
    }
  }
}

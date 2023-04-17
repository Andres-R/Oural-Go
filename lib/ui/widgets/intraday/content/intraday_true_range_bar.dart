import 'package:flutter/material.dart';
import 'package:oural_go/data/models/intraday_info_container.dart';
import 'package:oural_go/utils/constants.dart';
import 'package:intl/intl.dart';

class IntradayTrueRangeBar extends StatelessWidget {
  const IntradayTrueRangeBar({
    Key? key,
    required this.containers,
    required this.numberFormat,
    required this.standardDeviation,
  }) : super(key: key);

  final List<IntradayInfoContainer> containers;
  final NumberFormat numberFormat;
  final double standardDeviation;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(),
      width: 80,
      child: Container(
        margin: const EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          boxShadow: [
            BoxShadow(
              color: kAccentColor,
              blurRadius: 5,
              //spreadRadius: 8,
            )
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(kPadding / 2),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'TR',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              SizedBox(height: kPadding / 2),
              ...List.generate(
                containers.length,
                (index) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '\$${numberFormat.format((containers[index].open + containers[index].intradayHigh) - (containers[index].open - containers[index].intradayLow))}',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      SizedBox(height: kPadding / 2),
                    ],
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Avg.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              SizedBox(height: kPadding / 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '\$${numberFormat.format(getAverageTrueRange())}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              SizedBox(height: kPadding / 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'SD',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              SizedBox(height: kPadding / 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('\$${numberFormat.format(standardDeviation)}',
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
              SizedBox(height: kPadding / 2),
            ],
          ),
        ),
      ),
    );
  }

  double getAverageTrueRange() {
    double sum = 0;
    for (final item in containers) {
      sum += ((item.open + item.intradayHigh) - (item.open - item.intradayLow));
    }
    return sum / containers.length;
  }
}

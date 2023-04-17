import 'package:flutter/material.dart';
import 'package:oural_go/data/models/intraday_info_container.dart';
import 'package:intl/intl.dart';
import 'package:oural_go/utils/constants.dart';

class IntradayLowPriceBar extends StatelessWidget {
  const IntradayLowPriceBar({
    Key? key,
    required this.containers,
    required this.numberFormat,
  }) : super(key: key);

  final List<IntradayInfoContainer> containers;
  final NumberFormat numberFormat;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: Padding(
        padding: EdgeInsets.all(kPadding / 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Low',
              style: Theme.of(context).textTheme.bodyMedium,
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
                          '\$${numberFormat.format(containers[index].open - containers[index].intradayLow)}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                    SizedBox(height: kPadding / 2),
                  ],
                );
              },
            ),
            const Text(''),
            SizedBox(height: kPadding / 2),
            const Text(''),
            SizedBox(height: kPadding / 2),
            const Text(''),
            SizedBox(height: kPadding / 2),
            const Text(''),
            SizedBox(height: kPadding / 2),
          ],
        ),
      ),
    );
  }
}

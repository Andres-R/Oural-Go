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
    return Container(
      color: kMainBGcolor,
      width: 80,
      child: Padding(
        padding: EdgeInsets.all(kPadding / 2),
        child: Column(
          children: [
            Text(
              'Low',
              style: TextStyle(color: kTextColor),
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
                          style: TextStyle(
                            color: kTextColor,
                          ),
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
          ],
        ),
      ),
    );
  }
}

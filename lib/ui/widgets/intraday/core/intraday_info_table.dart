import 'package:flutter/material.dart';
import 'package:oural_go/data/models/intraday_info_container.dart';
import 'package:oural_go/ui/widgets/intraday/content/intraday_high_info_bar.dart';
import 'package:oural_go/ui/widgets/intraday/content/intraday_high_price_bar.dart';
import 'package:oural_go/ui/widgets/intraday/content/intraday_low_info_bar.dart';
import 'package:oural_go/ui/widgets/intraday/content/intraday_low_price_bar.dart';
import 'package:oural_go/ui/widgets/intraday/content/intraday_open_price_bar.dart';
import 'package:oural_go/utils/constants.dart';
import 'package:intl/intl.dart';

class IntradayInfoTable extends StatelessWidget {
  const IntradayInfoTable({
    Key? key,
    required this.containers,
    required this.numberFormat,
    required this.averageIntradayLow,
    required this.averageIntradayHigh,
  }) : super(key: key);

  final List<IntradayInfoContainer> containers;
  final NumberFormat numberFormat;
  final double averageIntradayLow;
  final double averageIntradayHigh;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            width: 135,
          ),
          IntradayLowPriceBar(
            containers: containers,
            numberFormat: numberFormat,
          ),
          IntradayLowInfoBar(
            containers: containers,
            averageLow: averageIntradayLow,
          ),
          IntradayOpenPriceBar(
            containers: containers,
            numberFormat: numberFormat,
          ),
          IntradayHighInfoBar(
            containers: containers,
            averageHigh: averageIntradayHigh,
          ),
          IntradayHighPriceBar(
            containers: containers,
            numberFormat: numberFormat,
          ),
        ],
      ),
    );
  }
}

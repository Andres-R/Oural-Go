import 'package:flutter/material.dart';
import 'package:oural_go/utils/constants.dart';

class DailyPercentageCard extends StatelessWidget {
  const DailyPercentageCard({
    Key? key,
    required this.dailyPerformance,
    required this.priceMovement,
  }) : super(key: key);

  final double dailyPerformance;
  final double priceMovement;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      //height: 10,
      //color: kMainBGcolor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
              color: dailyPerformance > 0
                  ? kBullish.withOpacity(0.2)
                  : kBearish.withOpacity(0.2),
            ),
            child: Text(
              dailyPerformance > 0
                  ? '+${dailyPerformance.toStringAsFixed(2)}%'
                  : '${dailyPerformance.toStringAsFixed(2)}%',
              style: TextStyle(
                color: dailyPerformance > 0 ? kBullish : kBearish,
              ),
            ),
          ),
          Text(
            priceMovement > 0
                ? '\$${priceMovement.toStringAsFixed(2)}'
                : '${priceMovement.toString()[0]}\$${priceMovement.toStringAsFixed(2).substring(1)}',
            style: TextStyle(
              color: kTextColor,
            ),
          ),
        ],
      ),
    );
  }
}

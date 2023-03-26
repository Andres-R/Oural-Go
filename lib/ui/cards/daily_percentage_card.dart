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
    return Container(
      width: 110,
      //height: 10,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
              color: dailyPerformance > 0
                  ? Colors.green.withOpacity(0.2)
                  : Colors.red.withOpacity(0.2),
            ),
            child: Text(
              dailyPerformance > 0
                  ? '+${dailyPerformance.toStringAsFixed(2)}%'
                  : '${dailyPerformance.toStringAsFixed(2)}%',
              style: TextStyle(
                color: dailyPerformance > 0 ? Colors.green : Colors.red,
              ),
            ),
          ),
          Text(
            priceMovement > 0
                ? '\$${priceMovement.toStringAsFixed(2)}'
                : '${priceMovement.toString()[0]}\$${priceMovement.toStringAsFixed(2).substring(1)}',
          ),
        ],
      ),
    );
  }
}

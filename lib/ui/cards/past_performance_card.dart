import 'package:flutter/material.dart';
import 'package:oural_go/utils/constants.dart';
import 'package:oural_go/utils/utils.dart';

class PastPerformanceCard extends StatelessWidget {
  const PastPerformanceCard({
    Key? key,
    required this.value,
    required this.description,
  }) : super(key: key);

  final double value;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: determineBGColor(value),
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(kPadding / 4),
            child: Text(
              '${value.toStringAsFixed(2)}%',
              style: TextStyle(
                fontSize: 18,
                color: determineTextColor(
                  value,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: kPadding / 4),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          child: Text(
            description,
            style: TextStyle(
              color: kTextColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

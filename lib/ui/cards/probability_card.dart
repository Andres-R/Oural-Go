import 'package:flutter/material.dart';
import 'package:oural_go/utils/constants.dart';

class ProbabilityCard extends StatelessWidget {
  const ProbabilityCard({
    Key? key,
    required this.probability,
  }) : super(key: key);

  final String probability;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: outerCardWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: innerCardWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  probability,
                  style: TextStyle(
                    color: kBullish,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: kPadding,
            width: kPadding,
          )
        ],
      ),
    );
  }
}

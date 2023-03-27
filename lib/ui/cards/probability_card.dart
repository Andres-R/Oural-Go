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
    return Container(
      width: outerCardWidth,
      color: kMainBGcolor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            color: kMainBGcolor,
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
          Container(
            height: kPadding,
            width: kPadding,
            color: kMainBGcolor,
          )
        ],
      ),
    );
  }
}

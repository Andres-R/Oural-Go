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
      color: kCardBGcolor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            color: kCardBGcolor,
            width: innerCardWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  probability,
                  style: const TextStyle(
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 16,
            width: 16,
            color: kCardBGcolor,
          )
        ],
      ),
    );
  }
}

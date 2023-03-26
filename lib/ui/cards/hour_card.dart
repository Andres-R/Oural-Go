import 'package:flutter/material.dart';
import 'package:oural_go/utils/constants.dart';

class HourCard extends StatelessWidget {
  const HourCard({
    Key? key,
    required this.hours,
    required this.index,
  }) : super(key: key);

  final List<String> hours;
  final int index;

  @override
  Widget build(BuildContext context) {
    final parts = hours[index].split(':');
    final hour = '${parts[0]}:${parts[1]}';

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
                  hour,
                  style: const TextStyle(
                    color: Colors.black,
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

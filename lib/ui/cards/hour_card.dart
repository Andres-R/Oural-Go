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
                  hour,
                  style: Theme.of(context).textTheme.bodyMedium,
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

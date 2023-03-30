import 'package:flutter/material.dart';
import 'package:oural_go/utils/constants.dart';

class PriceCard extends StatelessWidget {
  const PriceCard({
    Key? key,
    required this.price,
    required this.iconBG,
    required this.icon,
  }) : super(key: key);

  final String price;
  final Color iconBG;
  final Widget icon;

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
                  price,
                  style: TextStyle(
                    color: kTextColor,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: kPadding,
            width: kPadding,
            decoration: BoxDecoration(
              color: iconBG,
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Center(
              child: icon,
            ),
          ),
        ],
      ),
    );
  }
}

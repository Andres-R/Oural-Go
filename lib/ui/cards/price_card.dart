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
                // Container(
                //   width: 2,
                //   height: 10,
                //   color: Colors
                //       .orange,
                // ),
                Text(price),
              ],
            ),
          ),
          Container(
            height: 16,
            width: 16,
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

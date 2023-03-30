import 'package:flutter/material.dart';
import 'package:oural_go/utils/constants.dart';

class BottomInfoBar extends StatelessWidget {
  const BottomInfoBar({
    Key? key,
    required this.dates,
    required this.ticker,
  }) : super(key: key);

  final List<String> dates;
  final String ticker;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(kPadding),
      child: Column(
        children: [
          Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: kPadding,
                width: kPadding,
                decoration: BoxDecoration(
                  color: kBullish.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.call_made_rounded,
                    color: kBullish,
                    size: 16,
                  ),
                ),
              ),
              SizedBox(width: kPadding),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Denotes increase of asset price between a 30',
                    style: TextStyle(
                      color: kTextColor,
                    ),
                  ),
                  Text(
                    'min interval',
                    style: TextStyle(
                      color: kTextColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: kPadding),
          Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: kPadding,
                width: kPadding,
                decoration: BoxDecoration(
                  color: kBearish.withOpacity(0.2),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: Center(
                  child: RotationTransition(
                    turns: const AlwaysStoppedAnimation(270 / 360),
                    child: Icon(
                      Icons.call_received_rounded,
                      color: kBearish,
                      size: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(width: kPadding),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Denotes decrease of asset price between a 30',
                    style: TextStyle(
                      color: kTextColor,
                    ),
                  ),
                  Text(
                    'min interval',
                    style: TextStyle(
                      color: kTextColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: kPadding),
          Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: kPadding,
                width: kPadding,
                decoration: BoxDecoration(
                  color: kAccentColor.withOpacity(0.6),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: Center(
                  child: Icon(
                    //Icons.arrow_right_alt,
                    Icons.arrow_forward,
                    color: kTextColor,
                    size: 16,
                  ),
                ),
              ),
              SizedBox(width: kPadding),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Denotes no change of asset price between a 30',
                    style: TextStyle(
                      color: kTextColor,
                    ),
                  ),
                  Text(
                    'min interval',
                    style: TextStyle(
                      color: kTextColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: kPadding),
          Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: kPadding,
                width: kPadding,
                child: Center(
                  child: Text(
                    '%',
                    style: TextStyle(
                      color: kBullish,
                    ),
                  ),
                ),
              ),
              SizedBox(width: kPadding),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Denotes probability of  ',
                        style: TextStyle(
                          color: kTextColor,
                        ),
                      ),
                      Container(
                        height: kPadding,
                        width: kPadding,
                        decoration: BoxDecoration(
                          color: kBullish.withOpacity(0.2),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.call_made_rounded,
                            color: kBullish,
                            size: 16,
                          ),
                        ),
                      ),
                      Text(
                        '  occuring over',
                        style: TextStyle(
                          color: kTextColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'the past ${dates.length} trading days for $ticker',
                    style: TextStyle(
                      color: kTextColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: kPadding),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:oural_go/utils/constants.dart';

class IntradayBottomInfoBar extends StatelessWidget {
  const IntradayBottomInfoBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(kPadding),
      child: Column(
        children: [
          Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TR',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(width: kPadding),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '(True Range) denotes difference between',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'price high and low of a stock for a given day',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: kPadding),
          Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SD',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(width: kPadding),
              Text(
                '(Standard Deviation)',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

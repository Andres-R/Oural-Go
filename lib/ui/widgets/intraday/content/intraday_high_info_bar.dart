import 'package:flutter/material.dart';
import 'package:oural_go/data/models/intraday_info_container.dart';
import 'package:oural_go/utils/constants.dart';

class IntradayHighInfoBar extends StatelessWidget {
  const IntradayHighInfoBar({
    Key? key,
    required this.containers,
    required this.averageHigh,
  }) : super(key: key);

  final List<IntradayInfoContainer> containers;
  final double averageHigh;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(kPadding / 2),
      child: Column(
        children: [
          const Text(''),
          SizedBox(height: kPadding / 2),
          ...List.generate(
            containers.length,
            (index) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: kBullish.withOpacity(0.2),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Text(
                          '+${containers[index].intradayHigh.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: kBullish,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: kPadding / 2),
                ],
              );
            },
          ),
          Text(
            'Avg.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: kPadding / 2),
          Container(
            decoration: BoxDecoration(
              color: kBullish.withOpacity(0.2),
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Text(
              '+${averageHigh.toStringAsFixed(2)}',
              style: TextStyle(
                color: kBullish,
              ),
            ),
          ),
          SizedBox(height: kPadding / 2),
        ],
      ),
    );
  }
}

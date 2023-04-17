import 'package:flutter/material.dart';
import 'package:oural_go/utils/constants.dart';

class IntradayDatesSideBar extends StatelessWidget {
  const IntradayDatesSideBar({
    Key? key,
    required this.dates,
  }) : super(key: key);

  final List<String> dates;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(),
      width: 135,
      child: Container(
        margin: const EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          boxShadow: [
            BoxShadow(
              color: kAccentColor,
              blurRadius: 5,
              //spreadRadius: 8,
            )
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(kPadding / 2),
          child: Column(
            children: [
              Text(
                'Dates',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: kPadding / 2),
              ...List.generate(
                dates.length,
                (index) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 20,
                            //color: Colors.purple,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  (index + 1).toString(),
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            //width: 40,
                            //color: Colors.red,
                            child: Text(
                              dates[index],
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: kPadding / 2),
                    ],
                  );
                },
              ),
              const Text(''),
              SizedBox(height: kPadding / 2),
              const Text(''),
              SizedBox(height: kPadding / 2),
              const Text(''),
              SizedBox(height: kPadding / 2),
              const Text(''),
              SizedBox(height: kPadding / 2),
            ],
          ),
        ),
      ),
    );
  }
}

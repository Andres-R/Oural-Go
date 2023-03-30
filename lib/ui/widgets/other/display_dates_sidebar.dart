import 'package:flutter/material.dart';
import 'package:oural_go/utils/constants.dart';

class DisplayDatesSideBar extends StatelessWidget {
  const DisplayDatesSideBar({
    Key? key,
    required this.dates,
  }) : super(key: key);

  final List<String> dates;

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.green,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(),
      //height: 200,
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
              Text(
                '%',
                style: TextStyle(
                  color: kBullish,
                ),
              ),
              //const SizedBox(height: 8),

              //const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

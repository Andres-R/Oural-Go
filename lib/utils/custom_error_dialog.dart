import 'package:flutter/material.dart';
import 'package:oural_go/utils/constants.dart';

void showCustomErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return CustomErrorDialog(
        title: message,
      );
    },
  );
}

class CustomErrorDialog extends StatelessWidget {
  const CustomErrorDialog({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(kBorderRadius),
        ),
      ),
      backgroundColor: kMainBGcolor,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          SizedBox(
            height: 250,
            child: Padding(
              padding: EdgeInsets.all(kPadding),
              child: Column(
                children: [
                  SizedBox(height: kPadding * 4),
                  Text(
                    "Error",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kTextColor,
                      fontSize: 32,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      color: kAccentColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: kPadding),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 45,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: kTextColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(kBorderRadius + 5),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Okay",
                          style: TextStyle(
                            color: kMainBGcolor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -40,
            child: CircleAvatar(
              backgroundColor: kThemeColor,
              radius: 50,
              child: Center(
                child: Icon(
                  Icons.error,
                  size: 95,
                  color: kMainBGcolor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

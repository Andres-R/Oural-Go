import 'package:flutter/material.dart';

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
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      backgroundColor: Colors.white,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          SizedBox(
            height: 250,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(height: 64),
                  Text(
                    "Error",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 32,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      height: 45,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Okay",
                          style: TextStyle(
                            color: Colors.white,
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
              backgroundColor: Colors.black,
              radius: 50,
              child: Center(
                child: Icon(
                  Icons.error,
                  size: 95,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

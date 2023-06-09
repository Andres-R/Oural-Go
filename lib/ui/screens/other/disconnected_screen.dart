import 'package:flutter/material.dart';
import 'package:oural_go/utils/constants.dart';

class DisconnectedScreen extends StatelessWidget {
  const DisconnectedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(kPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Uh Oh!',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium!.color,
                fontSize: 42,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Something went wrong...',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium!.color,
                fontSize: kTitleText,
              ),
            ),
            SizedBox(height: kPadding * 2),
            Text(
              'Check your internet connection or try restarting app. Attempting to reconnect...',
              style: TextStyle(
                color: kAccentColor,
                fontSize: kTitleText,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: kPadding * 4),
            CircularProgressIndicator(
              color: Theme.of(context).textTheme.bodyMedium!.color,
            ),
          ],
        ),
      ),
    );
  }
}

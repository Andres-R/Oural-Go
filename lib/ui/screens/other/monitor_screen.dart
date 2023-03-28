import 'dart:async';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:oural_go/ui/screens/general/home_screen.dart';
import 'package:oural_go/ui/screens/other/disconnected_screen.dart';

class MonitorScreen extends StatefulWidget {
  const MonitorScreen({Key? key}) : super(key: key);

  @override
  State<MonitorScreen> createState() => _MonitorScreenState();
}

class _MonitorScreenState extends State<MonitorScreen> {
  late StreamSubscription internetSubscription;
  bool hasInternet = false;

  @override
  void initState() {
    super.initState();
    internetSubscription = InternetConnectionChecker().onStatusChange.listen(
      (status) {
        final hasInternet = status == InternetConnectionStatus.connected;
        setState(() {
          this.hasInternet = hasInternet;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return hasInternet ? const HomeScreen() : const DisconnectedScreen();
  }
}

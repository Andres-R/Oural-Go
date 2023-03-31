import 'dart:async';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:oural_go/cubit/improved_internet_cubit.dart';
import 'package:oural_go/ui/screens/general/home_screen.dart';
import 'package:oural_go/ui/screens/other/disconnected_screen.dart';
import 'package:oural_go/ui/screens/other/loading_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MonitorScreen extends StatelessWidget {
  const MonitorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ImprovedInternetCubit>(
      create: (_) => ImprovedInternetCubit(),
      child: BlocBuilder<ImprovedInternetCubit, ImprovedInternetState>(
        builder: (_, connectionState) {
          if (connectionState is InternetLoading) {
            return const LoadingScreen();
          }
          if (connectionState is InternetConnected) {
            return const HomeScreen();
          }
          return const DisconnectedScreen();
        },
      ),
    );
  }
}

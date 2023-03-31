import 'package:flutter/material.dart';
import 'package:oural_go/cubit/internet_cubit.dart';
import 'package:oural_go/ui/screens/general/home_screen.dart';
import 'package:oural_go/ui/screens/other/disconnected_screen.dart';
import 'package:oural_go/ui/screens/other/loading_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MonitorConnectionScreen extends StatelessWidget {
  const MonitorConnectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<InternetCubit>(
      create: (_) => InternetCubit(),
      child: BlocBuilder<InternetCubit, InternetState>(
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

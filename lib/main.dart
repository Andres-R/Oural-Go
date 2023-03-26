import 'package:flutter/material.dart';
import 'package:oural_go/ui/screens/home_screen.dart';
import 'package:oural_go/ui/screens/ticker_info_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        if (settings.name == TickerInfoScreen.routeName) {
          final args = settings.arguments as TickerInfoScreenArguments;
          return MaterialPageRoute(
            builder: (_) {
              return BlocProvider.value(
                value: args.cubit,
                child: TickerInfoScreen(ticker: args.ticker),
              );
            },
          );
        }
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
      home: const HomeScreen(),
      // home: TickerInfoScreen(
      //   ticker: 'MSFT',
      // ),
    );
  }
}

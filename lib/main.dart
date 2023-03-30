import 'package:flutter/material.dart';
import 'package:oural_go/ui/screens/general/ticker_info_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oural_go/ui/screens/other/monitor_screen.dart';
import 'package:oural_go/utils/themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
      home: const MonitorScreen(),
    );
  }

  Route? onGenerateRoute(RouteSettings settings) {
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
  }
}



















// import 'package:flutter/material.dart';
// import 'package:oural_go/ui/screens/general/ticker_info_screen.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:oural_go/ui/screens/other/monitor_screen.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//           // works
//           // appBarTheme: const AppBarTheme(
//           //   backgroundColor: Colors.orange,
//           // ),
//           // works
//           // scaffoldBackgroundColor: Colors.purple,
//           ),
//       debugShowCheckedModeBanner: false,
//       onGenerateRoute: onGenerateRoute,
//       home: const MonitorScreen(),
//     );
//   }

//   Route? onGenerateRoute(RouteSettings settings) {
//     if (settings.name == TickerInfoScreen.routeName) {
//       final args = settings.arguments as TickerInfoScreenArguments;
//       return MaterialPageRoute(
//         builder: (_) {
//           return BlocProvider.value(
//             value: args.cubit,
//             child: TickerInfoScreen(ticker: args.ticker),
//           );
//         },
//       );
//     }
//     assert(false, 'Need to implement ${settings.name}');
//     return null;
//   }
// }


















// import 'package:flutter/material.dart';
// import 'package:oural_go/connection/connection_type.dart';
// import 'package:oural_go/cubit/internet_cubit.dart';
// import 'package:oural_go/ui/screens/home_screen.dart';
// import 'package:oural_go/ui/screens/ticker_info_screen.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:oural_go/utils/constants.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   MyApp({
//     Key? key,
//   }) : super(key: key);

//   final Connectivity connectivity = Connectivity();

//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (context) => InternetCubit(connectivity: connectivity),
//         ),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         onGenerateRoute: onGenerateRoute,
//         // home: BlocBuilder<InternetCubit, InternetState>(
//         //   builder: (_, state) {
//         //     if (state is InternetConnected) {
//         //       return const HomeScreen();
//         //     } else if (state is InternetDisconnected) {
//         //       return const DisconnnectedScreen();
//         //     } else {
//         //       return const LoadingScreen();
//         //     }
//         //   },
//         // ),
//         home: StreamBuilder<ConnectivityResult>(
//           stream: connectivity.onConnectivityChanged,
//           builder: (_, snapshot) {
//             if (snapshot.connectionState != ConnectionState.active) {
//               return const LoadingScreen();
//             }
//             if (!snapshot.hasData) {
//               return const LoadingScreen();
//             }
//             ConnectivityResult result = snapshot.data!;
//             if (result == ConnectivityResult.wifi ||
//                 result == ConnectivityResult.mobile) {
//               return const HomeScreen();
//             } else {
//               return const DisconnnectedScreen();
//             }
//           },
//         ),
//       ),
//     );
//   }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oural_go/cubit/favorite_items_cubit.dart';
import 'package:oural_go/cubit/ticker_info_cubit.dart';
import 'package:oural_go/data/models/intraday_info_container.dart';
import 'package:intl/intl.dart';
import 'package:oural_go/ui/cards/past_performance_card.dart';

import 'package:oural_go/ui/widgets/intraday/core/intraday_dates_sidebar.dart';
import 'package:oural_go/ui/widgets/other/bottom_info_bar.dart';
import 'package:oural_go/ui/widgets/other/display_dates_sidebar.dart';
import 'package:oural_go/ui/widgets/other/display_table_prices.dart';
import 'package:oural_go/ui/widgets/intraday/core/intraday_info_table.dart';
import 'package:oural_go/ui/widgets/other/intraday_bottom_info_bar.dart';
import 'package:oural_go/ui/widgets/unlocked/display_unlocked_table_prices.dart';
import 'package:oural_go/ui/widgets/unlocked/intraday_unlocked_info_table.dart';
import 'package:oural_go/utils/constants.dart';

class TickerInfoScreenArguments {
  final FavoriteItemsCubit cubit;
  final String ticker;

  TickerInfoScreenArguments(
    this.cubit,
    this.ticker,
  );
}

class TickerInfoScreen extends StatefulWidget {
  static const String routeName = 'TickerInfoScreen';

  const TickerInfoScreen({
    Key? key,
    required this.ticker,
  }) : super(key: key);

  final String ticker;

  @override
  State<TickerInfoScreen> createState() => _TickerInfoScreenState();
}

class _TickerInfoScreenState extends State<TickerInfoScreen> {
  late TickerInfoCubit _tickerInfoCubit;
  bool isFavorited = true;
  bool viewPricesTable = true;
  bool lockDatesBar = true;

  @override
  void initState() {
    super.initState();
    _tickerInfoCubit = TickerInfoCubit(ticker: widget.ticker);
  }

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat.currency(locale: 'en_US', symbol: '');

    return MultiBlocProvider(
      providers: [
        BlocProvider<TickerInfoCubit>(
          create: (context) => _tickerInfoCubit,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(
            color: kAccentColor,
          ),
          //backgroundColor: theme value used,
          //backgroundColor: kMainBGcolor,
          title: Text(
            widget.ticker,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyMedium!.color,
              fontSize: kTitleText,
            ),
          ),

          actions: [
            Padding(
              padding: EdgeInsets.only(right: kPadding),
              child: GestureDetector(
                onTap: () {
                  if (isFavorited) {
                    BlocProvider.of<FavoriteItemsCubit>(context)
                        .deleteTicker(widget.ticker);
                  } else {
                    BlocProvider.of<FavoriteItemsCubit>(context)
                        .addTicker(widget.ticker);
                  }
                  setState(() {
                    isFavorited = !isFavorited;
                  });
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      size: 30,
                      color: kAccentColor,
                    ),
                    Icon(
                      Icons.star,
                      size: 26,
                      color: isFavorited
                          ? Colors.yellow
                          : Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'fab1',
              onPressed: () {
                setState(() {
                  lockDatesBar = !lockDatesBar;
                });
              },
              backgroundColor: Theme.of(context).colorScheme.surface,
              child: Icon(
                lockDatesBar ? Icons.lock_outline : Icons.sync_alt,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: kPadding),
            FloatingActionButton(
              heroTag: 'fab2',
              onPressed: () {
                setState(() {
                  viewPricesTable = !viewPricesTable;
                });
              },
              backgroundColor: Theme.of(context).colorScheme.surface,
              child: viewPricesTable
                  ? Icon(
                      Icons.sync,
                      color: Theme.of(context).colorScheme.onSurface,
                    )
                  : RotationTransition(
                      turns: const AlwaysStoppedAnimation(90 / 360),
                      child: Icon(
                        Icons.sync,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
            ),
          ],
        ),
        body: BlocBuilder<TickerInfoCubit, TickerInfoState>(
          builder: (_, tickerState) {
            List<List<double>> prices = tickerState.tickerInfoContainer.prices;
            List<String> dates = tickerState.tickerInfoContainer.dates;
            List<String> hours = tickerState.tickerInfoContainer.hours;
            List<List<String>> performance =
                tickerState.tickerInfoContainer.performance;
            List<double> probabilities =
                tickerState.tickerInfoContainer.probabilities;
            List<IntradayInfoContainer> containers =
                tickerState.tickerInfoContainer.containers;
            double averageIntradayHigh =
                tickerState.tickerInfoContainer.averageIntradayHigh;
            double averageIntradayLow =
                tickerState.tickerInfoContainer.averageIntradayLow;

            double pastMonthPerformance =
                tickerState.tickerInfoContainer.pastMonthPerformance;
            double pastTradingDaysPerformance =
                tickerState.tickerInfoContainer.pastTradingDaysPerformance;
            double pastWeekPerformance =
                tickerState.tickerInfoContainer.pastWeekPerformance;
            double standardDeviation =
                tickerState.tickerInfoContainer.standardDeviation;

            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: kPadding * 3),
                  Image.network(
                    'https://companiesmarketcap.com/img/company-logos/128/${widget.ticker}.webp',
                  ),
                  SizedBox(
                    height: kPadding,
                  ),
                  Padding(
                    padding: EdgeInsets.all(kPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        PastPerformanceCard(
                          value: pastWeekPerformance,
                          description: 'In the past week',
                        ),
                        PastPerformanceCard(
                          value: pastMonthPerformance,
                          description: 'In the past month',
                        ),
                        PastPerformanceCard(
                          value: pastTradingDaysPerformance,
                          description:
                              'In the past ${dates.length} trading days',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: kPadding / 2),
                  Center(
                    child: Text(
                      'Note: all times are in EST',
                      style: TextStyle(
                        color: kAccentColor,
                      ),
                    ),
                  ),
                  SizedBox(height: kPadding / 2),
                  Container(
                    height: kPadding / 4,
                    color: kAccentColor.withOpacity(0.4),
                  ),

                  // IntradayUnlockedInfoTable(
                  //   containers: containers,
                  //   numberFormat: numberFormat,
                  //   averageIntradayLow: averageIntradayLow,
                  //   averageIntradayHigh: averageIntradayHigh,
                  //   dates: dates,
                  // ),

                  // DisplayUnlockedTablePrices(
                  //   hours: hours,
                  //   dates: dates,
                  //   performance: performance,
                  //   numberFormat: numberFormat,
                  //   prices: prices,
                  //   probabilities: probabilities,
                  // ),

                  // Stack(
                  //   alignment: Alignment.centerLeft,
                  //   children: [
                  //     DisplayTablePrices(
                  //       hours: hours,
                  //       dates: dates,
                  //       performance: performance,
                  //       numberFormat: numberFormat,
                  //       prices: prices,
                  //       probabilities: probabilities,
                  //     ),
                  //     DisplayDatesSideBar(
                  //       dates: dates,
                  //     ),
                  //   ],
                  // ),

                  // Stack(
                  //   alignment: Alignment.centerLeft,
                  //   children: [
                  //     IntradayInfoTable(
                  //       containers: containers,
                  //       numberFormat: numberFormat,
                  //       averageIntradayLow: averageIntradayLow,
                  //       averageIntradayHigh: averageIntradayHigh,
                  //     ),
                  //     IntradayDatesSideBar(
                  //       dates: dates,
                  //     ),
                  //   ],
                  // ),
                  viewPricesTable
                      ? lockDatesBar
                          ? Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                DisplayTablePrices(
                                  hours: hours,
                                  dates: dates,
                                  performance: performance,
                                  numberFormat: numberFormat,
                                  prices: prices,
                                  probabilities: probabilities,
                                ),
                                DisplayDatesSideBar(
                                  dates: dates,
                                ),
                              ],
                            )
                          : DisplayUnlockedTablePrices(
                              hours: hours,
                              dates: dates,
                              performance: performance,
                              numberFormat: numberFormat,
                              prices: prices,
                              probabilities: probabilities,
                            )
                      : lockDatesBar
                          ? Stack(
                              alignment: Alignment.centerLeft,
                              children: [
                                IntradayInfoTable(
                                  containers: containers,
                                  numberFormat: numberFormat,
                                  averageIntradayLow: averageIntradayLow,
                                  averageIntradayHigh: averageIntradayHigh,
                                  standardDeviation: standardDeviation,
                                ),
                                IntradayDatesSideBar(
                                  dates: dates,
                                ),
                              ],
                            )
                          : IntradayUnlockedInfoTable(
                              containers: containers,
                              numberFormat: numberFormat,
                              averageIntradayLow: averageIntradayLow,
                              averageIntradayHigh: averageIntradayHigh,
                              dates: dates,
                              standardDeviation: standardDeviation,
                            ),
                  Container(
                    height: kPadding / 4,
                    color: kAccentColor.withOpacity(0.4),
                  ),
                  viewPricesTable
                      ? BottomInfoBar(
                          dates: dates,
                          ticker: widget.ticker,
                        )
                      : const IntradayBottomInfoBar(),
                  const SizedBox(
                    height: 200,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

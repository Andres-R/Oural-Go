import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oural_go/cubit/favorite_items_cubit.dart';
import 'package:oural_go/cubit/ticker_info_cubit.dart';
import 'package:oural_go/data/models/intraday_info_container.dart';
import 'package:intl/intl.dart';
import 'package:oural_go/ui/cards/daily_percentage_card.dart';
import 'package:oural_go/ui/cards/hour_card.dart';
import 'package:oural_go/ui/cards/price_card.dart';
import 'package:oural_go/ui/cards/probability_card.dart';
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
          elevation: 0,
          centerTitle: true,
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(
            color: kAccentColor,
          ),
          backgroundColor: kMainBGcolor,
          title: Column(
            children: [
              Text(
                'Displaying information for',
                style: TextStyle(
                  color: kAccentColor,
                  fontSize: 14,
                ),
              ),
              Text(
                widget.ticker,
                style: TextStyle(
                  color: kTextColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
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
                child: Container(
                  // height: 20,
                  // width: 20,
                  color: Colors.transparent,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.star,
                        size: 30,
                        color: kThemeColor,
                      ),
                      Icon(
                        Icons.star,
                        size: 26,
                        color: isFavorited ? Colors.yellow : kMainBGcolor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              viewPricesTable = !viewPricesTable;
            });
          },
          backgroundColor: kThemeColor,
          child: Icon(
            viewPricesTable
                ? Icons.switch_right_rounded
                : Icons.switch_left_rounded,
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: kMainBGcolor,
          child: BlocBuilder<TickerInfoCubit, TickerInfoState>(
            builder: (_, tickerState) {
              List<List<double>> prices =
                  tickerState.tickerInfoContainer.prices;
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

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 50,
                      color: kMainBGcolor,
                    ),
                    Image.network(
                      'https://companiesmarketcap.com/img/company-logos/128/${widget.ticker}.webp',
                      // width: 200,
                      // height: 200,
                      // color: Colors.red,
                    ),
                    SizedBox(
                      height: kPadding,
                    ),
                    Padding(
                      padding: EdgeInsets.all(kPadding),
                      child: Container(
                        //height: 200,
                        color: kMainBGcolor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color:
                                        determineBGColor(pastWeekPerformance),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(kPadding / 4),
                                    child: Text(
                                      '${pastWeekPerformance.toStringAsFixed(2)}%',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: determineTextColor(
                                          pastWeekPerformance,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: kPadding / 4),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  child: Text(
                                    'In the past week',
                                    style: TextStyle(
                                      color: kTextColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color:
                                        determineBGColor(pastMonthPerformance),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(kPadding / 4),
                                    child: Text(
                                      '${pastMonthPerformance.toStringAsFixed(2)}%',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: determineTextColor(
                                          pastMonthPerformance,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: kPadding / 4),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  child: Text(
                                    'In the past month',
                                    style: TextStyle(
                                      color: kTextColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: determineBGColor(
                                        pastTradingDaysPerformance),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(kPadding / 4),
                                    child: Text(
                                      '${pastTradingDaysPerformance.toStringAsFixed(2)}%',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: determineTextColor(
                                          pastTradingDaysPerformance,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: kPadding / 4),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  child: Text(
                                    'In the past ${dates.length} trading days',
                                    style: TextStyle(
                                      color: kTextColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(kPadding / 2),
                      child: Container(
                        height: 20,
                        color: kMainBGcolor,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Note: all times are in EST',
                            style: TextStyle(
                              color: kAccentColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: kPadding / 4,
                      color: kAccentColor.withOpacity(0.4),
                    ),
                    viewPricesTable
                        ? Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              // DisplayTablePrices returns a giant container
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
                        : Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              IntradayInfoTable(
                                containers: containers,
                                numberFormat: numberFormat,
                                averageIntradayLow: averageIntradayLow,
                                averageIntradayHigh: averageIntradayHigh,
                              ),
                              IntradayDatesSideBar(
                                dates: dates,
                              ),
                            ],
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
                        : Container(),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Color determineBGColor(double value) {
    if (value > 0) {
      return kBullish.withOpacity(0.2);
    } else {
      return kBearish.withOpacity(0.2);
    }
  }

  Color determineTextColor(double value) {
    if (value > 0) {
      return kBullish;
    } else {
      return kBearish;
    }
  }
}

class BottomInfoBar extends StatelessWidget {
  const BottomInfoBar({
    Key? key,
    required this.dates,
    required this.ticker,
  }) : super(key: key);

  final List<String> dates;
  final String ticker;

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 200,
      color: kMainBGcolor,
      child: Padding(
        padding: EdgeInsets.all(kPadding),
        child: Column(
          children: [
            Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: kPadding,
                  width: kPadding,
                  decoration: BoxDecoration(
                    color: kBullish.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.call_made_rounded,
                      color: kBullish,
                      size: 16,
                    ),
                  ),
                ),
                SizedBox(width: kPadding),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Denotes increase of asset price between a 30',
                      style: TextStyle(
                        color: kTextColor,
                      ),
                    ),
                    Text(
                      'min interval',
                      style: TextStyle(
                        color: kTextColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: kPadding),
            Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: kPadding,
                  width: kPadding,
                  decoration: BoxDecoration(
                    color: kBearish.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: Center(
                    child: RotationTransition(
                      turns: const AlwaysStoppedAnimation(270 / 360),
                      child: Icon(
                        Icons.call_received_rounded,
                        color: kBearish,
                        size: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: kPadding),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Denotes decrease of asset price between a 30',
                      style: TextStyle(
                        color: kTextColor,
                      ),
                    ),
                    Text(
                      'min interval',
                      style: TextStyle(
                        color: kTextColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: kPadding),
            Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: kPadding,
                  width: kPadding,
                  decoration: BoxDecoration(
                    color: kAccentColor.withOpacity(0.6),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      //Icons.arrow_right_alt,
                      Icons.arrow_forward,
                      color: kTextColor,
                      size: 16,
                    ),
                  ),
                ),
                SizedBox(width: kPadding),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Denotes no change of asset price between a 30',
                      style: TextStyle(
                        color: kTextColor,
                      ),
                    ),
                    Text(
                      'min interval',
                      style: TextStyle(
                        color: kTextColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: kPadding),
            Row(
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: kPadding,
                  width: kPadding,
                  child: Center(
                    child: Text(
                      '%',
                      style: TextStyle(
                        color: kBullish,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: kPadding),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Denotes probability of  ',
                          style: TextStyle(
                            color: kTextColor,
                          ),
                        ),
                        Container(
                          height: kPadding,
                          width: kPadding,
                          decoration: BoxDecoration(
                            color: kBullish.withOpacity(0.2),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.call_made_rounded,
                              color: kBullish,
                              size: 16,
                            ),
                          ),
                        ),
                        Text(
                          '  occuring over',
                          style: TextStyle(
                            color: kTextColor,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'the past ${dates.length} trading days for $ticker',
                      style: TextStyle(
                        color: kTextColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: kPadding),
          ],
        ),
      ),
    );
  }
}

class IntradayInfoTable extends StatelessWidget {
  const IntradayInfoTable({
    Key? key,
    required this.containers,
    required this.numberFormat,
    required this.averageIntradayLow,
    required this.averageIntradayHigh,
  }) : super(key: key);

  final List<IntradayInfoContainer> containers;
  final NumberFormat numberFormat;
  final double averageIntradayLow;
  final double averageIntradayHigh;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kMainBGcolor,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Container(
              width: 135,
            ),
            IntradayLowPriceBar(
              containers: containers,
              numberFormat: numberFormat,
            ),
            IntradayLowInfoBar(
              containers: containers,
              averageLow: averageIntradayLow,
            ),
            IntradayOpenPriceBar(
              containers: containers,
              numberFormat: numberFormat,
            ),
            IntradayHighInfoBar(
              containers: containers,
              averageHigh: averageIntradayHigh,
            ),
            IntradayHighBar(
              containers: containers,
              numberFormat: numberFormat,
            ),
          ],
        ),
      ),
    );
  }
}

class IntradayHighInfoBar extends StatelessWidget {
  const IntradayHighInfoBar({
    Key? key,
    required this.containers,
    required this.averageHigh,
  }) : super(key: key);

  final List<IntradayInfoContainer> containers;
  final double averageHigh;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kMainBGcolor,
      //width: 80,
      child: Padding(
        padding: EdgeInsets.all(kPadding / 2),
        child: Column(
          children: [
            const Text(''),
            SizedBox(height: kPadding / 2),
            ...List.generate(
              containers.length,
              (index) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: kBullish.withOpacity(0.2),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child: Text(
                            '+${containers[index].intradayHigh.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: kBullish,
                            ),
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
              'Avg.',
              style: TextStyle(
                color: kTextColor,
              ),
            ),
            SizedBox(height: kPadding / 2),
            Container(
              decoration: BoxDecoration(
                color: kBullish.withOpacity(0.2),
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Text(
                '+${averageHigh.toStringAsFixed(2)}',
                style: TextStyle(
                  color: kBullish,
                ),
              ),
            ),
            SizedBox(height: kPadding / 2),
          ],
        ),
      ),
    );
  }
}

class IntradayLowInfoBar extends StatelessWidget {
  const IntradayLowInfoBar({
    Key? key,
    required this.containers,
    required this.averageLow,
  }) : super(key: key);

  final List<IntradayInfoContainer> containers;
  final double averageLow;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kMainBGcolor,
      //width: 80,
      child: Padding(
        padding: EdgeInsets.all(kPadding / 2),
        child: Column(
          children: [
            const Text(''),
            SizedBox(height: kPadding / 2),
            ...List.generate(
              containers.length,
              (index) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: kBearish.withOpacity(0.2),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child: Text(
                            '-${containers[index].intradayLow.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: kBearish,
                            ),
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
              'Avg.',
              style: TextStyle(
                color: kTextColor,
              ),
            ),
            SizedBox(height: kPadding / 2),
            Container(
              decoration: BoxDecoration(
                color: kBearish.withOpacity(0.2),
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: Text(
                '-${averageLow.toStringAsFixed(2)}',
                style: TextStyle(
                  color: kBearish,
                ),
              ),
            ),
            SizedBox(height: kPadding / 2),
          ],
        ),
      ),
    );
  }
}

class IntradayLowPriceBar extends StatelessWidget {
  const IntradayLowPriceBar({
    Key? key,
    required this.containers,
    required this.numberFormat,
  }) : super(key: key);

  final List<IntradayInfoContainer> containers;
  final NumberFormat numberFormat;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kMainBGcolor,
      width: 80,
      child: Padding(
        padding: EdgeInsets.all(kPadding / 2),
        child: Column(
          children: [
            Text(
              'Low',
              style: TextStyle(color: kTextColor),
            ),
            SizedBox(height: kPadding / 2),
            ...List.generate(
              containers.length,
              (index) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '\$${numberFormat.format(containers[index].open - containers[index].intradayLow)}',
                          style: TextStyle(
                            color: kTextColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: kPadding / 2),
                  ],
                );
              },
            ),
            const Text(''),
            SizedBox(height: kPadding / 2),
            const Text(''),
            SizedBox(height: kPadding / 2),
          ],
        ),
      ),
    );
  }
}

class IntradayHighBar extends StatelessWidget {
  const IntradayHighBar({
    Key? key,
    required this.containers,
    required this.numberFormat,
  }) : super(key: key);

  final List<IntradayInfoContainer> containers;
  final NumberFormat numberFormat;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kMainBGcolor,
      width: 80,
      child: Padding(
        padding: EdgeInsets.all(kPadding / 2),
        child: Column(
          children: [
            Text(
              'High',
              style: TextStyle(
                color: kTextColor,
              ),
            ),
            SizedBox(height: kPadding / 2),
            ...List.generate(
              containers.length,
              (index) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '\$${numberFormat.format(containers[index].open + containers[index].intradayHigh)}',
                          style: TextStyle(
                            color: kTextColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: kPadding / 2),
                  ],
                );
              },
            ),
            const Text(''),
            SizedBox(height: kPadding / 2),
            const Text(''),
            SizedBox(height: kPadding / 2),
          ],
        ),
      ),
    );
  }
}

class IntradayOpenPriceBar extends StatelessWidget {
  const IntradayOpenPriceBar({
    Key? key,
    required this.containers,
    required this.numberFormat,
  }) : super(key: key);

  final List<IntradayInfoContainer> containers;
  final NumberFormat numberFormat;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kMainBGcolor,
      width: 80,
      child: Padding(
        padding: EdgeInsets.all(kPadding / 2),
        child: Column(
          children: [
            Text(
              'Open',
              style: TextStyle(
                color: kTextColor,
              ),
            ),
            SizedBox(height: kPadding / 2),
            ...List.generate(
              containers.length,
              (index) {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '\$${numberFormat.format(containers[index].open)}',
                          style: TextStyle(
                            color: kTextColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: kPadding / 2),
                  ],
                );
              },
            ),
            const Text(''),
            SizedBox(height: kPadding / 2),
            const Text(''),
            SizedBox(height: kPadding / 2),
          ],
        ),
      ),
    );
  }
}

class IntradayDatesSideBar extends StatelessWidget {
  const IntradayDatesSideBar({
    Key? key,
    required this.dates,
  }) : super(key: key);

  final List<String> dates;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(),
      width: 135,
      child: Container(
        margin: const EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          color: kMainBGcolor,
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
                style: TextStyle(
                  color: kTextColor,
                ),
              ),
              SizedBox(height: kPadding / 2),
              ...List.generate(
                dates.length,
                (index) {
                  return Column(
                    children: [
                      Container(
                        color: kMainBGcolor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 20,
                              //color: Colors.purple,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    (index + 1).toString(),
                                    style: TextStyle(
                                      color: kTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              //width: 40,
                              //color: Colors.red,
                              child: Text(
                                dates[index],
                                style: TextStyle(
                                  color: kTextColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: kPadding / 2),
                    ],
                  );
                },
              ),
              const Text(''),
              SizedBox(height: kPadding / 2),
              const Text(''),
              SizedBox(height: kPadding / 2),
              //const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

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
          color: kMainBGcolor,
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
                style: TextStyle(
                  color: kTextColor,
                ),
              ),
              SizedBox(height: kPadding / 2),
              ...List.generate(
                dates.length,
                (index) {
                  return Column(
                    children: [
                      Container(
                        //width: 100,
                        //height: 20,
                        color: kMainBGcolor,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 20,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    (index + 1).toString(),
                                    style: TextStyle(
                                      color: kTextColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              child: Text(
                                dates[index],
                                style: TextStyle(
                                  color: kTextColor,
                                ),
                              ),
                            ),
                          ],
                        ),
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

class DisplayTablePrices extends StatelessWidget {
  const DisplayTablePrices({
    Key? key,
    required this.hours,
    required this.dates,
    required this.performance,
    required this.numberFormat,
    required this.prices,
    required this.probabilities,
  }) : super(key: key);

  final List<String> hours;
  final List<String> dates;
  final List<List<String>> performance;
  final NumberFormat numberFormat;
  final List<List<double>> prices;
  final List<double> probabilities;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kMainBGcolor,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            // this side box hides under DisplayDatesSideBar
            Container(
              width: 135,
              // height: 300,
              // color: Colors.red,
            ),
            Padding(
              padding: EdgeInsets.all(kPadding / 2),
              child: Column(
                children: [
                  Row(
                    children: [
                      ...List.generate(
                        hours.length,
                        (index) {
                          return HourCard(
                            hours: hours,
                            index: index,
                          );
                        },
                      ),
                      Container(
                        width: 110,
                        //height: 10,
                        color: kMainBGcolor,
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Performance',
                            style: TextStyle(
                              color: kTextColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // hours ^ ^
                  SizedBox(height: kPadding / 2),
                  // prices v v
                  ...List.generate(
                    dates.length,
                    (i) {
                      double dailyPerformance = double.parse(
                          '${(((prices[i][hours.length - 1] - prices[i][0]) / prices[i][0]) * 100)}');
                      double priceMovement =
                          prices[i][hours.length - 1] - prices[i][0];
                      return Column(
                        children: [
                          Row(
                            children: [
                              ...List.generate(
                                hours.length,
                                (j) {
                                  String price =
                                      '\$${numberFormat.format(prices[i][j])}';

                                  Widget icon = Icon(
                                    Icons.add,
                                    size: 12,
                                    color: kMainBGcolor,
                                  );
                                  Color iconBG = kMainBGcolor;

                                  String letter = '';
                                  if (j != hours.length - 1) {
                                    letter = performance[i][j];
                                    icon = determineIcon(letter);
                                    iconBG = determineColor(letter);
                                  }

                                  return PriceCard(
                                    price: price,
                                    iconBG: iconBG,
                                    icon: icon,
                                  );
                                },
                              ),
                              DailyPercentageCard(
                                dailyPerformance: dailyPerformance,
                                priceMovement: priceMovement,
                              ),
                            ],
                          ),
                          i != dates.length - 1
                              ? SizedBox(height: kPadding / 2)
                              : const SizedBox()
                        ],
                      );
                    },
                  ),
                  // prices ^ ^
                  SizedBox(height: kPadding / 2),
                  // probabilities v v
                  Row(
                    children: [
                      ...List.generate(
                        probabilities.length,
                        (index) {
                          String probability =
                              '${(probabilities[index] * 100).toStringAsFixed(2)} %';

                          return ProbabilityCard(
                            probability: probability,
                          );
                        },
                      ),
                      Container(
                        width: 110,
                        height: 10,
                        color: kMainBGcolor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color determineColor(String letter) {
    if (letter == 'U') {
      return kBullish.withOpacity(0.2);
    } else if (letter == 'D') {
      return kBearish.withOpacity(0.2);
    } else {
      return kAccentColor.withOpacity(0.6);
    }
  }

  Widget determineIcon(String letter) {
    if (letter == 'U') {
      return Icon(
        Icons.call_made_rounded,
        color: kBullish,
        size: 16,
      );
    } else if (letter == 'D') {
      return RotationTransition(
        turns: const AlwaysStoppedAnimation(270 / 360),
        child: Icon(
          Icons.call_received_rounded,
          color: kBearish,
          size: 16,
        ),
      );
    } else {
      return Icon(
        //Icons.arrow_right_alt,
        Icons.arrow_forward,
        color: kTextColor,
        size: 16,
      );
    }
  }
}

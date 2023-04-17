import 'package:oural_go/data/models/intraday_info_container.dart';

class TickerInfoContainer {
  String ticker;
  List<List<double>> prices;
  List<String> dates;
  List<String> hours;
  List<List<String>> performance;
  List<double> probabilities;
  List<IntradayInfoContainer> containers;
  double averageIntradayHigh;
  double averageIntradayLow;
  double pastMonthPerformance;
  double pastTradingDaysPerformance;
  double pastWeekPerformance;
  double standardDeviation;

  TickerInfoContainer({
    required this.ticker,
    required this.prices,
    required this.dates,
    required this.hours,
    required this.performance,
    required this.probabilities,
    required this.containers,
    required this.averageIntradayHigh,
    required this.averageIntradayLow,
    required this.pastMonthPerformance,
    required this.pastTradingDaysPerformance,
    required this.pastWeekPerformance,
    required this.standardDeviation,
  });
}

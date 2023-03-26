import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import 'package:oural_go/data/models/intraday_info_container.dart';
import 'package:intl/intl.dart';
import 'package:oural_go/data/models/ticker_info_container.dart';

class DataService {
  final int timestampCount = 14;
  final int intervalCount = 13;

  // hours.length = 14
  final List<String> hours = [
    "09:30:00",
    "10:00:00",
    "10:30:00",
    "11:00:00",
    "11:30:00",
    "12:00:00",
    "12:30:00",
    "13:00:00",
    "13:30:00",
    "14:00:00",
    "14:30:00",
    "15:00:00",
    "15:30:00",
    "16:00:00",
  ];

  String key = "L00JOCOTWMW4FTS3";

  String baseURL = "https://www.alphavantage.co/query";
  String parameter1 = "?function=TIME_SERIES_INTRADAY";
  String parameter3 = "&interval=30min";
  String parameter4 = "&outputsize=full";

  Future<TickerInfoContainer> getTickerInformation(String ticker) async {
    String parameter2 = "&symbol=$ticker";
    String parameter5 = "&apikey=$key";

    String endpoint =
        "$baseURL$parameter1$parameter2$parameter3$parameter4$parameter5";

    List<List<double>> prices = [];
    List<String> dates = [];

    try {
      Uri uri = Uri.parse(endpoint);
      Response response = await http.get(uri);
      Map<String, dynamic> json = jsonDecode(response.body);

      Map<String, dynamic> data = json['Time Series (30min)'];
      List<String> keys = data.keys.toList();

      dates = getDates(keys);
      prices = List.generate(dates.length, (index) {
        return List.generate(timestampCount, (index) {
          return 0;
        });
      });

      // get opening price of stock every 30m for each date
      for (int i = 0; i < dates.length; i++) {
        for (int j = 0; j < hours.length; j++) {
          // timeStamp is used as a key to access maps in 'Time Series (30min)'
          String timeStamp = '${dates[i]} ${hours[j]}';
          Map<String, dynamic> timeStampData = data[timeStamp];
          String openPrice = timeStampData['1. open'];
          prices[i][j] =
              double.parse((double.parse(openPrice)).toStringAsFixed(2));
        }
      }
    } on Exception catch (e) {
      print(e);
    }

    List<List<String>> performance = generatePerformance(
      dates.length,
      intervalCount,
      prices,
    );

    List<double> probabilities = generateProbabilities(
      performance,
      dates.length,
    );

    List<IntradayInfoContainer> containers = await populateContainers(
      dates,
      endpoint,
    );

    double averageHigh = getAverageIntradayHigh(containers);
    double averageLow = getAverageIntradayLow(containers);

    double oldestPrice = prices[0][0];
    double monthAgoPrice = getPriceFromOneMonthAgo(prices, dates);
    double weekAgoPrice = getPriceFromOneWeekAgo(prices, dates);
    double mostRecentPrice = prices[dates.length - 1][hours.length - 1];

    double pastMonthPerformance =
        ((mostRecentPrice - monthAgoPrice) / monthAgoPrice) * 100;
    double pastTradingDaysPerformance =
        ((mostRecentPrice - oldestPrice) / oldestPrice) * 100;
    double pastWeekPerformance =
        ((mostRecentPrice - weekAgoPrice) / weekAgoPrice) * 100;

    // for (final item in containers) {
    //   print(item.date);
    //   print(item.open);
    //   print(item.intradayHigh);
    //   print(item.intradayLow);
    //   print('');
    // }
    //  print(probabilities);
    // print(prices);
    //  return prices;

    return TickerInfoContainer(
      ticker: ticker,
      prices: prices,
      dates: dates,
      hours: hours,
      performance: performance,
      probabilities: probabilities,
      containers: containers,
      averageIntradayHigh: averageHigh,
      averageIntradayLow: averageLow,
      pastMonthPerformance: pastMonthPerformance,
      pastTradingDaysPerformance: pastTradingDaysPerformance,
      pastWeekPerformance: pastWeekPerformance,
    );
  }

  //
  double getPriceFromOneMonthAgo(
    List<List<double>> prices,
    List<String> dates,
  ) {
    String mostRecentDate = dates.last;
    // eg: 2023-03-23
    List<String> parts = mostRecentDate.split('-');
    int year = int.parse(parts[0]);
    int month = int.parse(parts[1]) - 1;
    int day = int.parse(parts[2]);
    if (month == 0) {
      month = 12;
      year--;
    }
    String dateFromOneMonthAgo = formatDate(year, month, day);
    while (!dates.contains(dateFromOneMonthAgo)) {
      day++;
      if (day == 32) {
        day = 1;
        month++;
        if (month == 13) {
          month = 1;
          year++;
        }
      }
      dateFromOneMonthAgo = formatDate(year, month, day);
    }
    return prices[dates.indexOf(dateFromOneMonthAgo)][0];
  }

  //
  double getPriceFromOneWeekAgo(
    List<List<double>> prices,
    List<String> dates,
  ) {
    String mostRecentDate = dates.last;
    // eg: 2023-03-23
    List<String> parts = mostRecentDate.split('-');
    int year = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int day = int.parse(parts[2]);

    if (day > 7) {
      day = day - 7;
    } else {
      day = day + 24;
      month--;
      if (month == 0) {
        month = 12;
        year--;
      }
    }
    String dateFromOneWeekAgo = formatDate(year, month, day);
    while (!dates.contains(dateFromOneWeekAgo)) {
      day++;
      if (day == 32) {
        day = 1;
        month++;
        if (month == 13) {
          month = 1;
          year++;
        }
      }
      dateFromOneWeekAgo = formatDate(year, month, day);
    }
    return prices[dates.indexOf(dateFromOneWeekAgo)][0];
  }

  String formatDate(int year, int month, int day) {
    if (month < 10 && day < 10) {
      return '$year-0$month-0$day';
    } else if (month < 10) {
      return '$year-0$month-$day';
    } else if (day < 10) {
      return '$year-$month-0$day';
    } else {
      return '$year-$month-$day';
    }
  }

  // Returns a list of dates from key 'Time Series (30min)'.
  // Duplicate dates excluded.
  List<String> getDates(List<String> keys) {
    Set<String> unsortedDates = {};
    for (String key in keys) {
      List<String> times = key.split(' ');
      String date = times[0];

      unsortedDates.add(date);
    }
    List<String> sortedDates = unsortedDates.toList();
    sortedDates.sort();

    List<String> validDates = [];

    for (int i = 0; i < sortedDates.length; i++) {
      int validHours = 0;
      for (int j = 0; j < hours.length; j++) {
        String timeStamp = '${sortedDates[i]} ${hours[j]}';
        if (keys.contains(timeStamp)) {
          validHours++;
          if (validHours == timestampCount) {
            validDates.add(sortedDates[i]);
          }
        }
      }
    }

    return validDates;
  }

  // Returns a 2D list where every element is a symbol
  // representing the difference between 2 prices
  // that are 30 minutes apart.
  //
  // 'U' if price went up
  // 'D' if price went down
  // 'S' if price went side ways
  //
  List<List<String>> generatePerformance(
    int rows,
    int columns,
    List<List<double>> prices,
  ) {
    List<List<String>> performance = List.generate(rows, (index) {
      return List.generate(columns, (index) {
        return '0';
      });
    });

    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < columns; j++) {
        double difference = prices[i][j + 1] - prices[i][j];
        if (difference > 0) {
          performance[i][j] = 'U';
        } else if (difference < 0) {
          performance[i][j] = 'D';
        } else {
          performance[i][j] = 'S';
        }
      }
    }
    return performance;
  }

  // returns a list with each element being the number of
  // (total 'U's) / (total days) occuring between 30 min intervals
  //
  // list length is 13, the value of intervalCount
  //
  List<double> generateProbabilities(
    List<List<String>> performance,
    int days,
  ) {
    String target = 'U';
    List<double> probabilitiesOfUps = List.generate(intervalCount, (index) {
      return 0.0;
    });

    for (int k = 0; k < intervalCount; k++) {
      List<String> pattern = List.generate(days, (index) {
        return '0';
      });
      // populate pattern array from performance
      for (int i = 0; i < days; i++) {
        for (int j = 0; j < intervalCount; j++) {
          if (k == j) {
            pattern[i] = performance[i][j];
          }
        }
      }
      // find number of 'U's in pattern
      // remember, pattern represents the performance of a specific interval over x amount of days
      int targetCount = 0;
      for (int i = 0; i < pattern.length; i++) {
        if (pattern[i] == target) {
          targetCount++;
        }
      }
      probabilitiesOfUps[k] = targetCount / days.toDouble();
    }
    return probabilitiesOfUps;
  }

  //
  //
  //
  //
  //
  Future<List<IntradayInfoContainer>> populateContainers(
    List<String> dates,
    String endpoint,
  ) async {
    List<IntradayInfoContainer> containers = [];

    try {
      Uri uri = Uri.parse(endpoint);
      Response response = await http.get(uri);
      Map<String, dynamic> json = jsonDecode(response.body);

      Map<String, dynamic> data = json['Time Series (30min)'];
      for (String date in dates) {
        String timestampKey = '$date 09:30:00';
        Map<String, dynamic> timestampInfo = data[timestampKey];
        // save this to container
        double openPrice = double.parse(
          double.parse(timestampInfo['1. open']).toStringAsFixed(2),
        );

        // save these to container
        double intradayHigh = double.parse(data[timestampKey]['2. high']);
        double intradayLow = double.parse(data[timestampKey]['3. low']);

        for (String hour in hours) {
          String key = '$date $hour';
          Map<String, dynamic> keyInfo = data[key];
          double high = double.parse(keyInfo['2. high']);
          double low = double.parse(keyInfo['3. low']);
          // find high
          if (high > intradayHigh) {
            intradayHigh = high;
          }
          // find low
          if (low < intradayLow) {
            intradayLow = low;
          }
        }

        intradayHigh =
            double.parse((intradayHigh - openPrice).toStringAsFixed(2));
        intradayLow =
            double.parse((openPrice - intradayLow).toStringAsFixed(2));

        containers.add(
          IntradayInfoContainer(
            date: date,
            open: openPrice,
            intradayHigh: intradayHigh,
            intradayLow: intradayLow,
          ),
        );
      }
    } on Exception catch (e) {
      print(e);
    }
    return containers;
  }

  //
  //
  //
  //
  //
  double getAverageIntradayHigh(List<IntradayInfoContainer> containers) {
    double sum = 0.0;
    for (final container in containers) {
      sum += container.intradayHigh;
    }
    return sum / containers.length;
  }

  //
  //
  //
  //
  //
  double getAverageIntradayLow(List<IntradayInfoContainer> containers) {
    double sum = 0.0;
    for (final container in containers) {
      sum += container.intradayLow;
    }
    return sum / containers.length;
  }

  //
  //
  //
  //
  //
  Future<bool> isTickerValid(String ticker) async {
    String parameter2 = "&symbol=$ticker";
    String parameter5 = "&apikey=$key";

    String endpoint =
        "$baseURL$parameter1$parameter2$parameter3$parameter4$parameter5";

    bool valid = false;
    try {
      Uri uri = Uri.parse(endpoint);
      Response response = await http.get(uri);
      Map<String, dynamic> json = jsonDecode(response.body);
      if (json.containsKey('Time Series (30min)')) {
        valid = true;
      }
    } on Exception catch (e) {
      print(e);
    }
    return valid;
  }

  //
  //
  //
  //
  //
  Future<String> getTickerCompanyName(String ticker) async {
    String key = 'mXwMEKRM4UJAWLYaDzE8mQtrmlhVlAUU';

    String baseURL = 'https://api.polygon.io/';
    String category = 'v3/reference/tickers';
    String param1 = '?ticker=$ticker';
    String param2 = '&active=true';
    String param3 = '&apiKey=';

    String endpoint = '$baseURL$category$param1$param2$param3$key';

    String name = ticker;

    try {
      Uri uri = Uri.parse(endpoint);
      Response response = await http.get(uri);
      Map<String, dynamic> json = jsonDecode(response.body);

      if (json['results'] != null) {
        List<dynamic> results = json['results'];
        if (results.isNotEmpty) {
          name = results[0]['name'];
        }
      }
    } on Exception catch (e) {
      print(e);
    }

    return name;
  }
}

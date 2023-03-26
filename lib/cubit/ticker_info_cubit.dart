import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:oural_go/data/service/data_service.dart';
import 'package:oural_go/data/models/ticker_info_container.dart';
import 'package:equatable/equatable.dart';

part 'ticker_info_state.dart';

class TickerInfoCubit extends Cubit<TickerInfoState> {
  TickerInfoCubit({
    required this.ticker,
  }) : super(
          TickerInfoState(
            tickerInfoContainer: TickerInfoContainer(
              ticker: '',
              prices: [],
              dates: [],
              hours: [],
              performance: [],
              probabilities: [],
              containers: [],
              averageIntradayHigh: 0.0,
              averageIntradayLow: 0.0,
              pastMonthPerformance: 0.0,
              pastTradingDaysPerformance: 0.0,
              pastWeekPerformance: 0.0,
            ),
          ),
        ) {
    initialize();
  }

  final String ticker;
  DataService ds = DataService();

  void initialize() async {
    TickerInfoContainer tc = await ds.getTickerInformation(ticker);
    emit(TickerInfoState(tickerInfoContainer: tc));
  }
}

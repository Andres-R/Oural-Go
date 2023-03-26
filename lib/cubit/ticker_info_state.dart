part of 'ticker_info_cubit.dart';

class TickerInfoState extends Equatable {
  const TickerInfoState({
    required this.tickerInfoContainer,
  });

  final TickerInfoContainer tickerInfoContainer;

  @override
  List<Object> get props => [tickerInfoContainer];
}

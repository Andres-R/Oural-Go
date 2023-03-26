import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:oural_go/data/service/data_service.dart';

part 'ticker_company_name_state.dart';

class TickerCompanyNameCubit extends Cubit<TickerCompanyNameState> {
  TickerCompanyNameCubit({
    required this.ticker,
  }) : super(const TickerCompanyNameState(companyName: '')) {
    initialize();
  }

  final String ticker;
  DataService ds = DataService();

  void initialize() async {
    String name = await ds.getTickerCompanyName(ticker);
    emit(TickerCompanyNameState(companyName: name));
  }
}

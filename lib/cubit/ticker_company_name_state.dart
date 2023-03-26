part of 'ticker_company_name_cubit.dart';

class TickerCompanyNameState extends Equatable {
  const TickerCompanyNameState({
    required this.companyName,
  });

  final String companyName;

  @override
  List<Object> get props => [companyName];
}

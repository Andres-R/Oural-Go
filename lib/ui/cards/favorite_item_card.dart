import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oural_go/cubit/ticker_company_name_cubit.dart';
import 'package:oural_go/utils/constants.dart';

class FavoriteItemCard extends StatefulWidget {
  const FavoriteItemCard({
    Key? key,
    required this.ticker,
  }) : super(key: key);

  final String ticker;

  @override
  State<FavoriteItemCard> createState() => _FavoriteItemCardState();
}

class _FavoriteItemCardState extends State<FavoriteItemCard> {
  late TickerCompanyNameCubit _companyNameCubit;

  @override
  void initState() {
    super.initState();
    _companyNameCubit = TickerCompanyNameCubit(ticker: widget.ticker);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TickerCompanyNameCubit>(
          create: (context) => _companyNameCubit,
        ),
      ],
      child: Container(
        color: Theme.of(context).primaryColor,
        height: 50,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: kPadding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 26,
                    width: 26,
                    child: Center(
                      child: Image.network(
                        'https://companiesmarketcap.com/img/company-logos/64/${widget.ticker}.webp',
                      ),
                    ),
                  ),
                  SizedBox(width: kPadding / 1.5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.ticker,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      BlocBuilder<TickerCompanyNameCubit,
                          TickerCompanyNameState>(
                        builder: (_, state) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Text(
                                    state.companyName,
                                    style: TextStyle(
                                      color: kAccentColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 26,
                width: 26,
                child: Center(
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: kAccentColor,
                    size: 22,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

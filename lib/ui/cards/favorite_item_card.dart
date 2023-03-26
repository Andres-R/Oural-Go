import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oural_go/cubit/ticker_company_name_cubit.dart';

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
        height: 50,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 26,
                    width: 26,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Image.network(
                        'https://companiesmarketcap.com/img/company-logos/64/${widget.ticker}.webp',
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.ticker,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      BlocBuilder<TickerCompanyNameCubit,
                          TickerCompanyNameState>(
                        builder: (_, state) {
                          return Container(
                            color: Colors.white,
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Text(
                                    state.companyName,
                                    style: const TextStyle(
                                      color: Colors.grey,
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
              Container(
                height: 26,
                width: 26,
                color: Colors.white,
                child: const Center(
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
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

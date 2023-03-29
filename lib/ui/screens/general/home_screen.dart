import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:oural_go/cubit/favorite_items_cubit.dart';
import 'package:oural_go/data/repository/data_repository.dart';
import 'package:oural_go/data/service/data_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oural_go/ui/cards/favorite_item_card.dart';
import 'package:oural_go/ui/screens/general/ticker_info_screen.dart';
import 'package:oural_go/utils/constants.dart';
import 'package:oural_go/utils/custom_error_dialog.dart';
import 'package:oural_go/utils/input_popup.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late FavoriteItemsCubit _favoriteItemsCubit;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _favoriteItemsCubit = FavoriteItemsCubit();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FavoriteItemsCubit>(
          create: (context) => _favoriteItemsCubit,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kMainBGcolor,
          centerTitle: true,
          title: Text(
            'Tickers',
            style: TextStyle(
              color: kTextColor,
              fontSize: 22,
            ),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: kMainBGcolor,
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  height: 50,
                  color: kMainBGcolor,
                ),
                Padding(
                  padding: EdgeInsets.all(kPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Favorites',
                        style: TextStyle(
                          color: kTextColor,
                          fontSize: 26,
                          fontFamily: 'Georgia',
                        ),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<FavoriteItemsCubit, FavoriteItemsState>(
                  builder: (_, state) {
                    return Column(
                      children: [
                        ...List.generate(
                          state.favoriteItems.length,
                          (index) {
                            String ticker =
                                state.favoriteItems[index]['ticker'];
                            return Padding(
                              padding: EdgeInsets.all(kPadding / 2),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    TickerInfoScreen.routeName,
                                    arguments: TickerInfoScreenArguments(
                                      _favoriteItemsCubit,
                                      ticker,
                                    ),
                                  );
                                },
                                child: FavoriteItemCard(
                                  ticker: ticker,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 200),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: Text(
            'Add ticker',
            style: TextStyle(
              color: kMainBGcolor,
              fontSize: 18,
              fontFamily: 'Georgia',
            ),
          ),
          icon: Icon(
            Icons.add,
            color: kMainBGcolor,
          ),
          onPressed: () {
            showInputDialog(
              context,
              _controller,
              _favoriteItemsCubit,
            );
          },
          backgroundColor: kThemeColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(kBorderRadius),
            ),
          ),
        ),
      ),
    );
  }
}

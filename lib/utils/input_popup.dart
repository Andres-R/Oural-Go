import 'package:flutter/material.dart';
import 'package:oural_go/cubit/favorite_items_cubit.dart';
import 'package:oural_go/data/repository/data_repository.dart';
import 'package:oural_go/data/service/data_service.dart';
import 'package:oural_go/utils/constants.dart';
import 'package:oural_go/utils/custom_error_dialog.dart';
import 'package:oural_go/utils/custom_text_form_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showInputDialog(
  BuildContext context,
  TextEditingController textEditingController,
  FavoriteItemsCubit favoriteItemsCubit,
) {
  showDialog(
    context: context,
    builder: (_) {
      return BlocProvider.value(
        value: favoriteItemsCubit,
        child: CustomInputDialog(
          textEditingController: textEditingController,
          dialogContext: context,
        ),
      );
    },
  );
}

class CustomInputDialog extends StatefulWidget {
  const CustomInputDialog({
    Key? key,
    required this.textEditingController,
    required this.dialogContext,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final BuildContext dialogContext;

  @override
  State<CustomInputDialog> createState() => _CustomInputDialogState();
}

class _CustomInputDialogState extends State<CustomInputDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(kBorderRadius)),
      ),
      backgroundColor: kMainBGcolor,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          SizedBox(
            height: 250,
            child: Padding(
              padding: EdgeInsets.all(kPadding),
              child: Column(
                children: [
                  //const Spacer(),
                  Text(
                    "Enter ticker",
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: kPadding),
                  Text(
                    "Ticker will be visible in favorites list after adding symbol",
                    style: TextStyle(
                      color: kAccentColor,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: kPadding),
                  CustomTextFormField(
                    controller: widget.textEditingController,
                    hint: 'Symbol',
                    icon: Icons.abc,
                    obscureText: false,
                    inputType: TextInputType.text,
                    enableCurrencyMode: false,
                    next: false,
                    focusNode: null,
                  ),
                  SizedBox(height: kPadding),
                  GestureDetector(
                    onTap: () async {
                      DataService ds = DataService();
                      DataRepository dr = DataRepository();
                      String ticker = widget.textEditingController.text
                          .trim()
                          .toUpperCase();

                      if (ticker.isEmpty) {
                        //Navigator.of(context).pop();
                        showCustomErrorDialog(
                            widget.dialogContext, 'Please enter a symbol.');
                      } else if (await dr.isTickerInFavorites(ticker)) {
                        showCustomErrorDialog(widget.dialogContext,
                            'Ticker $ticker is already in favorites list!');
                      } else if (!await ds.isTickerValid(ticker)) {
                        showCustomErrorDialog(widget.dialogContext,
                            'Unable to fetch data for ticker $ticker');
                      } else {
                        //print(ticker);
                        BlocProvider.of<FavoriteItemsCubit>(context)
                            .addTicker(ticker);
                        widget.textEditingController.clear();
                        Navigator.of(context).pop();
                      }
                    },
                    child: Container(
                      height: 45,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: kThemeColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(kBorderRadius + 5),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Add",
                          style: TextStyle(
                            color: kMainBGcolor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Positioned(
          //   top: -40,
          //   child: CircleAvatar(
          //     backgroundColor: Colors.white,
          //     radius: 40,
          //     child: CircleAvatar(
          //       backgroundColor: Colors.green,
          //       radius: 30,
          //       child: Center(
          //         child: Icon(
          //           Icons.check,
          //           size: 50,
          //           color: Colors.white,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

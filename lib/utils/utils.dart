import 'package:flutter/material.dart';
import 'package:oural_go/utils/constants.dart';

Color determineBGColor(double value) {
  if (value > 0) {
    return kBullish.withOpacity(0.2);
  } else {
    return kBearish.withOpacity(0.2);
  }
}

Color determineTextColor(double value) {
  if (value > 0) {
    return kBullish;
  } else {
    return kBearish;
  }
}

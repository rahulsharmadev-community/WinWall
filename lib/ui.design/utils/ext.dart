import 'package:flutter/widgets.dart';

extension ExtSize on Size {
  dynamic adopt(dynamic small, dynamic medium, dynamic large) {
    double sw = 1080;
    double mw = 1980;
    if (width < sw) {
      return small;
    } else if (width < mw) {
      return medium;
    } else {
      return large;
    }
  }
}

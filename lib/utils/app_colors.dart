import 'package:flutter/material.dart';


class AppColors {
  static Map<int, Color> color = {
    50: primaryColor,
    100: primaryColor,
    200: primaryColor,
    300: primaryColor,
    400: primaryColor,
    500: primaryColor,
    600: primaryColor,
    700: primaryColor,
    800: primaryColor,
    900: primaryColor,
  };

  static MaterialColor materialColor = MaterialColor(primaryColor.value, color);

  
  static Color primaryColor = const Color(0xff105CDB);
  static Color primaryColorLight = const Color(0xffABCEF5);

  static Color greyHintTextColor = const Color(0xff9A9A9A);
  static Color solidTextColor = const Color(0xff474747);


  // static LinearGradient primaryGradient = LinearGradient(
  //   begin: Alignment.centerLeft,
  //   end: Alignment.centerRight,
  //   colors: [
  //     HexColor("#FFFFFF"),
  //     HexColor("#916BBF"),
  //   ],
  // );

}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthfix/size_config.dart';

const String appName = "Healthfix";

const kPrimaryColor = Color(0xFF01B2C6);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF01B2C6), Colors.cyan],
);
const kSecondaryColor = Color(0xFF223263);
const kTextColor = Color(0xFF757575);
const kHeadingColor = Color(0xFF0d1f2d);

const kAnimationDuration = Duration(milliseconds: 200);

const double screenPadding = 10;

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

// Custom Font Styles
cusHeadingStyle([double fs, Color color, bool hasShadow]) =>
    GoogleFonts.poppins(
      textStyle: TextStyle(
        color: color ?? Colors.black,
        fontSize: fs ?? getProportionateScreenWidth(20),
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        shadows: <Shadow>[
          if (hasShadow ?? false)
            Shadow(
              // offset: Offset(10.0, 10.0),
              blurRadius: 10.0,
              color: Color.fromARGB(150, 0, 0, 0),
            ),
          if (hasShadow ?? false)
            Shadow(
              offset: Offset(1.0, 3.0),
              blurRadius: 40.0,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
        ],
      ),
    );

cusBodyStyle([double fs]) => GoogleFonts.poppins(
  textStyle: TextStyle(
    color: Colors.black,
    fontSize: fs ?? getProportionateScreenWidth(12),
    fontWeight: FontWeight.w300,
    letterSpacing: 0.3,
  ),
);

var cusHeadingLinkStyle = GoogleFonts.poppins(
  textStyle: TextStyle(
    color: kPrimaryColor,
    fontSize: getProportionateScreenWidth(14),
  ),
);

cusCenterHeadingStyle([Color color, FontWeight fw, num fs]) => GoogleFonts.poppins(
      textStyle: TextStyle(
        color: color ?? Colors.black,
        fontSize: fs ?? getProportionateScreenWidth(20),
        fontWeight: fw ?? FontWeight.w500,
        letterSpacing: 0.5,
      ),
    );

var cusCenterHeadingAccentStyle = GoogleFonts.poppins(
  textStyle: TextStyle(
    color: kPrimaryColor,
    fontSize: getProportionateScreenWidth(20),
  ),
);

var cusPdctCatNameStyle = GoogleFonts.poppins(
  textStyle: TextStyle(
    letterSpacing: 0.3,
    color: kTextColor.withOpacity(0.8),
    fontSize: 12,
    // fontSize: getProportionateScreenHeight(8),
    fontWeight: FontWeight.w400,
  ),
);

cusPdctDisPriceStyle([double fs]) => GoogleFonts.poppins(
      textStyle: TextStyle(
        color: kPrimaryColor,
        // fontWeight: FontWeight.w600,
        fontSize: fs ?? 16,
        letterSpacing: 0.5,
      ),
    );

cusPdctOriPriceStyle([double fs]) => GoogleFonts.poppins(
      textStyle: TextStyle(
        color: kTextColor,
        decoration: TextDecoration.lineThrough,
        fontWeight: FontWeight.normal,
        fontSize: fs ?? 14,
        // letterSpacing: 0.5,
      ),
    );

var cusPdctNameStyle = GoogleFonts.poppins(
  textStyle: TextStyle(
    color: kSecondaryColor,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    letterSpacing: 0.5,
  ),
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";
const String FIELD_REQUIRED_MSG = "This field is required";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

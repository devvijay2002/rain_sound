
import 'package:flutter/material.dart';


  const Color secondaryColor = Color(0xFF27AEB7);
  const Color dimWhite = Colors.white70;
  const Color dimBlackColor =  Color(0xff636363);
  Color dimBlackColor2 = Colors.black54.withOpacity(0.65);
  const Color blueColor = Colors.blueAccent;
  const Color kPrimaryColor = Color(0xff123F83);
  const Color kCardColor = Color(0xffebf3f5);
  const Color dimGreyColor = Color(0xffC9C9C9);
const Color dimRedColor = Color(0xFFFFD6D6);
  Color redAccent = Colors.redAccent.withOpacity(0.5);
  const Color blueAccent = Color(0xFF0008FF);
  const Color dimLightGreyScreen = Color(0xFFF5F5F5);
  const Color categoryScreenLightGrey = Color(0xFFF1F0F6);
  const Color categoryScreenLightPurple = Color(0xFF877CA7);
  const Color bookingWalletGreen = Colors.green;
  const Color error = Colors.red;
  const Color success = Colors.green;
  const Color info = Colors.blue;
  const Color warn = Colors.yellow;
  const Color borderColor=Colors.grey;
  const Color cardColor = Color(0xffe7f6f4);
  const kPrimaryGradient = LinearGradient(
     colors: [
       kPrimaryColor,
       kPrimaryColor,
        ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
var kDisableColour = const LinearGradient(
  colors: [
    ///create a gradient for grey colour
    Colors.grey,
    Colors.grey
  ],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

  const kPrimaryGradient2 = LinearGradient(
     colors: [
       Color(0xff123F83),
       Color(0xff0055D5),
        ],
    begin: Alignment.topCenter,
    end: Alignment.centerRight,
  );

const constKPrimaryOutlineBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(8)),
  borderSide: BorderSide(
    color: Colors.grey,
  ),
);

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rain_round/const/colors.dart';
class KCustomButton extends StatelessWidget {
  const KCustomButton(
      {super.key,
        required this.buttonText,
        this.onTap,
        this.gradient,
        this.isOutline = false,
        this.textStyle,
        this.verticalPadding,
        this.horizontalPadding,
        this.radius =8,
        this.iconChild});
  final String buttonText;
  final double? verticalPadding;
  final double? horizontalPadding;
  final double radius;
  final TextStyle? textStyle;
  final Widget? iconChild;
  final LinearGradient? gradient;
  final void Function()? onTap;
  final bool isOutline;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isOutline
              ? Colors.white
              : gradient == null
              ? Colors.white
              : null,
          borderRadius: BorderRadius.circular(radius ??8),
          border: isOutline ? Border.all(color: Colors.white) : null,
          gradient:isOutline?null : gradient ?? kPrimaryGradient,
          boxShadow: isOutline
              ? null
              : [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8.0,
              offset: const Offset(0, 4),
            )
          ],
        ),

        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: horizontalPadding ?? 5,vertical: verticalPadding ?? Get.height/360 *6),
          child: Center(
            child: iconChild == null
                ? Text(
              buttonText,
              style: textStyle ??
                  const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.normal),
            )
             : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  buttonText,
                  style: textStyle ??
                      const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                ),
                const SizedBox(width: 10),
                iconChild!
              ],
            ),
          ),
        ),
      ),
    );
  }
}
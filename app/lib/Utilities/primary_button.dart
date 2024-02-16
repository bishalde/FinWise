import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:finwise/Themes/themes.dart';

Widget primaryButton(
    {required String label,
    required IconData icon,
    required VoidCallback onTap}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 10.0),
    child: TextButton.icon(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: Get.theme.textColor,
        padding: const EdgeInsets.all(15),
        fixedSize: Size.fromWidth(Get.size.width),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Get.theme.colorPrimary,
      ),
      icon: Icon(
        icon,
      ),
      label: Text(
        label,
        style: GoogleFonts.quicksand(
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: Get.theme.textColor),
      ),
    ),
  );
}

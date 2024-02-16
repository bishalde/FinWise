import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// A widget function using SvgPicture.asset in that use 'assets/images/logo.svg' as a parameter
Widget fineaseLogo() {
  return SvgPicture.asset(
    'assets/images/logo.svg',
    width: 140,
  );
}

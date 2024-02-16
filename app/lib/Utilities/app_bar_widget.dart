import 'dart:ui';

import 'package:flutter/material.dart';

import 'finease_logo.dart';

AppBar fineaseAppBar() {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    title: fineaseLogo(),
    centerTitle: true,
    flexibleSpace: ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          color: Colors.transparent,
        ),
      ),
    ),
  );
}

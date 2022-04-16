import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:velocity_x/velocity_x.dart';

void navigateToPageWhileContextBuilding(
    {required BuildContext context, required Widget page}) {
  WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
    context.nextReplacementPage(page);
  });
}

Future<void> loading(String status, {bool show = true}) async {
  if (show) {
    await EasyLoading.show(
        status: status,
        indicator: CircularProgressIndicator(
          color: Vx.hexToColor('#dafb50'),
          strokeWidth: 5.0,
          backgroundColor: Vx.hexToColor(Vx.whiteHex),
        ));
  } else {
    await EasyLoading.dismiss();
  }
}

void showSnackbar(
    {required BuildContext context,
    required String message,
    bool isError = false}) {
  Color color = Vx.hexToColor('#dbfa54');
  if (isError) {
    color = Vx.hexToColor(Vx.redHex300);
  }

  final SnackBar snackBar = SnackBar(
      backgroundColor: color,
      content: message.text.hexColor(Vx.whiteHex).semiBold.make());

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

/// internet checker
Future<bool> checkForInternet() async {
  final result = await Connectivity().checkConnectivity();

  if (result == ConnectivityResult.mobile ||
      result == ConnectivityResult.wifi) {
    return true;
  }

  return false;
}

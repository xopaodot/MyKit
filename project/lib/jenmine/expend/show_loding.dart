import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class CommonUtil {
  static Future<Null> showLoadingDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Material(
              color: Colors.transparent,
              child: WillPopScope(
                  onWillPop: () => Future.value(false),
                  child: const Center(
                    child: CupertinoActivityIndicator(),
                  )));
        });
  }
}
import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/utils/color_util.dart';

// 按钮可点击时的样式
final TextStyle _availableStyle =
TextStyle(fontSize: 26, color: ColorUtil.fromHex('#FFFFFF'));
// 按钮禁用时的样式
final TextStyle _unavailableStyle =
TextStyle(fontSize: 13, color: ColorUtil.fromHex('#999999'));
// 按钮可点击时背景的样式
final BoxDecoration _availableBox = BoxDecoration(
  color: ColorUtil.fromHex('#25c37e'),
  borderRadius: BorderRadius.all(Radius.circular(12)),
);
// 按钮不可点击时背景的样式
final BoxDecoration _unavailableBox = BoxDecoration(
  color: Color(0xFFEEEEEE),
  // border: Border.all(color: ColorUtil.fromHex('#666666'), width: 2),
  borderRadius: BorderRadius.all(Radius.circular(24)),
);

class formCode extends StatefulWidget {
  /// 倒计时的秒数，默认60秒。
  final int countdown;

  /// 用户点击时的回调函数。
  final Function onTapCallback;

  /// 是否可以获取验证码，默认为`false`。
  bool available;

  formCode({
    this.countdown = 3,
    required this.onTapCallback,
    this.available = true,
  });

  @override
  State<formCode> createState() => _formCodeState();
}

class _formCodeState extends State<formCode> {
  /// 倒计时的计时器。
  late Timer _timer;

  /// 当前倒计时的秒数。
  late int _seconds;
  // 初始化文本
  late String _verifyStr;

  @override
  void initState() {
    super.initState();
    _seconds = widget.countdown;
    _verifyStr = '${widget.countdown}s';
  }

  /// 启动倒计时的计时器。
  void _startTimer() {
    setState(() {
      widget.available = false;
    });
    widget.onTapCallback();
    // 计时器（`Timer`）组件的定期（`periodic`）构造函数，创建一个新的重复计时器。
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds == 1) {
        _cancelTimer();
        _seconds = widget.countdown;
        _verifyStr = '${widget.countdown}s';
        setState(() {
          widget.available = true;
        });
        return;
      }
      _seconds--;
      _verifyStr = '${_seconds}s';
      setState(() {});
    });
  }

  /// 取消倒计时的计时器。
  void _cancelTimer() {
    // 计时器（`Timer`）组件的取消（`cancel`）方法，取消计时器。
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return widget.available
        ? GestureDetector(
      child: Container(
        width: 100,
        height: 48,
        margin: EdgeInsets.only(left: 20),
        decoration: _unavailableBox,
        child: Center(
          child: Text(
            'identifying code',
            style: TextStyle(
                fontSize: 13, color: ColorUtil.fromHex('#999999')),
          ),
        ),
      ),
      onTap: _startTimer,
    )
        : GestureDetector(
        child: Container(
          width: 100,
          height: 48,
          margin: EdgeInsets.only(left: 20),
          decoration: _unavailableBox,
          child: Center(
            child: Text(
              '${_verifyStr}',
              style: _unavailableStyle,
            ),
          ),
        ),
        onTap: _seconds == widget.countdown ? _startTimer : null);
  }
}


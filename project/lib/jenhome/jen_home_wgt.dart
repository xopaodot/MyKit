// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'jen_start_page.dart';
import 'package:project/jenhome/pages/jen_control_info.dart';
import 'package:project/jenhome/pages/jen_date_set.dart';
import 'jen_home_controller.dart';
import 'package:get/get.dart';

class JenHomewgt extends StatefulWidget {
  const JenHomewgt({Key? key}) : super(key: key);

  @override
  State<JenHomewgt> createState() => _JenHomewgtState();
}

class _JenHomewgtState extends State<JenHomewgt> {

  final controller = Get.put(JenHomeController());
  var _currentPage = 0;

  //首页显示内容根据本地数据加载
  final List _pages = [
    const JenStartPage(),
    JenDateSet(),
    JenControlDayInfo()
  ];

  //设置数据中的pagehome
  Future<void> setStartState() async {
    var user = await SharedPreferences.getInstance(); //初始化
    int nowPage = user.getInt("homePageIndex") ?? 0;
    setState(() {
      _currentPage = nowPage;
      controller.nextStep.value = nowPage;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setStartState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF7C7),
      body: Obx(() {
        return _pages[controller.nextStep.value];
      }),
    );
  }
}



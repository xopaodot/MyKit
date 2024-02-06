import 'package:flutter/material.dart';
import 'package:project/jenhome/jen_home_wgt.dart';
import 'package:project/jenlog/jen_log_collection.dart';
import 'package:project/jenmine/jen_mine_page.dart';
import './image_contioner.dart';
import 'jen_bottom_nav/logic.dart';
import 'jen_bottom_nav/view.dart';
import 'package:get/get.dart';
// import './jen_bottom_nav/view.dart';

class JenBottomNavigate extends StatefulWidget {
  const JenBottomNavigate({Key? key}) : super(key: key);

  @override
  State<JenBottomNavigate> createState() => _JenBottomNavigateState();
}

class _JenBottomNavigateState extends State<JenBottomNavigate> {
  final logic = Get.put(Jen_bottom_navLogic());
  final int current = 0;
  final List<String> homeBanners = [];
  final String homeTitle = 'day num';
  final String userName = 'none';
  final String userChange = 'Yes';
  final String desc = 'sure Stop';
  final String date = 'yyyy-mm-dd';
  final String books = '';
  final String delicate = '';

  final List<Widget> _wList = [
    const JenHomewgt(),
    const JenStopLog(),
    const JenMinePage(),
  ];
  final List<String> _tList = [
    '/itemsButton',
    '/jumpAbout',
    '/login',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()=> _wList[logic.selectIndex.value]),
      bottomNavigationBar: Jen_bottom_navPage(),
    );
  }
}

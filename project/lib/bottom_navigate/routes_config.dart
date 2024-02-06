import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:project/jen_login/jen_login_page.dart';
import 'package:project/bottom_navigate/jen_bottom_bar.dart';
import 'package:project/jenlog/jen_log_record.dart';
import 'package:project/jenhome/smoking_record/smoking_record.dart';
import 'package:project/jenhome/smoking_record/statistical_chart.dart';
import 'package:project/jenmine/about/system_set_page.dart';
import 'package:project/jenmine/expend/about_me.dart';
import 'package:project/jenmine/expend/brand_add.dart';
import 'package:project/jenmine/brand/mine_help.dart';
import 'package:project/jen_login/custom_webview.dart';
import 'package:project/load_page/load_page.dart';
import '../jenmine/brand/brand_info.dart';

class JenAppRoutes {
   static final routes = [
     GetPage(name: "/", page: () => const JenBottomNavigate()),
     GetPage(name: "/net", page: () => const  JenLoadPage()),
     GetPage(name: "/login", page: () => const JenstartLogin()),
     GetPage(name: "/record", page: () => const JenLogRecord()),
     GetPage(name: "/smokingRecord", page: () => const SmokingRecordList()),
     GetPage(name: "/chart", page: () => StaticalCustomChart()),
     GetPage(name: "/set", page: () => const SystemSetPage()),
     GetPage(name: "/about", page: () => const JenAboutMePage()),
     GetPage(name: "/addBrand", page: () => const JenAddBarnds()),
     GetPage(name: "/connectUs", page: () => const JenConnectUs()),
     // GetPage(name: "/web", page: () => JenMyWebViewPage()),
   ];
}



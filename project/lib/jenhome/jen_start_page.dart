
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bottom_navigate/image_contioner.dart';
import 'jen_navigation_style.dart';
import 'package:get/get.dart';
import 'jen_home_controller.dart';
import '../jen_login/jen_login_page.dart';

class JenStartPage extends StatefulWidget {
  const JenStartPage({super.key});

  @override
  State<JenStartPage> createState() => _JenStartPageState();
}

class _JenStartPageState extends State<JenStartPage> {

  final controller = Get.put(JenHomeController());
  var _currentPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isNeedLogin();
  }

  Future<void> isNeedLogin() async {
    var user = await SharedPreferences.getInstance(); //初始化
    String uid = user.getString("uid") ?? "";
    if (uid.isEmpty) {
      //跳转到登陆
      Get.toNamed("/login", preventDuplicates:false);
    }
  }

  Future<void> setStartStatePage(int pageIndex) async {
    var user = await SharedPreferences.getInstance(); //初始化
    user.setInt("homePageIndex", pageIndex);
  }

  //设置数据中的pagehome
  Future<void> setStartState(int pageIndex) async {
    var user = await SharedPreferences.getInstance(); //初始化
    int nowPage = user.getInt("homePageIndex") ?? 0;
    setState(() {
      _currentPage = nowPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        JenTopNavigateStyle( titleInfo: '0 - 15 days task'),
        Center(
          child: Stack(
            children: [
              GestureDetector(
                child: Align(
                  alignment: const FractionalOffset(0.5, 0.45),
                  child: ImageBox(imageName: 'jen_bf.png', w: 200, h: 200),
                ),
                onTap: () {
                  controller.setNextStep(1);
                  setStartStatePage(1);//调整本地数据
                },
              ),
              IgnorePointer(
                  child: Align(
                    alignment: const FractionalOffset(0.5, 0.43),
                    child: ImageBox(imageName: 'jen_star.png', w: 50, h: 50),
                  )
              ),
              const IgnorePointer(
                  child: Align(
                    alignment: FractionalOffset(0.5, 0.5),
                    child: Text('Quit Smoking'),
                  )
              ),
            ],
          ),
        ),
        Center(
          child: Align(
            alignment: const FractionalOffset(0.5, 0.71),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: Container(
                padding: const EdgeInsets.all(10),
                child: const Text('Preparation Phase | smoking cessation phase | quit smoking day | Relapse phase',style: TextStyle(color: Color(0xFF8CD8C1), fontSize: 14,fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        )
      ],
    );
  }
}

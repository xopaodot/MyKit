
import 'package:flutter/material.dart';
import 'package:project/gen_a/custom_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'date_select.dart';
import 'package:project/jenhome/jen_navigation_style.dart';
import 'package:project/jenhome/jen_navgitate_panl/date_Set_logic.dart';
import 'package:get/get.dart';
import 'package:project/jenhome/jen_home_controller.dart';

class JenDateSet extends StatelessWidget {
  JenDateSet({Key? key}) : super(key: key);

  final logic = Get.put(JenDteSet());
  final controller = Get.put(JenHomeController());

  Future<void> setStartStatePage(int pageIndex) async {
    var user = await SharedPreferences.getInstance(); //初始化
    user.setInt("homePageIndex", pageIndex);
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final width =size.width;
    final height =size.height;

    return  SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: width,
            height: 200,
            child: Stack(
              children: [
                JenTopNavigateStyle( titleInfo: 'quit smoking day'),
                const Positioned(
                  bottom: 18,
                  left: 20,
                  child: Text('Time Setting', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                )
                // ConstrainedBox(
                //   constraints: const BoxConstraints(
                //       minWidth: double.infinity, //宽度尽可能大
                //       minHeight: 30.0 //最小高度为50像素
                //   ),
                //   child: const Padding(
                //     padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                //     child: Text('Time Setting', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                //   ),
                // )
              ],
            ),
          ),
          // ConstrainedBox(
          //   constraints: const BoxConstraints(
          //     minWidth: double.infinity, //宽度尽可能大
          //     minHeight: 30.0 //最小高度为50像素
          //   ),
          //   child: const Padding(
          //     padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          //     child: Text('Time Setting', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          //   ),
          // ),
          ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: width-40, //宽度尽可能大
                minHeight: 50.0 //最小高度为50像素
            ),
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
              color: Colors.white,
              child: const Text.rich(TextSpan(
                  children:[
                    TextSpan(text: '0', style: TextStyle(color: Color(0xFF8CD8C1))),
                    TextSpan(text: ' cigarettes per day', style: TextStyle(color: Color(0xED666666)))
                  ]
              )),
            ),
          ),
          SizedBox(
            width: width-40,
            height: 1,
            child: Container(
              decoration: const BoxDecoration(color: Color(0xFFEEEEEE)),
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: width-40, //宽度尽可能大
                minHeight: 35.0 //最小高度为50像素
            ),
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              color: Colors.white,
              child: Obx(() => Text.rich(TextSpan(
                  children:[
                    TextSpan(text: '${logic.dayCount.value} days in total', style: const TextStyle(color: Color(0xFF8CD8C1), fontSize: 18, fontWeight: FontWeight.bold))
                  ]
              ))),
            ),
          ),
          SizedBox(
            width: width-40,
            height: 400,
            child: TableRangeExample(),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            child: DecoratedBox(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(colors:[Color(0xFF71CAAE),Color(0xFF8CD8C1)]), //背景渐变
                    borderRadius: BorderRadius.circular(25.0), //3像素圆角
                    boxShadow: const [ //阴影
                      BoxShadow(
                          color:Colors.black54,
                          offset: Offset(2.0,2.0),
                          blurRadius: 5.0
                      )
                    ]
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: (width-185)/2, vertical: 15.0),
                  child: const Text("Confirm Time", style: TextStyle(color: Colors.white),),
                )
            ),
            onTap: (){
              //判断
              if (logic.dayCount.value < 5) {
                Toast.toast(context, msg: "more then five days!");
                return;
              }
              controller.setNextStep(2);
              setStartStatePage(2);//调整本地数据
            },
          )
        ],
      ),
    );
  }
}

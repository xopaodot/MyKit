import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/bottom_navigate/image_contioner.dart';
import 'package:get/get.dart';
import 'package:project/jenhome/jen_navigation_style.dart';

import '../jen_login/custom_webview.dart';
import 'package:project/jenmine/brand/mine_help.dart';

class JenMinePage extends StatefulWidget {
  const JenMinePage({Key? key}) : super(key: key);

  @override
  State<JenMinePage> createState() => _JenMinePageState();
}

class _JenMinePageState extends State<JenMinePage> {
  final userNickname = 'jiejie';

  static const platform = MethodChannel('plugin_apple');
  void _getNativeMessage() async{
    String result;
    try {
      // OC回调中对应的”约定” : getFlutterMessage,[1,2,3]:传递参数
      result = await platform.invokeMethod('getFlutterMessage');
    } on PlatformException catch (e) {
      result = "error message $e";
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            headerWidget(),
            Container(
                padding: const EdgeInsets.all(16),
                child: const Text('cigarette brand')),
            GestureDetector(
              child: myCell('my_xq.png', 'cigarette brand', false),
              onTap: (){
                Get.toNamed("/addBrand");
              },
            ),
            Container(
                padding: const EdgeInsets.all(16),
                child: const Text('Common tool')),
            // myCell('my_xiaoxi.png', 'message notification', true),
            GestureDetector(
              child: myCell('my_kf_icon.png', 'Customer Service', true),
                onTap: (){
                  // Get.toNamed("/connectUs");
                  Get.to(const JenMyWebViewPage(toUrl: 'https://www.showdoc.com.cn/p/38a0b7eb315cf3b6bddb22c342c1b20f', toName: 'Contact Us'));

                }
            ),
            GestureDetector(
              child: myCell('my_help_icon.png', 'help feedback', true),
                onTap: (){
                  Get.to(const MineFaceBack());
                }
            ) ,
            GestureDetector(
              child: myCell('my_about.png', 'about me', true),
                onTap: (){
                  Get.toNamed("/about");
                }
            ) ,
          ],
        ));
  }

  Widget headerWidget() {
    return SizedBox(
      height: 264,
      child: Stack(
        fit: StackFit.expand,
        children: [
          //添加个图片
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 264,
              child: ImageBox(imageName: 'my_bj.png')),
          //添加设置按钮
          Positioned(
              right: 20,
              top: MediaQuery.of(context).padding.top + 15,
              child: GestureDetector(
                child: ImageBox(imageName: 'jen_set.png', h: 25, w: 25),
                onTap: () {
                  Get.toNamed("/set");
                },
              )),
          //头像和nickname
          Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              height: 116,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 20),
                  Container(
                      width: 106,
                      height: 106,
                      clipBehavior: Clip.hardEdge, //超出部分，可裁剪
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(53.0),
                      ),
                      child:
                          Image.asset('images/my_head.jpeg', fit: BoxFit.fill)
                      // ImageBox(imageName: 'my_head.jpeg',h: 50,w: 50)
                      ),
                  const SizedBox(width: 16),
                  Expanded(
                      child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(userNickname,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  )),
                  SizedBox(
                      width: 20,
                      height: 116,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: ImageBox(
                            imageName: 'my_right_grey.png', h: 20, w: 20),
                      )),
                  const SizedBox(width: 15)
                ],
              ))
        ],
      ),
    );
  }

  //定义cell样式
  Widget myCell(String iconName, String text, bool showRight) {
    List<Widget> list = [
      ImageBox(imageName: iconName),
      const SizedBox(width: 18),
      Expanded(
          child: Text(text, style: const TextStyle(color: Color(0xFF333333)))),
      Visibility(
          visible: showRight, child: ImageBox(imageName: 'my_right_grey.png'))
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 44,
      color: Colors.white,
      child: Row(
        children: list,
      ),
    );
  }
}

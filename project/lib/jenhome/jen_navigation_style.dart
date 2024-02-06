
import 'package:flutter/material.dart';
import 'jen_navgitate_panl/logic.dart';
import 'package:get/get.dart';
import 'package:project/bottom_navigate/image_contioner.dart';

class JenTopNavigateStyle extends StatelessWidget {
  JenTopNavigateStyle({Key? key, required this.titleInfo}) : super(key: key);

  final logic = Get.put(Jen_navgitate_panlLogic());
  final String titleInfo;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Stack(
      children: [
        Positioned(top: 0,left: 0,right: 0 , child: ImageBox(imageName: 'bj.png',h: 200)),//387/750*width
        Positioned(top: MediaQuery.of(context).padding.top + 10,left: 100,right: 100,height: 30, child: Text(titleInfo, textAlign: TextAlign.center,style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white)))
      ],
    );
    // return ShaderMask(
    //   shaderCallback: (Rect bounds) {
    //     return const LinearGradient(
    //       begin: Alignment.topCenter,
    //       end: Alignment.bottomCenter,
    //       colors: [Color(0xFF71CAAE),Color(0xFFFFF7C7)],
    //     ).createShader(bounds);
    //   },
    //   blendMode: BlendMode.color,
    //   child: SizedBox(
    //     width: width,
    //     height: 0.22*height,
    //     child: Container(
    //       padding: const EdgeInsets.fromLTRB(100, 20, 100, 0),
    //       alignment: Alignment.topCenter,
    //       child: Text(titleInfo, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.white)),
    //     ),
    //   ),
    // );
  }
}

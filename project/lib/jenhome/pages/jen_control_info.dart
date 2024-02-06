import 'package:flutter/material.dart';
import 'package:project/jenhome/jen_navigation_style.dart';
import 'package:project/bottom_navigate/image_contioner.dart';
import 'package:get/get.dart';
import 'package:project/jenhome/jen_navgitate_panl/date_Set_logic.dart';
import './control_infos/control_nums_button.dart';
import './control_infos/control_logic.dart';

class JenControlDayInfo extends StatefulWidget {
  const JenControlDayInfo({super.key});

  @override
  State<JenControlDayInfo> createState() => _JenControlDayInfoState();
}

class _JenControlDayInfoState extends State<JenControlDayInfo> {

  final controller = Get.put(JenControlLogic());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.pinnedNumbers();
  }


  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: Stack(
        children: [
          JenTopNavigateStyle(titleInfo: 'quit smoking day'),
          //添加右侧的记录
          Positioned(right: 20, top: MediaQuery.of(context).padding.top + 17, child: GestureDetector(
            child: const Text('record', style: TextStyle(color: Colors.white, fontSize: 13)),
            onTap: () {
              Get.toNamed("/smokingRecord");
            },
          )),
          //统计图标样式
          Positioned(right: 16, top: MediaQuery.of(context).padding.top + 90, width: 62, height: 32, child: GestureDetector(
            child: ImageBox(imageName: 'jen_tubiao.png'),
            onTap: () {
              Get.toNamed("/chart");
            },
          )),
          //sos
          Positioned(right: 20, top: MediaQuery.of(context).padding.top + 140, width: 55, height: 55, child: GestureDetector(
            child: ImageBox(imageName: 'jen_sos.png'),
            onTap: () {
              print("sos");
            },
          )),
          Positioned(
              left: 0,
              right: 0,
              top: MediaQuery.of(context).padding.top + 206,
              height: 420,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                      top: 0,
                      child: GestureDetector(
                        child: ImageBox(imageName: 'jen_fs.png',w: 220,h: 220),
                        onTap: (){
                          print("nihao");
                        },
                      )
                  ),
                  Positioned(
                      top: 70,
                      child: IgnorePointer(
                        child: Obx(() => Text('${controller.totalScore} Score', style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white))),
                      )
                  ),
                  const Positioned(
                      top: 120,
                      child: IgnorePointer(
                        child: Text('Quit Smoking Score', style: TextStyle(fontSize: 16, color: Colors.white)),
                      )
                  ),
                  Positioned(
                    top: 180,
                    child: Image.asset('images/jen_fei.png',width: 220),
                  )
                ],
              )
          ),
          Positioned(left: 0,right: 0, top: MediaQuery.of(context).padding.top + 600, height: 150, child: const ControlNumsButton()),
        ],
      ),
    );
  }
}


// class JenControlDayInfo extends StatelessWidget {
//   JenControlDayInfo({Key? key}) : super(key: key);
//   final controller = Get.put(JenControlLogic());
//
//
//   @override
//   Widget build(BuildContext context) {
//     return ConstrainedBox(
//       constraints: const BoxConstraints.expand(),
//       child: Stack(
//         children: [
//           JenTopNavigateStyle(titleInfo: 'quit smoking day'),
//           //添加右侧的记录
//           Positioned(right: 20, top: MediaQuery.of(context).padding.top + 17, child: GestureDetector(
//             child: const Text('record', style: TextStyle(color: Colors.white, fontSize: 13)),
//             onTap: () {
//               Get.toNamed("/smokingRecord");
//             },
//           )),
//           //统计图标样式
//           Positioned(right: 16, top: MediaQuery.of(context).padding.top + 90, width: 62, height: 32, child: GestureDetector(
//             child: ImageBox(imageName: 'jen_tubiao.png'),
//             onTap: () {
//               Get.toNamed("/chart");
//             },
//           )),
//           //sos
//           Positioned(right: 20, top: MediaQuery.of(context).padding.top + 140, width: 55, height: 55, child: GestureDetector(
//             child: ImageBox(imageName: 'jen_sos.png'),
//             onTap: () {
//               print("sos");
//             },
//           )),
//           Positioned(
//               left: 0,
//               right: 0,
//               top: MediaQuery.of(context).padding.top + 206,
//               height: 420,
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   Positioned(
//                     top: 0,
//                     child: GestureDetector(
//                       child: ImageBox(imageName: 'jen_fs.png',w: 220,h: 220),
//                       onTap: (){
//                         print("nihao");
//                       },
//                     )
//                   ),
//                   Positioned(
//                     top: 70,
//                     child: IgnorePointer(
//                       child: Obx(() => Text('${controller.totalScore} Score', style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white))),
//                     )
//                   ),
//                   const Positioned(
//                     top: 120,
//                     child: IgnorePointer(
//                       child: Text('Quit Smoking Score', style: TextStyle(fontSize: 16, color: Colors.white)),
//                     )
//                   ),
//                   Positioned(
//                     top: 180,
//                     child: Image.asset('images/jen_fei.png',width: 220),
//                   )
//                 ],
//               )
//           ),
//           Positioned(left: 0,right: 0, top: MediaQuery.of(context).padding.top + 600, height: 150, child: const ControlNumsButton()),
//         ],
//       ),
//     );
//   }
// }

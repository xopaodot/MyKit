import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'control_logic.dart';
import 'package:project/bottom_navigate/image_contioner.dart';

// class ControlNumsButton extends StatelessWidget  {
//   ControlNumsButton({Key? key}) : super(key: key);
//
//   //注入一下
//   final numsLogic = Get.put(JenControlLogic());
//
//
//   @override
//   Widget build(BuildContext context) {
//     final itemWith = MediaQuery
//         .of(context)
//         .size
//         .width / 2 - 40;
//
//     return
//
//   }
// }

class ControlNumsButton extends StatefulWidget {
  const ControlNumsButton({Key? key}) : super(key: key);

  @override
  State<ControlNumsButton> createState() => _ControlNumsButtonState();
}

class _ControlNumsButtonState extends State<ControlNumsButton> with TickerProviderStateMixin {

  //注入一下
  final numsLogic = Get.put(JenControlLogic());
  late AnimationController controller;
  late Animation<double> animation;
  late AnimationController controller2;
  late Animation<double> animation2;
  late CurvedAnimation curve;
  bool _isVail = false;
  bool _isVail1 = false;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    controller2 = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    curve = CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    animation = Tween(begin: 0.0, end: 1.0).animate(controller);
    animation.addListener(() {
      setState(() {

      });
    });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // controller.reverse();
        setState(() {
          _isVail = false;
        });
      } else if (status == AnimationStatus.dismissed) {

      }
    });

    animation2 = Tween(begin: 0.0, end: 1.0).animate(controller2);
    animation2.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isVail1 = false;
        });
      } else {

      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final itemWith = MediaQuery
        .of(context)
        .size
        .width / 2 - 20;

    return Stack(
      children: [
        Positioned(
            left: 0,
            height: 130,
            top: 0,
            width: itemWith,
            child: Stack(
              children: [
              GestureDetector(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(topRight: Radius.circular(65.0),bottomRight: Radius.circular(65.0)),
                      child: Container(
                        decoration: const BoxDecoration(
                          // borderRadius: BorderRadius.only(
                          //   topRight: Radius.circular(75.0),
                          //   bottomRight: Radius.circular(75.0),
                          // ),
                            color: Color.fromRGBO(140, 216, 193, 1),
                            // border: Border(
                            //     left: BorderSide(width: 0,
                            //         color: Color.fromRGBO(211, 243, 233, 1.0)),
                            //     right: BorderSide(width: 10,
                            //         color: Color.fromRGBO(211, 243, 233, 1.0)),
                            //     top: BorderSide(width: 10,
                            //         color: Color.fromRGBO(211, 243, 233, 1.0)),
                            //     bottom: BorderSide(width: 10,
                            //         color: Color.fromRGBO(211, 243, 233, 1.0))
                            // )
                        ),
                        child: Stack(
                          children: [
                            //yan image
                            Positioned(left: itemWith * 0.37,
                                top: 40,
                                child: ImageBox(
                                    imageName: 'likemok.png', h: 25, w: 25)),
                            Positioned(left: itemWith * 0.37 + 40,
                                top: 20,
                                child: Obx(() => Text('${numsLogic.leftNums.value}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 40,color: Colors.white)))),
                            Positioned(left: 0, right: 0,height: 25,top: 75, child: Container(
                              alignment: Alignment.center,child: const Text('pinned down', style: TextStyle(fontSize: 20,color: Colors.white)),
                            )),
                            Positioned(right: 0, top: 0, width: 30, height: 30, child: FadeTransition(
                                opacity: animation,
                                child: Visibility(visible: _isVail, child: const Text('+1',style: TextStyle(color: Colors.white, fontSize: 15,fontWeight: FontWeight.bold,backgroundColor: Colors.redAccent))
                                ))),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _isVail = true;
                      });
                      numsLogic.setLeftNums(1);
                      controller.forward();
                    }
                )
              ],
            )
        ),
        Positioned(
            right: 0,
            height: 130,
            top: 0,
            width: MediaQuery
                .of(context)
                .size
                .width / 2 - 20,
            child: Stack(
              children: [
                GestureDetector(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(65.0),
                      bottomLeft: Radius.circular(65.0),
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                          // borderRadius: BorderRadius.only(
                          //   topLeft: Radius.circular(75.0),
                          //   bottomLeft: Radius.circular(75.0),
                          // ),
                          color: Color.fromRGBO(253, 112, 112, 1),
                          // border: Border(
                          //     left: BorderSide(
                          //         width: 10, color: Color(0xFFEFC3B4)),
                          //     right: BorderSide(
                          //         width: 0, color: Color(0xFFEFC3B4)),
                          //     top: BorderSide(
                          //         width: 10, color: Color(0xFFEFC3B4)),
                          //     bottom: BorderSide(
                          //         width: 10, color: Color(0xFFEFC3B4))
                          // )
                      ),
                      child: Stack(
                        children: [
                          //yan image
                          Positioned(left: itemWith * 0.37,
                              top: 40,
                              child: ImageBox(
                                  imageName: 'likemok.png', h: 25, w: 25)),
                          Positioned(left: itemWith * 0.37 + 40,
                              top: 20,
                              child: Obx(() => Text('${numsLogic.rightNums.value}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 40,color: Colors.white)))),
                          Positioned(left: 0, right: 0,height: 25,top: 75, child: Container(
                            alignment: Alignment.center,child: const Text('I smoked', style: TextStyle(fontSize: 20,color: Colors.white)),
                          )),
                          Positioned(left: 0, top: 0, width: 30, height: 30, child: FadeTransition(
                              opacity: animation2,
                              child: Visibility(visible: _isVail1, child: const Text('+1',style: TextStyle(color: Colors.white, fontSize: 15,fontWeight: FontWeight.bold,backgroundColor: Colors.redAccent)))) )
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _isVail1 = true;
                    });
                    numsLogic.setRightNums(1);
                    controller2.forward();
                  },
                )
              ],
            )
        )
      ],
    );
  }
}

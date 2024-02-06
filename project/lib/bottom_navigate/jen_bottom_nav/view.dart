import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../image_contioner.dart';
import 'logic.dart';

class Jen_bottom_navPage extends StatelessWidget {
  Jen_bottom_navPage({Key? key}) : super(key: key);

  final logic = Get.put(Jen_bottom_navLogic());

  @override
  Widget build(BuildContext context) {
    return Obx( () =>
        BottomNavigationBar(
          currentIndex: logic.selectIndex.value,
          iconSize: 23,
          fixedColor: const Color(0xFF8CD8C1),
          selectedFontSize: 14,
          unselectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: ImageBox(imageName: 'home_grey.png'),
                activeIcon: ImageBox(imageName: 'home.png'),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: ImageBox(imageName: 'rizhi.png'),
                activeIcon: ImageBox(imageName: 'rizhi_green.png'),
                label: 'Log'),
            BottomNavigationBarItem(
                icon: ImageBox(imageName: 'wd_grey.png'),
                activeIcon: ImageBox(imageName: 'wd_bluee.png'),
                label: 'Me'),
          ],
          onTap: (int index) {
            logic.changeIndex(index);
          },
        )
    );
  }
}

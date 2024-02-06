import 'package:get/get.dart';

class Jen_bottom_navLogic extends GetxController {
   var selectIndex = 0.obs;
   void changeIndex(int index) {
     selectIndex.value = index;
   }
}

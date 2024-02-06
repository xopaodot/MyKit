import 'package:get/get.dart';

class Jen_navgitate_panlLogic extends GetxController {

  var title = "quit smoking day".obs;
  var leftImageStr = "".obs;
  var rightImageStr = "".obs;
  var descStr = "".obs;

  void setNavigateTitle(String tit) {
    title.value = tit;
  }
  void setNavigateDesc(String desc) {
    descStr.value = desc;
  }
  void setNavLeftImage(String leftImage) {
    leftImageStr.value = leftImage;
  }
  void setNavRightImageStr(String rightImage) {
    rightImageStr.value = rightImage;
  }
}

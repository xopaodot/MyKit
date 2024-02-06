import 'package:get/get.dart';
class JenHomeController extends GetxController {
  var nextStep = 0.obs;
  void setNextStep(int step) {
    nextStep.value = step;
  }
  // void setNavigateDesc(String desc) {
  //   descStr.value = desc;
  // }
  // void setNavLeftImage(String leftImage) {
  //   leftImageStr.value = leftImage;
  // }
  // void setNavRightImageStr(String rightImage) {
  //   rightImageStr.value = rightImage;
  // }
}
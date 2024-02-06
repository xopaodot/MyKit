import 'package:get/get.dart';

class UserInfoLogic extends GetxController {

  var userName = "".obs;
  var userId = "746238464".obs;
  var userHead = "".obs;
  var currentIndex = 0.obs;
  var isLogin = false.obs;

  void setUserName(String uname) {
    userName.value = uname;
  }
  void setUserId(String rid) {
    userId.value = rid;
  }
  void changeUserHead(String image) {
    userHead.value = image;
  }

  void setCurrentIndex(int indexPage) {
    currentIndex.value = indexPage;
  }

  void setIsLogin(bool islogin) {
    isLogin.value = islogin;
  }

}
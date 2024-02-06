
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JenControlLogic extends GetxController {

  static const String pinnedKey = "pinned";
  static const String needKey = "need";
  static const String scoreKey = "score";

  var leftNums = 0.obs;
  var rightNums = 0.obs;
  var totalScore = 0.obs;
  var isHide = false.obs;

  var descStr = "".obs;

  void setLeftNums(int lnum) {
    ++leftNums.value;
    //保存在本地
    setLocalInfo(leftNums.value, pinnedKey);
    scoreCalculate();
  }

  void pinnedNumbers() {

    // Future<int> future1 = Future();
    getLocalInfo(pinnedKey).then((value) => {
        leftNums.value = value
    });

    getLocalInfo(needKey).then((value) => {
      rightNums.value = value
    });

    getLocalInfo(scoreKey).then((value) => {
      totalScore.value = value
    });

  }

  void setRightNums(int rnums) {
    ++rightNums.value;
    //保存在本地
    setLocalInfo(rightNums.value, needKey);
    scoreCalculate();
  }
  // score jisuan
  void scoreCalculate() {
    totalScore.value = (leftNums.value - rightNums.value)*10;
    //保存本地分数
    setLocalInfo(totalScore.value, scoreKey);
  }

  //设置数据中的pagehome
  Future<void> setLocalInfo(int value, String key) async {
    var sharePre = await SharedPreferences.getInstance(); //初始化
    sharePre.setInt(key, value);
  }
  Future<int> getLocalInfo(String key) async {
    var sharePre = await SharedPreferences.getInstance(); //初始化
    int value = sharePre.getInt(key) ?? 0;
    return value;
  }
}

import 'package:get/get.dart';

class JenDteSet extends GetxController {

  var dayCount = 0.obs;
  var selectStart = "".obs;
  var selectEnd = "".obs;
  var currentSet = "".obs;
  var dayScore = 0.obs;

  void setDayCount(int day) {
    dayCount.value = day;
  }
  void setDayScore(int score) {
    dayScore.value = score;
  }
  void setStart(String start) {
    selectStart.value = start;
  }
  void setEndDate(String end) {
    selectEnd.value = end;
  }
  void setCurrentSet(String current) {
    currentSet.value = current;
  }
}
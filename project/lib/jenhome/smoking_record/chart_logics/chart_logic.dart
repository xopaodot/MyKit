import 'package:get/get.dart';

class ChartRecordLogic extends GetxController {

  var todayVolume = 0.obs;
  var todayIngestion = 0.obs;
  var dateTime = "06-01".obs;

  var units = [].obs;
  var timeMargin = [].obs;

  void setTodayVolume(int volume) {
    todayVolume.value = volume;
  }
  void setTodayIngestion(int ingestion) {
    todayIngestion.value = ingestion;
  }
  void setDateTime(String time) {

    dateTime.value = time;
  }
}
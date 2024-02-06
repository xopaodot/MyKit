// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/bottom_navigate/image_contioner.dart';
import './chart_logics/chart_logic.dart';
import 'chart_custom.dart';
import 'custom_point.dart';

class StaticalCustomChart extends StatelessWidget {
  StaticalCustomChart({Key? key}) : super(key: key);

  static const double topHeigh = 140.0;
  final controller = Get.put(ChartRecordLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  const Color(0xFFF3EBE9),
      appBar: AppBar(
        title: const Text("Statistical Chart"),
        centerTitle: true,
        leading:  Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black), //自定义图标
            onPressed: () {
              // 打开抽屉菜单
              Get.back();
            },
          );
        }),
      ),
      body: Column(
        children: [
          //第一行
          const SizedBox(height: 20),
          Row(children: [
            const SizedBox(width: 20, height: topHeigh),
            Expanded(child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: SizedBox(height: topHeigh,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Column(
                      children: [
                        Expanded(child: Row(children: [ImageBox(imageName: "jm_cy.png")])),
                        const SizedBox(height: 5),
                        const Expanded(child: Text('Today volume', maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: Color(0xFF999999)))),
                        const SizedBox(height: 5),
                        Expanded(child: Row(children: [Text('${controller.todayVolume.value} pieces', style: const TextStyle(color: Color(0xFFDDDDDD)))]) ),
                      ],
                    ),
                  )
              ),
            )),
            const SizedBox(width: 20, height: topHeigh),
            Expanded(child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: SizedBox(height: topHeigh,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Column(
                      children: [
                        Expanded(child: Row(children: [ImageBox(imageName: "jm_time.png")])),
                        const SizedBox(height: 5),
                        Expanded(child: Row(children: const [Text('Last time', overflow: TextOverflow.ellipsis, style: TextStyle(color: Color(0xFF999999)))])),
                        const SizedBox(height: 5),
                        Expanded(child: Row(children: [Text(controller.dateTime.value, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Color(0xFFDDDDDD)))])),
                      ],
                    ),
                  )
              ),
            )),
            const SizedBox(width: 20, height: topHeigh),
            Expanded(child:
              DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: SizedBox(height: topHeigh,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Column(
                      children: [
                        Expanded(child: Row(children: [ImageBox(imageName: "jm_money.png")])),
                        const SizedBox(height: 5),
                        const Expanded(child: Text('today consumption', maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: Color(0xFF999999)))),
                        const SizedBox(height: 5),
                        Expanded(child: Row(children: [Text('${controller.todayIngestion.value}\$',overflow: TextOverflow.ellipsis, style: const TextStyle(color: Color(0xFFDDDDDD)))])),
                      ],
                    ),
                  )
              ),
            )),
            const SizedBox(width: 20, height: topHeigh),
          ]),
          const SizedBox(height: 20),
          Container(
            color: Colors.white,
            child: Row(children: [
              Column(children: buildRulerSize()),
              CustomPaint(
                size: Size(MediaQuery.of(context).size.width-50, 300), //指定画布大小
                painter: LineChartPainter(points: todayRulerData(MediaQuery.of(context).size.width-50)),
              )
            ]),
          ),
          Row(children: todayData())
        ],
      ),
    );
  }
  List<Widget> buildRulerSize(){
    List<Widget> widgets = [];
    for (var i = 10; i > 0; i--) {
      var ruler = '${(i-1)*30}';
      widgets.add(SizedBox(height: 30, width: 50,child: Text(ruler, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12))));
    }
    return widgets;
  }
  List<MyPoint<double>> todayRulerData(double w){
    var magin = w/7;
    return [
      MyPoint(20, 300-60),
      MyPoint(20+magin, 300-120),
      MyPoint(20+magin*2, 300-60),
      MyPoint(20+magin*3, 300-90),
      MyPoint(20+magin*4, 300-180),
      MyPoint(20+magin*5, 300-180)
    ];
  }
  List<Widget> todayData(){
    List<Widget> widgets = [];
    for (var i = 1; i < 9; i++) {
      if (i==1) {
        widgets.add(const SizedBox(width: 35));
      } if (i == 8) {
        widgets.add(const SizedBox(width: 10));
      } else {
        widgets.add(Expanded(child: Text(i.toString(), textAlign: TextAlign.center, style: const TextStyle(fontSize: 12))));
      }
    }
    return widgets;
  }
}

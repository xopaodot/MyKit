
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:get/get.dart';

class SmokingRecordList extends StatefulWidget {
  const SmokingRecordList({Key? key}) : super(key: key);

  @override
  State<SmokingRecordList> createState() => _SmokingRecordListState();
}

class _SmokingRecordListState extends State<SmokingRecordList> {

  List data=[{
    "latter":"2023-05-09",
     "records":[
       {
         "date":"15:33",
         "consume": "0.6",
         "Ingestion": "5mg"
       },
       {
         "date":"21:26",
         "consume": "0.6",
         "Ingestion": "5mg"
       },
     ]
  }];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(""),
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
      body: Stack(
        children: [
          // Positioned(left: 18, top: 12, child: IconButton(
          //   icon: const Icon(Icons.arrow_back),
          //   onPressed: () {
          //     Get.back();
          //   },
          // )),
          const Positioned(left: 18, top: 20, child: Text('Smoking records', style: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w100),)),
          Positioned(left: 0, right: 0, top: 65, height: MediaQuery.of(context).size.height - 115,
            child: ListView.builder(itemBuilder: (context, index) {
              return StickyHeader(
                header: Container(
                  height: 50.0,
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(data[index]['latter'],
                    style: const TextStyle(color: Color(0xFF999999)),
                  ),
                ),
                content: Column(
                  children: buildGroup(data[index]['records']),
                ),
              );
            },
                itemCount: data.length,
                // itemExtent: 200,
                scrollDirection: Axis.vertical,//滚动方向
                padding: const EdgeInsets.all(10)
            ),
          ),

        ],
      ),
    );
  }
  List<Widget> buildGroup(List group){
    return group.map((item){
      return Column(
        children: [
          DecoratedBox(decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFF333333),
          ),
            child:  Container(
              height: 60,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('consume: ${item["consume"]}  Ingestion tar: ${item["Ingestion"]}', maxLines: 1, textAlign: TextAlign.left,style: const TextStyle(color: Color(0xCCEEEEEE))),
                  Expanded(child: Text(item["date"], textAlign: TextAlign.right,overflow: TextOverflow.ellipsis, maxLines: 1,style: const TextStyle(color: Color(0xCCEEEEEE)))),
                  const SizedBox(width: 20)
                ],
              ),
            ),
          ),
          const SizedBox(height: 10)
        ],
      );
    }).toList();
  }
}

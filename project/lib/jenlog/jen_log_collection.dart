
import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:get/get.dart';
import 'jen_log_record.dart';

class JenStopLog extends StatefulWidget {
  const JenStopLog({Key? key}) : super(key: key);

  @override
  State<JenStopLog> createState() => _JenStopLogState();
}

class _JenStopLogState extends State<JenStopLog> {

  List<Widget> getData(){
    List<Widget> list = [];
    for(var i=0;i<20;i++){
      list.add(ListTile(
        title: Text("item $i"),
      ));
    }
    return list;
  }

  List data=[{
    "latter":"2023-05-09",
    "group":[
      {
        "date":"11:22",
        "content": "Eat candy and forget smokingEat candy and forget smokingEat candy and forget smokingEat candy and forget smokingEat candy and forget smoking"
      },
      {
        "date":"15:07",
        "content": "I can't help it hahh"
      }
    ]
  }];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(right: 18, top: MediaQuery.of(context).padding.top + 12, child: GestureDetector(
          child: const Text('Add Log', style: TextStyle(color: Color(0xFF666666), fontSize: 12) ),
          onTap: (){
            Get.toNamed('/record');
          },
        )),
        Positioned(left: 18, top: MediaQuery.of(context).padding.top + 36, child: const Text('quit smoking log', style: TextStyle(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w100),)),
        Positioned(left: 0, right: 0, top: 115, height: MediaQuery.of(context).size.height - 115,
            child: ListView.builder(itemBuilder: (context, index) {
              Color? color;
              if (index % 2 == 0) {
                color = Colors.pink;
              } else if (index % 3 == 0) {
                color = Colors.teal;
              } else if (index % 5 == 0) {
                color = Colors.amber;
              }
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
                  children: buildGroup(data[index]['group']),
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
    );
  }
  List<Widget> buildGroup(List group){
    return group.map((item){
      return Column(
        children: [
          DecoratedBox(decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(10),
              color: const Color(0xFF8CD8C1),
            ),
            child:  Container(
              height: 90,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  Text(item["date"], textAlign: TextAlign.left,style: const TextStyle(color: Colors.white)),
                  const SizedBox(height: 10),
                  Text(item["content"],overflow: TextOverflow.ellipsis, maxLines: 2, textAlign: TextAlign.left,style: const TextStyle(color: Colors.white)),
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

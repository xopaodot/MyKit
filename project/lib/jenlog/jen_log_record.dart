
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/gen_a/custom_toast.dart';

class JenLogRecord extends StatefulWidget {
  const JenLogRecord({super.key});

  @override
  State<JenLogRecord> createState() => _JenLogRecordState();
}

class _JenLogRecordState extends State<JenLogRecord> {

  static final TextEditingController _unameController  = TextEditingController();

  //添加个请求https:
  void _checkLogContent() async {
    // 1.创建Dio请求对象
    final dio = Dio();
    String baseUrl = 'https://yard.zhihuics.com.cn:8090';
    try {
      // 2.发送网络请求{
      Map<String, int> map2 = {};
      map2["pageNum"] = 1;
      map2["pageSize"] = 1;
      final response = await dio.request("$baseUrl/yard/api/article/news/getNewsList", data: map2);

      Get.back();
    } on DioException catch(e) {

      Get.back();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Log", style: TextStyle(color:  Colors.white)),
        centerTitle: true,
        backgroundColor: const Color(0xFF8CD8C1),
        leading:  Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white), //自定义图标
            onPressed: () {
              // 打开抽屉菜单
              Get.back();
            },
          );
        }),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).padding.top + 60,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(8),
                  color: const Color(0xFF8CD8C1),
                  child: const Text('Log Content',style: TextStyle(color: Colors.white,fontSize:36,fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              minLines: 1,
              controller: _unameController,
              decoration: const InputDecoration(
                hintText: 'Please enter the diary content you added',
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                isDense: true,
                border: OutlineInputBorder(
                  // gapPadding: 0,
                  // borderRadius: const BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
            ),
          ),
          //添加个按钮
          Row(
            children: [
              const SizedBox(width: 20),
              Expanded(child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith((states) {
                      return const Color(0xFF8CD8C1);
                    }),
                    textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white)),
                    foregroundColor: MaterialStateProperty.resolveWith(
                          (states) {
                        if (states.contains(MaterialState.focused) &&
                            !states.contains(MaterialState.pressed)) {
                          //获取焦点时的颜色
                          return Colors.blue;
                        } else if (states.contains(MaterialState.pressed)) {
                          //按下时的颜色
                          return Colors.deepPurple;
                        }
                        //默认状态使用灰色
                        return Colors.white;
                      },
                    ),
                  ),
                  child: const Text("save"),
                  onPressed: () {
                    //校验账号不为空且长度大于7(自定义校验条件)
                    if (_unameController.text.isNotEmpty &&
                        _unameController.text.trim().length > 5) {
                      _checkLogContent();
                    } else {
                      Toast.toast(context, msg: 'Please enter enough content');
                    }
                  }
              )),
              const SizedBox(width: 20)
            ],
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}


// class JenLogRecord extends StatelessWidget {
//   const JenLogRecord({Key? key}) : super(key: key);
//
//   static final TextEditingController _unameController  = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Add Log", style: TextStyle(color:  Colors.white)),
//         centerTitle: true,
//         backgroundColor: const Color(0xFF8CD8C1),
//         leading:  Builder(builder: (context) {
//           return IconButton(
//             icon: const Icon(Icons.arrow_back, color: Colors.white), //自定义图标
//             onPressed: () {
//               // 打开抽屉菜单
//               Get.back();
//             },
//           );
//         }),
//       ),
//       body: Column(
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: Container(
//                   height: MediaQuery.of(context).padding.top + 60,
//                   alignment: Alignment.centerLeft,
//                   padding: const EdgeInsets.all(8),
//                   color: const Color(0xFF8CD8C1),
//                   child: const Text('Log Content',style: TextStyle(color: Colors.white,fontSize:36,fontWeight: FontWeight.bold)),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),
//           const Expanded(
//             child: TextField(
//               keyboardType: TextInputType.multiline,
//               maxLines: 4,
//               minLines: 1,
//               controller: _unameController,
//               decoration: InputDecoration(
//                 hintText: 'Please enter the diary content you added',
//                 filled: true,
//                 fillColor: Colors.white,
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                 isDense: true,
//                 border: OutlineInputBorder(
//                   // gapPadding: 0,
//                   // borderRadius: const BorderRadius.all(Radius.circular(4)),
//                   borderSide: BorderSide(
//                     width: 0,
//                     style: BorderStyle.none,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           //添加个按钮
//           Row(
//             children: [
//               const SizedBox(width: 20),
//               Expanded(child: ElevatedButton(
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateColor.resolveWith((states) {
//                     return const Color(0xFF8CD8C1);
//                   }),
//                   textStyle: MaterialStateProperty.all(const TextStyle(color: Colors.white)),
//                     foregroundColor: MaterialStateProperty.resolveWith(
//                           (states) {
//                         if (states.contains(MaterialState.focused) &&
//                             !states.contains(MaterialState.pressed)) {
//                           //获取焦点时的颜色
//                           return Colors.blue;
//                         } else if (states.contains(MaterialState.pressed)) {
//                           //按下时的颜色
//                           return Colors.deepPurple;
//                         }
//                         //默认状态使用灰色
//                         return Colors.white;
//                       },
//                     ),
//                 ),
//                 child: const Text("save"),
//                 onPressed: () {
//
//                   Get.back();
//                 }
//               )),
//               const SizedBox(width: 20)
//             ],
//           ),
//           const SizedBox(height: 20)
//         ],
//       ),
//     );
//   }
// }

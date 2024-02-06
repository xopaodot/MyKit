import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../gen_a/custom_toast.dart';
import '../expend/show_loding.dart';

class MineFaceBack extends StatefulWidget {
  const MineFaceBack({super.key});

  @override
  State<MineFaceBack> createState() => _MineFaceBackState();
}

class _MineFaceBackState extends State<MineFaceBack> {

  static final TextEditingController _unameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FeedBack'),
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
                  child: const Text('Input Feedback Content',style: TextStyle(color: Colors.white,fontSize:20,fontWeight: FontWeight.bold)),
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
                  child: const Text("Submit"),
                  onPressed: () {
                    //校验账号不为空且长度大于7(自定义校验条件)
                    if (_unameController.text.isNotEmpty &&
                        _unameController.text.trim().length > 1) {
                      CommonUtil.showLoadingDialog(context);
                      Future.delayed(const Duration(milliseconds: 1000), () {
                        Navigator.pop(context);//

                        Navigator.pop(context);
                        Get.defaultDialog(onCancel: () => print(''),radius: 5, middleText: "submit success!", title: 'Tip');
                      });
                    } else {
                      Toast.toast(context, msg: 'Please enter content');
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

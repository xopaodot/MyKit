import 'package:flutter/material.dart';
import '../../gen_a/custom_toast.dart';
import 'show_loding.dart';

class JenAddBarnds extends StatefulWidget {
  const JenAddBarnds({super.key});

  @override
  State<JenAddBarnds> createState() => _JenAddBarndsState();
}

class _JenAddBarndsState extends State<JenAddBarnds> {

  // final TextEditingController control = TextEditingController();
  var oneController = TextEditingController();
  var oneController2 = TextEditingController();
  var oneController3 = TextEditingController();

  void requestAdd() async {

    if (oneController.text.isEmpty) {
      //
      Toast.toast(context, msg: "please input ！");
      return;
    }
    if (oneController2.text.isEmpty) {
      //
      Toast.toast(context, msg: "please input ！");
      return;
    }
    if (oneController3.text.isEmpty) {
      //
      Toast.toast(context, msg: "please input ！");
      return;
    }

    CommonUtil.showLoadingDialog(context);
    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.pop(context);//


      Navigator.pop(context);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Brand"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.all(18.0),
            child: Text("Brand/price/tar content", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.only(left: 18, right: 18),
            decoration: BoxDecoration(
                color: Colors.black12,
                border: Border.all(color: Colors.white54, width: 0.5),
                borderRadius: BorderRadius.circular((20.0))),
            child: TextField(
                controller: oneController,
                decoration: const InputDecoration(
                    hintText: "Fill in the frequently used brands",
                    contentPadding: EdgeInsets.only(top: 4, left: 10, bottom: 4,right: 10),
                    border: InputBorder.none)),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.only(left: 18, right: 18),
            decoration: BoxDecoration(
                color: Colors.black12,
                border: Border.all(color: Colors.white54, width: 0.5),
                borderRadius: BorderRadius.circular((20.0))),
            child: TextField(
              controller: oneController2,
                decoration: const InputDecoration(
                    hintText: "Fill in the price of a single package",
                    contentPadding: EdgeInsets.only(top: 4, left: 10, bottom: 4,right: 10),
                    border: InputBorder.none)),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.only(left: 18, right: 18),
            decoration: BoxDecoration(
                color: Colors.black12,
                border: Border.all(color: Colors.white54, width: 0.5),
                borderRadius: BorderRadius.circular((20.0))),
            child: TextField(
              controller: oneController3,
                decoration: const InputDecoration(
                    hintText: "Fill in the amount of tar on the box",
                    contentPadding: EdgeInsets.only(top: 4, left: 10, bottom: 4,right: 10),
                    border: InputBorder.none)),
          ),
          const SizedBox(height: 60),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 20),
              Expanded(
                  child: GestureDetector(
                    onTap: requestAdd,
                    child: Container(
                      // color: Colors.red,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular((10.0))
                      ),
                      child: const Text('Submit', textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
                    ),
                  )
              ),
              const SizedBox(width: 20),
            ],
          ),
        ],
      ),
    );
  }
}


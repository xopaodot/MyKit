
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project/bottom_navigate/image_contioner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import '../../jen_login/custom_webview.dart';

class SystemSetPage extends StatelessWidget {
  const SystemSetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    onTapPickFromGallery() async{
      var info = const AssetPickerConfig(maxAssets: 1);
      final List<AssetEntity>? entitys = await AssetPicker.pickAssets(context, pickerConfig: info);
      if(entitys == null) return;

      List<String> chooseImagesPath = [];
      //遍历
      for(var entity in entitys){
        File? imgFile = await entity.file;
        if(imgFile != null) chooseImagesPath.add(imgFile.path);
      }

    }

    deleteAccount() async {
      await Future.delayed(const Duration(seconds: 1));
      Get.toNamed("/login", preventDuplicates:false);
      var user = await SharedPreferences.getInstance(); //初始化
      user.setString("base", "99");
      user.setString("uid", "");
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Set"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        children: [
          GestureDetector(
            child: myCell('personal information', "my_head"),
            onTap: () async {
              onTapPickFromGallery();
              // final List<AssetEntity>? assets =  await AssetPicker.pickAssets(context,maxAssets: 1);
            },
          ),

          // const Divider(color: Color(0xFFF8EEEA)),
          // myCell('account security'),
          // // const Divider(color: Color(0xFFF8EEEA)),
          GestureDetector(
            child: myCell('Privacy Agreement'),
            onTap: () {
              Get.to(const JenMyWebViewPage(toUrl: 'https://www.showdoc.com.cn/p/8ce252c2f8d8d3ed4aa26af3fa10da71', toName: 'Privacy Agreement',));
            },
          ) ,
          const Divider(color: Color(0xFFF8EEEA)),
          GestureDetector(
            child: myCell('User Agreement'),
            onTap: () {
              Get.to(const JenMyWebViewPage(toUrl: 'https://www.showdoc.com.cn/p/6c7cd035704d87075e5e0412fd8f8898', toName: 'User Agreement',));
            },
          ) ,
          const Divider(color: Color(0xFFF8EEEA)),
          GestureDetector(
            child: myCell('Account deletion'),
            onTap: (){
              Get.defaultDialog(
                  onCancel: () => print(''),
                  onConfirm: deleteAccount,
                  radius: 5,
                  middleText: "Confirm to delete the current account!",
                  title: 'Tip'
              );
            },
          ),
           const Divider(color: Color(0xFFF8EEEA)),
        ],
      ),
    );

  }

  Widget myCell(String text, [String? headName]){
    List<Widget> list = [
      Expanded(child: Text(text, style: const TextStyle(color: Color(0xFF333333)))),
      Visibility(
          visible: headName?.isNotEmpty ?? false,
          child: Container(
              width: 50,
              height: 50,
              clipBehavior: Clip.hardEdge,//超出部分，可裁剪
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Image.asset('images/my_head.jpeg', fit: BoxFit.fill)
              // ImageBox(imageName: 'my_head.jpeg',h: 50,w: 50)
          )
      ),
      ImageBox(imageName: 'my_right_grey.png')
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 60,
      color: Colors.white,
      child: Row(
        children: list,
      ),
    );
  }

}

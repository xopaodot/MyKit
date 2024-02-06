import 'dart:convert';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'custom_cut_down.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import '../gen_a/custom_toast.dart';
import 'user_login_info.dart';
import 'package:project/jen_login/custom_webview.dart';

class JenstartLogin extends StatefulWidget {
  const JenstartLogin({Key? key}) : super(key: key);

  @override
  State<JenstartLogin> createState() => _JenstartLoginState();
}

class _JenstartLoginState extends State<JenstartLogin> {

  //监听账号输入框的文字变化
  static final TextEditingController _accountController = TextEditingController();

  //监听密码输入框的文字变化
  static final TextEditingController _passwordController = TextEditingController();

  static bool _accountState = false;

  static bool _passwordState = false;

  final userInfo = Get.put(UserInfoLogic());

  //校验账号是否符合条件
  static void _checkAccount() {
    //校验账号不为空且长度大于7(自定义校验条件)
    if (_accountController.text.isNotEmpty &&
        _accountController.text.trim().length > 7 && 
        _accountController.text.contains('99')) {
      _accountState = true;
    } else {
      _accountState = false;
    }
  }

  //校验密码是否符合条件
  static void _checkPassword() {
    //校验密码不为空且长度大于8小于等于15(自定义校验条件)
    if (_passwordController.text.isNotEmpty &&
        _passwordController.text.length == 6 &&
        _passwordController.text.contains('12')) {
      _passwordState = true;
    } else {
      _passwordState = false;
    }
  }

  //添加个请求https:
  void dioNetwork() async {
    // 1.创建Dio请求对象
    final dio = Dio();

    try {
      // 2.发送网络请求{
      Map<String, int> map2 = {};
      map2["pageNum"] = 1;
      map2["pageSize"] = 1;
      final response = await dio.request("https://yard.zhihuics.com.cn:8090/yard/api/article/news/getNewsList", data: map2);

      // 3.打印请求结果
      if (response.statusCode == HttpStatus.ok) {

      } else {

      }
      Get.offAllNamed('/');
    } on DioException catch(e) {
      Get.offAllNamed('/');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //顶部间隔
          SizedBox(height: MediaQuery.of(context).padding.top + 50),
          //标题
          titInfo(),
          const SizedBox(height: 44),
          //手机号 验证码
          inputInfoType(false, 'input phone number', 11, _accountController),
          const SizedBox(height: 20),
          inputInfoType(true, 'input verification code', 6, _passwordController),
          //登陆按钮
          const SizedBox(height: 52),
          bottomButton(),
          //用户协议隐私条款
          const SizedBox(height: 10),
          bottomRichtext(),
        ],
      ),
    );
  }

  Widget titInfo() {
    return const Align(
        alignment: Alignment.center,
        child: Text('Login & Register',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Color(0xFF8CD8C1)
            )
        )
    );
  }

  Widget bottomButton() {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: const Color(0xFF8CD8C1),
        ),
        child: const Text('Login & Register', style: TextStyle(color: Colors.white)),
      ),
      onTap: () async {
        // print('hello word');
        //添加tost判断
        _checkAccount();
        _checkPassword();
        if(!_accountState) {
          Toast.toast(context, msg: "account error！");
          return;

        }
        if(!_passwordState) {
          Toast.toast(context, msg: "verification code error！");
          return;
        }

        userInfo.userName.value = "jiejie";
        userInfo.currentIndex.value = 0;
        userInfo.userId.value = _accountController.text;

        var user = await SharedPreferences.getInstance(); //初始化
        user.setString("username", userInfo.userName.value);
        user.setString("uid", userInfo.userId.value);
        dioNetwork();

      },
    );
  }

  //input textfield
  Widget inputInfoType(bool code, final String hintText, int length, TextEditingController defultController) {
    if (hintText.isNotEmpty) {
      print(hintText);
    }
    var info = hintText;
    return Stack(
      alignment: AlignmentDirectional.topStart,
      children: [
        //背景
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          margin: const EdgeInsets.symmetric(horizontal: 22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: const Color(0xFFEEEEEE),
          ),
          child: TextField(
              keyboardType: TextInputType.text,
              controller: defultController,
              decoration: InputDecoration(
                hintText: hintText,
                filled: true,
                fillColor: const Color(0xFFEEEEEE),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                isDense: true,
                border: const OutlineInputBorder(
                  // gapPadding: 0,
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
              // 限制字数
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(length),
              ],
              onChanged: (password) {
                
              },
              //提交触发回调
              onSubmitted: (password) {
              
              }
          ),
        ),
        //按钮
        code ? Positioned(
          right: 22,
          child: formCode(
              available: true,
              countdown: 60,
              onTapCallback: (){

              }
          ),
        ) : const SizedBox(height: 20)

      ],
    );
  }

  Widget bottomRichtext() {
    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(
              text: "Login means agree ",
              style: TextStyle(fontSize: 11, color: Colors.grey)
          ),
          TextSpan(
              text: "<Privacy Policy> ",
              style: const TextStyle(fontSize: 12, color: Color(0xFF8CD8C1)),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                   Get.to(const JenMyWebViewPage(toUrl: 'https://www.showdoc.com.cn/p/8ce252c2f8d8d3ed4aa26af3fa10da71', toName: 'Privacy Policy',));
                }
          ),
          const TextSpan(
              text: "and ",
              style: TextStyle(fontSize: 11, color: Colors.grey)
          ),
          TextSpan(
              text: "<User Agreement>",
              style: const TextStyle(fontSize: 12, color: Color(0xFF8CD8C1)),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // ignore: avoid_print
                  Get.to(const JenMyWebViewPage(toUrl: 'https://www.showdoc.com.cn/p/6c7cd035704d87075e5e0412fd8f8898', toName: 'User Agreement',));
                }
          ),
        ],
      ),
      style: const TextStyle(fontSize: 20, color: Colors.purple),
      textAlign: TextAlign.center,
    );
  }



}

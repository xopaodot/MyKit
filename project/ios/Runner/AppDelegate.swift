import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    let messenger : FlutterBinaryMessenger = window?.rootViewController as! FlutterBinaryMessenger
         
      getFlutterMessage(messenger: messenger)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
   func getFlutterMessage(messenger: FlutterBinaryMessenger) {
       let channel = FlutterMethodChannel(name: "plugin_apple'", binaryMessenger: messenger)
       channel.setMethodCallHandler { (call:FlutterMethodCall, result:@escaping FlutterResult) in
       
           if (call.method == "getFlutterMessage") {
               result(["result":"success","code":200]);
           }
           
           if (call.method == "apple_two") {
               result(["result":"success","code":404]);
           }
    
       }
   }

}

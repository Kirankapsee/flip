import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
         let pageCurlChannel = FlutterMethodChannel(name: "com.example/pdfpagecurl", binaryMessenger: controller.binaryMessenger)
         pageCurlChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
           if call.method == "showPageCurl" {
             let pdfPageCurlViewController = PDFPageCurlViewController()
             controller.present(pdfPageCurlViewController, animated: true, completion: nil)
             result(nil)
           } else {
             result(FlutterMethodNotImplemented)
           }
         }
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    private func showNativePageCurl(controller: FlutterViewController) {
       // Implement page curl animation in Swift
       let pdfPageCurlVC = PDFPageCurlViewController()
       controller.present(pdfPageCurlVC, animated: true, completion: nil)
     }
}

import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    var methodChannel: FlutterMethodChannel?
    
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        // FlutterViewController
        print(window.rootViewController!)
        
        // 要注册的channel name，与flutter注册的通道名称保持一致
        let channelName = "com.tank"
        let flutterViewController = window.rootViewController! as! FlutterViewController
        
        // MARK: 获取 FlutterMethodChannel，监听 Flutter 消息
        methodChannel = FlutterMethodChannel.init(name: channelName, binaryMessenger: flutterViewController as! FlutterBinaryMessenger)
        if methodChannel != nil {
            
            let picker = UIImagePickerController.init()
            picker.delegate = self
            
            methodChannel!.setMethodCallHandler { [weak self] (call, result) in
                
                guard self != nil else { return }
                
                // call.method 获取 flutter 给回到的方法名，要匹配到 channelName 对应的多个 发送方法名，一般需要判断区分
                // call.arguments 获取到 flutter 给到的参数，（比如跳转到另一个页面所需要参数）
                // result 是给flutter的回调， 该回调只能使用一次
                
                
                // 输出日志：flutter 给到我 method:changePicture arguments:nil
                print("flutter 给到我 method:\(call.method) arguments:\(call.arguments)")
                
                if (call.method == "changePicture") { // 更换头像
                    flutterViewController.present(picker, animated: false, completion: nil)
                }
                
            }
        }
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        print(info)
        
        picker.dismiss(animated: true) { [weak self] in
            
            if #available(iOS 11.0, *) {
                
                
                if let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? NSURL {
                    
                    let path = imageURL.absoluteString
                    
                    print("发送 imagePath 消息：\(path ?? "")");
                    
                    // 发送 imagePath 消息，由flutter接收
                    self?.methodChannel?.invokeMethod("imagePath", arguments: path)
                }
                
                
            } else {
                // Fallback on earlier versions
            }
            
        }
    }
    
}

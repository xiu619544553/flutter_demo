//
//  ViewController.swift
//  NativeDemo
//
//  Created by hello on 2021/10/13.
//

// MARK: 三种Channel
// FlutterMethodChannel：调用方法，一次通讯
// FlutterBasicMessageChannel：传递字符串&半结构化的信息。持续通讯
// FlutterEventChannel：用于传输数据流（dart中的stream）。持续通讯


import UIKit
import Flutter

class ViewController: UIViewController {
    
    var clickCount: Int = 0
    
    /// 初始化Flutter引擎，需要提前创建、run
    lazy var engine: FlutterEngine = {
        let e = FlutterEngine.init(name: "tank")
        e.run() // 此处可以添加一个逻辑：判断 run是否成功
        return e
    }()
    
    /// 声明flutter控制器
    var flutterVc: FlutterViewController?
    
    /// FlutterBasicMessageChannel 案例
    var messageChannel: FlutterBasicMessageChannel?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "原生项目，嵌套Flutter页面"
        
        let testBtn = UIButton.init(frame: CGRect.init(x: 20, y: 100, width: 300, height: 44))
        testBtn.setTitle("页面 one", for: .normal)
        testBtn.setTitleColor(UIColor.white, for: .normal)
        testBtn.backgroundColor = .black
        testBtn.addTarget(self, action: #selector(test1BtnAction(sender:)), for: .touchUpInside)
        view.addSubview(testBtn)
        
        let testBtn2 = UIButton.init(frame: CGRect.init(x: 20, y: 160, width: 300, height: 44))
        testBtn2.setTitle("页面 two", for: .normal)
        testBtn2.setTitleColor(UIColor.white, for: .normal)
        testBtn2.backgroundColor = .black
        testBtn2.addTarget(self, action: #selector(test2BtnAction(sender:)), for: .touchUpInside)
        view.addSubview(testBtn2)
        
        let testBtn3 = UIButton.init(frame: CGRect.init(x: 20, y: 220, width: 300, height: 44))
        testBtn3.setTitle("FlutterBasicMessageChannel", for: .normal)
        testBtn3.setTitleColor(UIColor.white, for: .normal)
        testBtn3.backgroundColor = .black
        testBtn3.addTarget(self, action: #selector(messageChannelBtn(sender:)), for: .touchUpInside)
        view.addSubview(testBtn3)
        
        
        
        // 创建flutter控制器，提前保证引擎 run起来。
        flutterVc = FlutterViewController.init(engine: engine, nibName: nil, bundle: nil)
        flutterVc?.modalPresentationStyle = .fullScreen
        
        
        // 接收Flutter的数据 -- FlutterBasicMessageChannel
        messageChannel = FlutterBasicMessageChannel.init(name: "message_channel", binaryMessenger: self.flutterVc as! FlutterBinaryMessenger)
        messageChannel!.setMessageHandler { (receiver, replay) in
            print("收到Flutter中的消息：\(String(describing: receiver))")
        }
    }
    
    
    @objc func test1BtnAction(sender: UIButton){
        // 每次都创建 FlutterViewController，会非常占用内存，不建议这么做。
        // initialRoute 对应 Flutter中的 window.defaultRouteName
        let temp = FlutterViewController.init(project: nil, initialRoute: "one", nibName: nil, bundle: nil)
        present(temp, animated: true, completion: nil)
    }
    
    
    @objc func test2BtnAction(sender: UIButton){
        
        if flutterVc != nil {
            present(flutterVc!, animated: true, completion: nil)
        }
        
        let name = "two_page"
        let channel = FlutterMethodChannel.init(name: name, binaryMessenger: flutterVc as! FlutterBinaryMessenger)
        channel.setMethodCallHandler { [weak self] (call, result) in
            
            print(call.method)
            
            if call.method == "exit" {
                self?.flutterVc?.dismiss(animated: true, completion: nil)
            }
        }
        channel.invokeMethod(name, arguments: nil)
    }
    
    
    
    // MARK: FlutterBasicMessageChannel 案例
    @objc func messageChannelBtn(sender: UIButton) {
        if flutterVc != nil {
            present(flutterVc!, animated: true, completion: nil)
        }
        
        // 监听
        let name = "message_channel"
        let channel = FlutterMethodChannel.init(name: name, binaryMessenger: flutterVc as! FlutterBinaryMessenger)
        channel.setMethodCallHandler { [weak self] (call, result) in
            
            print(call.method)
            
            if call.method == "exit" {
                self?.flutterVc?.dismiss(animated: true, completion: nil)
            }
        }
        channel.invokeMethod(name, arguments: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        clickCount += 1
        // 发送消息
        messageChannel?.sendMessage(clickCount)
    }
}


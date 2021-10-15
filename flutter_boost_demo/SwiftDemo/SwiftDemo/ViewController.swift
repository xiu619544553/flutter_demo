//
//  ViewController.swift
//  SwiftDemo
//
//  Created by hello on 2021/10/14.
//

import UIKit
import Flutter
import flutter_boost

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "原生APP嵌入Flutter页面"
        
        
        let test1Btn = UIButton.init(frame: CGRect.init(x: 20, y: 100, width: view.bounds.width - 40, height: 44))
        test1Btn.setTitle("进入Flutter页面，路由：mainPage", for: .normal)
        test1Btn.setTitleColor(UIColor.white, for: .normal)
        test1Btn.backgroundColor = .orange
        test1Btn.addTarget(self, action: #selector(test1BtnAction), for: .touchUpInside)
        view.addSubview(test1Btn)
        
        
        let testBtn2 = UIButton.init(frame: CGRect.init(x: test1Btn.frame.minX, y: test1Btn.frame.maxY + 15, width: test1Btn.frame.width, height: test1Btn.frame.height))
        testBtn2.setTitle("进入Flutter页面，路由：simplePage", for: .normal)
        testBtn2.setTitleColor(UIColor.white, for: .normal)
        testBtn2.backgroundColor = .blue
        testBtn2.addTarget(self, action: #selector(test2BtnAction), for: .touchUpInside)
        view.addSubview(testBtn2)
        
        
        // 添加事件监听者，监听从 flutter回传的数据
        FlutterBoost.instance()?.addEventListener({ [weak self] (name, params) in
            
            print("params:  \(String(describing: params))")
            self?.title = params?["returnValue"] as? String
            
        }, forName: "FromMainPage")
        
        
        // 模拟从原生页面传值给flutter（持续性）
        if #available(iOS 10.0, *) {
            Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { (timer) in
                FlutterBoost.instance()?.sendEventToFlutter(with: "MainPageKey", arguments: ["value" : "从原生页面传值给flutter"])
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    @objc func test1BtnAction() {
        TKFlutterRouteManager.manager.presentMainPage()
    }
    
    @objc func test2BtnAction() {
        TKFlutterRouteManager.manager.pushSimplePage()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("...touch...")
        
        
        
    }
    
}



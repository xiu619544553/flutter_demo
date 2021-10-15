//
//  TKFlutterRouteManager.swift
//  SwiftDemo
//
//  Created by hello on 2021/10/14.
//

import UIKit
import Foundation

import Flutter
import flutter_boost

class TKFlutterRouteManager: NSObject {
    
    /// flutter boost 代理对象
    public let boostDelegate: TKBoostDelegate = TKBoostDelegate()
    
    /// 单例对象
    private override init() {}
    static let manager = TKFlutterRouteManager()
    
    /// 初始化flutter boost
    public func setupFlutterBoost(application: UIApplication!) {
        
        // 初始化 FlutterBoost
        FlutterBoost.instance()?.setup(application, delegate: boostDelegate, callback: { (engie) in
            
        })
    }
    
    // MARK: 进入 mainPage
    public func presentMainPage() {
        let nav = UIApplication.shared.keyWindow?.rootViewController;
        boostDelegate.navigationController = (nav as! UINavigationController);
        
        
        let options = FlutterBoostRouteOptions.init()
        // 配置路由
        options.pageName = "/mainPage"
        // 参数
        options.arguments = [
            "isAnimated" : true,
            "data" : "从iOS原生页面传值给Flutter页面"
        ]
        options.onPageFinished = { (params) in
            print("onPageFinished：\(String(describing: params))")
        }
        options.completion = { (result) in
            print("completion：\(result)")
        }
        
        //（推荐使用）利用启动参数配置开启新页面
        FlutterBoost.instance()?.open(options)
    }
    
    // MARK: 进入 simplePage
    public func pushSimplePage() {
        let nav = UIApplication.shared.keyWindow?.rootViewController;
        boostDelegate.navigationController = (nav as! UINavigationController);
        
        
        let options = FlutterBoostRouteOptions.init()
        options.pageName = "/simplePage"
        options.arguments = [
            "isAnimated" : true,
            "data" : "我要进入 SimplePage",
            "isPresent" : false
        ]
        options.onPageFinished = { (params) in
            print("onPageFinished：\(String(describing: params))")
        }
        options.completion = { (result) in
            print("completion：\(result)")
        }
        
        FlutterBoost.instance()?.open(options)
    }
}

//
//  AppDelegate.swift
//  SwiftDemo
//
//  Created by hello on 2021/10/14.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController.init(rootViewController: ViewController.init())
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        
        // 初始化 FlutterBoost
        TKFlutterRouteManager.manager.setupFlutterBoost(application: application)
        
        return true
    }

}


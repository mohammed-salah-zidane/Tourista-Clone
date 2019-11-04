//
//  AppDelegate.swift
//  Tourista
//
//  Created by prog_zidane on 11/3/19.
//  Copyright © 2019 prog_zidane. All rights reserved.
//

import UIKit
import Nuke
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        configImagesCaching()
        return true
    }
    func configImagesCaching(){
        // 1
        DataLoader.sharedUrlCache.diskCapacity = 0
        
        let pipeline = ImagePipeline {
            // 2
            let dataCache = try! DataCache(name: "com.zidane.ReadOn")
            // 3
            dataCache.sizeLimit = 200 * 1024 * 1024
            // 4
            $0.dataCache = dataCache
        }
        // 5
        ImagePipeline.shared = pipeline
    }


}


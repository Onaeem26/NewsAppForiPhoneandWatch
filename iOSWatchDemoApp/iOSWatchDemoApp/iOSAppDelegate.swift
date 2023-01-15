//
//  iOSAppDelegate.swift
//  iOSWatchDemoApp
//
//  Created by Muhammad Osama Naeem on 1/14/23.
//

import Foundation
import UIKit
import WatchConnectivity

class iOSAppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
      setupWatchConnectivity()
      return true
  }
    
    func setupWatchConnectivity() {
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
      let sceneConfig = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
      sceneConfig.delegateClass = iOSSceneDelegate.self // 👈🏻
      return sceneConfig
    }
}

extension iOSAppDelegate : WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("WC Session activation failed")
            print(error.localizedDescription)
            return
        }
        print("WC Session activated successfully")
        print(activationState.rawValue)
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        //
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        WCSession.default.activate()
    }
    
}

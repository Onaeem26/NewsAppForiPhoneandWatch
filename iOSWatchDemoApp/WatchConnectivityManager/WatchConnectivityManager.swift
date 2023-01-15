//
//  WatchConnectivityManager.swift
//  iOSWatchDemoApp
//
//  Created by Muhammad Osama Naeem on 1/14/23.
//

import Foundation
import WatchConnectivity

struct NotificationMessage: Identifiable {
    let id = UUID()
    let favoriteArticles: [String]
}

class WatchConnectivityManager : NSObject, WCSessionDelegate, ObservableObject {
    static let shared = WatchConnectivityManager()
    @Published var notificationMessage: NotificationMessage? = nil
    
    private override init() {
        super.init()
        
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
    
    private let messagekey = "messageKey"
    
    func send(_ message: [String]) {
        guard WCSession.default.activationState == .activated else {
            return
        }
        #if os(iOS)
        guard WCSession.default.isWatchAppInstalled else { return }
        #else
        guard WCSession.default.isCompanionAppInstalled else { return }
        #endif
        
        do {
            try  WCSession.default.updateApplicationContext([messagekey : message])
        }
        catch {
            print("Cannot send message")
            print(error)
        }
       
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
//    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
//        if let recievedFavArticles = message[messagekey] as? [String] {
//            DispatchQueue.main.async { [weak self] in
//                self?.notificationMessage = NotificationMessage(favoriteArticles: recievedFavArticles)
//            }
//        }
//    }
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        if let recievedFavArticles = applicationContext[messagekey] as? [String] {
            DispatchQueue.main.async { [weak self] in
                self?.notificationMessage = NotificationMessage(favoriteArticles: recievedFavArticles)
            }
        }
    }
    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) {}
    func sessionDidDeactivate(_ session: WCSession) {
        session.activate()
    }
    #endif
}

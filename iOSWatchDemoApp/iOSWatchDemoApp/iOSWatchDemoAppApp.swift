//
//  iOSWatchDemoAppApp.swift
//  iOSWatchDemoApp
//
//  Created by Muhammad Osama Naeem on 1/13/23.
//

import SwiftUI

@main
struct iOSWatchDemoAppApp: App {
    @UIApplicationDelegateAdaptor var delegate: iOSAppDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

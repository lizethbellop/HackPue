//
//  HackPueApp.swift
//  HackPue
//
//  Created by Liz Bello on 17/08/25.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct HackPueApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

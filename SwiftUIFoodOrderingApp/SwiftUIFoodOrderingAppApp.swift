//
//  SwiftUIFoodOrderingAppApp.swift
//  SwiftUIFoodOrderingApp
//
//  Created by ipeerless on 27/07/2023.
//

import SwiftUI
import Firebase
@main
struct SwiftUIFoodOrderingAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        
        FirebaseApp.configure()
        return true
        
    }
}

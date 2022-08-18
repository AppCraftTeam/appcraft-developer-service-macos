//
//  ACDeveloperServiceApp.swift
//  ACDeveloperService
//
//  Created by Дмитрий Поляков on 17.08.2022.
//

import SwiftUI

@main
struct ACDeveloperServiceApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

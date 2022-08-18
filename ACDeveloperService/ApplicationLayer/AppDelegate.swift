//
//  AppDelegate.swift
//  ACDeveloperService
//
//  Created by Дмитрий Поляков on 18.08.2022.
//

import Foundation
import AppKit
import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        NSWindow.allowsAutomaticWindowTabbing = false
        NSApplication.shared.windows.forEach({ $0.tabbingMode = .disallowed })
    }
    
    func applicationWillUpdate(_ notification: Notification) {
        if let menu = NSApplication.shared.mainMenu {
            menu.items.removeAll(where: { $0.title == "Edit" })
            menu.items.removeAll(where: { $0.title == "File" })
            menu.items.removeAll(where: { $0.title == "Window" })
            menu.items.removeAll(where: { $0.title == "View" })
            menu.items.removeAll(where: { $0.title == "Help" })
        }
    }
    
}

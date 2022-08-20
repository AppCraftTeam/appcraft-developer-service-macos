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
        NSApplication.shared.removeDefaultMenuItems()
    }
    
}

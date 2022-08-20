//
//  NSApplication+Extensions.swift
//  ACDeveloperService
//
//  Created by Дмитрий Поляков on 19.08.2022.
//

import Foundation
import AppKit

extension NSApplication {
    
    func removeDefaultMenuItems() {
        let items = ["Edit", "File", "Window", "View", "Help"]
        self.mainMenu?.items.removeAll(where: { items.contains($0.title) })
    }
    
}

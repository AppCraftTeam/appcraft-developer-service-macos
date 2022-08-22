//
//  View+Extensions.swift
//  ACDeveloperService
//
//  Created by Дмитрий Поляков on 19.08.2022.
//

import Foundation
import SwiftUI

extension View {
    
    func toggleSidebar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
    
}

//
//  Binding+Extensions.swift
//  ACDeveloperService
//
//  Created by Дмитрий Поляков on 22.08.2022.
//

import Foundation
import SwiftUI

extension Binding {
    
    func mappedToBool<Wrapped>() -> Binding<Bool> where Value == Wrapped? {
        return Binding<Bool>(mappedTo: self)
    }
    
}

extension Binding where Value == Bool {
    
    init<Wrapped>(mappedTo bindingToOptional: Binding<Wrapped?>) {
        self.init(
            get: { bindingToOptional.wrappedValue != nil },
            set: { newValue in
                if !newValue {
                    bindingToOptional.wrappedValue = nil
                }
            }
        )
    }
    
}

//
//  ErrorPresentedObject.swift
//  ACDeveloperService
//
//  Created by Дмитрий Поляков on 22.08.2022.
//

import Foundation
import Combine

class ErrorPresentedObject: ObservableObject {
    @Published var error: Error? = nil
}

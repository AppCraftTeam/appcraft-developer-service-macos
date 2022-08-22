//
//  AppError.swift
//  ACDeveloperService
//
//  Created by Дмитрий Поляков on 22.08.2022.
//

import Foundation

struct AppError {
    let identifer: String
    let message: String
}

// MARK: - LocalizedError
extension AppError: LocalizedError {
    
    var errorDescription: String? {
        self.message
    }
    
    var failureReason: String? {
        self.message
    }
    
}

// MARK: - Equatable
extension AppError: Equatable {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.identifer == rhs.identifer
    }
    
}
 
// MARK: - Store
extension AppError {
    static let someError: Self = .init(identifer: "someError", message: "Some Error")
}

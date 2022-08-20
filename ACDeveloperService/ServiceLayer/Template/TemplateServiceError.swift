//
//  TemplateServiceError.swift
//  ACDeveloperService
//
//  Created by Дмитрий Поляков on 18.08.2022.
//

import Foundation

struct TemplateServiceError {
    let identifer: String
    let message: String
}

// MARK: - LocalizedError
extension TemplateServiceError: LocalizedError {
    
    var errorDescription: String? {
        self.message
    }
    
    var failureReason: String? {
        self.message
    }
    
}

// MARK: - Equatable
extension TemplateServiceError: Equatable {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.identifer == rhs.identifer
    }
    
}
 
// MARK: - Store
extension TemplateServiceError {
    static let projectAlreadyExists: Self = .init(identifer: "projectAlreadyExists", message: "projectAlreadyExists")
    static let templateNoFound: Self = .init(identifer: "templateNoFound", message: "templateNoFound")
    static let documentsDirectoryNoFound: Self = .init(identifer: "documentsDirectoryNoFound", message: "documentsDirectoryNoFound")
}

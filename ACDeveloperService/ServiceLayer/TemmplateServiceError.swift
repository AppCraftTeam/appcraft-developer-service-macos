//
//  TemmplateServiceError.swift
//  ACDeveloperService
//
//  Created by Дмитрий Поляков on 18.08.2022.
//

import Foundation

struct TemmplateServiceError {
    let identifer: String
    let message: String
}

// MARK: - LocalizedError
extension TemmplateServiceError: LocalizedError {
    
    var errorDescription: String? {
        self.message
    }
    
    var failureReason: String? {
        self.message
    }
    
}

// MARK: - Equatable
extension TemmplateServiceError: Equatable {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.identifer == rhs.identifer
    }
    
}
 
// MARK: - Store
extension TemmplateServiceError {
    static let projectAlreadyExists: TemmplateServiceError = .init(identifer: "projectAlreadyExists", message: "projectAlreadyExists")
    static let templateNoFound: TemmplateServiceError = .init(identifer: "templateNoFound", message: "templateNoFound")
    static let documentsDirectoryNoFound: TemmplateServiceError = .init(identifer: "documentsDirectoryNoFound", message: "documentsDirectoryNoFound")
}

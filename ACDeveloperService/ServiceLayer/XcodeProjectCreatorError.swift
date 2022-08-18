//
//  XcodeProjectCreatorError.swift
//  ACDeveloperService
//
//  Created by Дмитрий Поляков on 18.08.2022.
//

import Foundation

struct XcodeProjectCreatorError {
    let identifer: String
    let message: String
}

// MARK: - LocalizedError
extension XcodeProjectCreatorError: LocalizedError {
    
    var errorDescription: String? {
        self.message
    }
    
    var failureReason: String? {
        self.message
    }
    
}

// MARK: - Equatable
extension XcodeProjectCreatorError: Equatable {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.identifer == rhs.identifer
    }
    
}
 
// MARK: - Store
extension XcodeProjectCreatorError {
    static let projectAlreadyExists: XcodeProjectCreatorError = .init(identifer: "projectAlreadyExists", message: "projectAlreadyExists")
    static let templateNoFound: XcodeProjectCreatorError = .init(identifer: "templateNoFound", message: "templateNoFound")
    static let documentsDirectoryNoFound: XcodeProjectCreatorError = .init(identifer: "documentsDirectoryNoFound", message: "documentsDirectoryNoFound")
}

//
//  TemplateModel.swift
//  ACDeveloperService
//
//  Created by Дмитрий Поляков on 19.08.2022.
//

import Foundation

struct TemplateModel {
    
    // MARK: - Init
    init(id: String, name: String, fileName: String, fileExtension: String) {
        self.id = id
        self.name = name
        self.fileName = fileName
        self.fileExtension = fileExtension
    }
    
    init(url: URL) {
        let lastPathComponent = url.lastPathComponent as NSString
        let name = String(lastPathComponent.deletingPathExtension)
        let fileName = url.lastPathComponent
        let fileExtension = String(lastPathComponent.pathExtension)
        
        self.init(
            id: name,
            name: name,
            fileName: fileName,
            fileExtension: fileExtension
        )
    }
    
    // MARK: - Props
    let id: String
    let name: String
    let fileName: String
    let fileExtension: String
}

// MARK: - Identifiable
extension TemplateModel: Identifiable {}

// MARK: - Hashable
extension TemplateModel: Hashable {}

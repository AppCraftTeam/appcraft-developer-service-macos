//
//  TemplateModel.swift
//  ACDeveloperService
//
//  Created by Дмитрий Поляков on 19.08.2022.
//

import Foundation

struct TemplateModel {
    let id: String
    let name: String
    let fileName: String
    let fileExtension: String
    let fileURL: URL
}

// MARK: - Identifiable
extension TemplateModel: Identifiable {}

// MARK: - Hashable
extension TemplateModel: Hashable {}

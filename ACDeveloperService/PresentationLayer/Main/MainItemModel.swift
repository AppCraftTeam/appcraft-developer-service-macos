//
//  MainItemModel.swift
//  ACDeveloperService
//
//  Created by Дмитрий Поляков on 18.08.2022.
//

import Foundation

struct MainItemModel {
    let id: String
    let title: String
    let description: String
}

// MARK: - Identifiable
extension MainItemModel: Identifiable {}

// MARK: - Equatable
extension MainItemModel: Equatable {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    
}

// MARK: - Store
extension MainItemModel {
    
    static let createProject: MainItemModel = .init(
        id: "createProject",
        title: "Create Project",
        description: "Creates a Xcode project based on the selected template"
    )
    
    static let moc1: MainItemModel = .init(
        id: "moc1",
        title: "Moc Title",
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
    )
    
    static let moc2: MainItemModel = .init(
        id: "moc2",
        title: "Moc Title",
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
    )
    
    static let moc3: MainItemModel = .init(
        id: "moc2",
        title: "Moc Title",
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
    )
    
}

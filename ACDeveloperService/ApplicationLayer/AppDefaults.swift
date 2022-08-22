//
//  AppDefaults.swift
//  ACDeveloperService
//
//  Created by Дмитрий Поляков on 22.08.2022.
//

import Foundation

enum AppDefaults {
    
    static var lastUsedTemplateId: String? {
        get { UserDefaults.standard.string(forKey: "AppDefaults_lastUsedTemplateId") }
        set {
            if let value = newValue, !value.isEmpty {
                UserDefaults.standard.set(newValue, forKey: "AppDefaults_lastUsedTemplateId")
            } else {
                UserDefaults.standard.removeObject(forKey: "AppDefaults_lastUsedTemplateId")
            }
        }
    }
    
}

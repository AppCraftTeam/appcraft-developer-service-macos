//
//  CreateProjectViewModel.swift
//  ACDeveloperService
//
//  Created by Дмитрий Поляков on 18.08.2022.
//

import Foundation
import Combine

class CreateProjectViewModel: AppViewModel {
    
    override init() {
        super.init()
        
        self.templateService.getTemplates { [weak self] templates in
            self?.templates = templates
            
            if self?.selectedTemplate == nil {
                self?.selectedTemplate = templates.first
            }
        }
    }
    
    // MARK: - Props
    private let templateService = TemplateService()
    
    @Published var templates: [TemplateModel] = []
    @Published var selectedTemplate: TemplateModel?
    
}

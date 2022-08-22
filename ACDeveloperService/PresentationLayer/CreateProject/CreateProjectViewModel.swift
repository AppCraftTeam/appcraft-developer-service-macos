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
            self?.selectedTemplateId = AppDefaults.lastUsedTemplateId ?? templates.first?.id ?? ""
        }
    }
    
    // MARK: - Props
    private let templateService = TemplateService()
    
    @Published var templates: [TemplateModel] = []
    
    @Published var selectedTemplateId: String = "" {
        didSet { AppDefaults.lastUsedTemplateId = self.selectedTemplateId }
    }
    
    @Published var projectName: String = ""
    
    var createProjectAvalible: Bool {
        self.templates.contains(where: { $0.id == self.selectedTemplateId }) && !self.projectName.isEmpty
    }
    
    // MARK: - Methods
    func createProject(to url: URL) {
        guard let template = self.templates.first(where: { $0.id == self.selectedTemplateId }), !self.projectName.isEmpty else { return }
        
        self.isLoading = true
        
        self.templateService.createProject(from: template, projectName: projectName, to: url, completion: { [weak self] error in
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
                self?.isLoading = false
                self?.error = error
            }
        })
    }
    
}

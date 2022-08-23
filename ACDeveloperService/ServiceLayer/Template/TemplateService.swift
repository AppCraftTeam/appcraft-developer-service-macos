//
//  TemplateService.swift
//  ACDeveloperService
//
//  Created by Дмитрий Поляков on 18.08.2022.
//

import Foundation

class TemplateService {
    
    // MARK: - Props
    private let fileManager: FileManager = .default
    
    // MARK: - Methods
    func getTemplates(completion: ContextClosure<[TemplateModel]>){
        let urls = Bundle.main.urls(forResourcesWithExtension: "zip", subdirectory: nil) ?? []
        let result: [TemplateModel] = urls.map { .init(url: $0)}
        completion(result)
    }
    
    func createProject(from template: TemplateModel, projectName: String, to url: URL, completion: @escaping ContextClosure<Error?>) {
        do {
            let templateName = template.name
            let templateFileExtension = template.fileExtension
            let templateFileName = template.fileName
            let saveUrl = url.appendingPathComponent(projectName, isDirectory: true)

            guard !self.fileManager.fileExists(atPath: saveUrl.path) else {
                completion(TemplateServiceError.projectAlreadyExists)
                return
            }

            guard let templateUrl = Bundle.main.url(forResource: templateName, withExtension: templateFileExtension) else {
                completion(TemplateServiceError.templateNoFound)
                return
            }

            try self.fileManager.clearDocumentDirectory()

            let documentDirectoryUrl = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let templateDocumentsZipUrl = documentDirectoryUrl.appendingPathComponent(templateFileName)
            let templateDocumentsUnzipUrl = documentDirectoryUrl
            let templateDocumentsFolderUrl = documentDirectoryUrl.appendingPathComponent(templateName)

            try self.fileManager.copyItem(at: templateUrl, to: templateDocumentsZipUrl)
            try self.fileManager.unzipItem(at: templateDocumentsZipUrl, to: templateDocumentsUnzipUrl)
            try self.fileManager.removeIfExists(at: templateDocumentsZipUrl)

            let renamer = XcodeProjectRenamer(oldName: templateName, newName: projectName)
            renamer.run(projectPath: templateDocumentsFolderUrl.path)

            try self.fileManager.moveItem(at: templateDocumentsFolderUrl, to: saveUrl)
            try self.fileManager.clearDocumentDirectory()
            
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
}

// MARK: - Private
private extension TemplateService {
    
    func getOrCreateTemplatesFolderURL() throws -> URL {
        let url = try self.fileManager.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let templatesUrl = url.appendingPathComponent("Templates")
        return templatesUrl
    }
    
}

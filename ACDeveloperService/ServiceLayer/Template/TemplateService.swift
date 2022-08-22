//
//  TemplateService.swift
//  ACDeveloperService
//
//  Created by Дмитрий Поляков on 18.08.2022.
//

import Foundation

class TemplateService {
    
    func getTemplates(completion: ContextClosure<[TemplateModel]>){
        let urls = Bundle.main.urls(forResourcesWithExtension: "zip", subdirectory: nil) ?? []
        
        let result: [TemplateModel] = urls.map { url in
            let lastPathComponent = url.lastPathComponent as NSString
            let name = String(lastPathComponent.deletingPathExtension)
            let fileName = url.lastPathComponent
            let fileExtension = String(lastPathComponent.pathExtension)
            
            return .init(
                id: name,
                name: name,
                fileName: fileName,
                fileExtension: fileExtension,
                fileURL: url
            )
        }
        
        completion(result)
    }
    
    func createProject(from template: TemplateModel, projectName: String, to url: URL, completion: @escaping ContextClosure<Error?>) {
        do {
            let fileManager = FileManager.default
            let templateName = template.name
            let templateFileExtension = template.fileExtension
            let templateFileName = template.fileName
            let saveUrl = url.appendingPathComponent(projectName, isDirectory: true)

            guard !fileManager.fileExists(atPath: saveUrl.path) else {
                completion(TemplateServiceError.projectAlreadyExists)
                return
            }

            guard let templateUrl = Bundle.main.url(forResource: templateName, withExtension: templateFileExtension) else {
                completion(TemplateServiceError.templateNoFound)
                return
            }

            try fileManager.clearDocumentDirectory()

            let documentDirectoryUrl = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let templateDocumentsZipUrl = documentDirectoryUrl.appendingPathComponent(templateFileName)
            let templateDocumentsUnzipUrl = documentDirectoryUrl
            let templateDocumentsFolderUrl = documentDirectoryUrl.appendingPathComponent(templateName)

            try fileManager.copyItem(at: templateUrl, to: templateDocumentsZipUrl)
            try fileManager.unzipItem(at: templateDocumentsZipUrl, to: templateDocumentsUnzipUrl)
            try fileManager.removeIfExists(at: templateDocumentsZipUrl)

            let renamer = XcodeProjectRenamer(oldName: templateName, newName: projectName)
            renamer.run(projectPath: templateDocumentsFolderUrl.path)

            try fileManager.moveItem(at: templateDocumentsFolderUrl, to: saveUrl)
            try fileManager.clearDocumentDirectory()
            
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
}

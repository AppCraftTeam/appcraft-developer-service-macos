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
    func fetchTemplatesFromBundle(completion: ContextClosure<Error?>? = nil) {
        do {
            let folderSaveUrl = try self.getOrCreateTemplatesFolderURL()
            let bundleUrls = Bundle.main.urls(forResourcesWithExtension: "zip", subdirectory: nil) ?? []
            
            for bundleUrl in bundleUrls {
                let template = TemplateModel(url: bundleUrl)
                guard let templateUrl = Bundle.main.url(forResource: template.name, withExtension: template.fileExtension) else { continue }
                let templateSaveUrl = folderSaveUrl.appendingPathComponent(template.fileName)
                print("!!! bundleUrl:", bundleUrl)
                print("!!! templateSaveUrl:", templateSaveUrl)
                try self.fileManager.removeIfExists(at: templateSaveUrl)
                try self.fileManager.copyItem(at: templateUrl, to: templateSaveUrl)
            }
            
            completion?(nil)
        } catch {
            completion?(error)
        }
    }
    
    func fetchTemplatesFromGITHUB() {
        let branchName = "main"
        let fileExtension = "zip"
        let fileName = "\(branchName).\(fileExtension)"
        guard let url = URL(string: "https://github.com/AppCraftTeam/appcraft-developer-service-macos/archive/refs/heads/\(fileName)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        
        let task = URLSession.shared.downloadTask(with: request) { [weak self] url, response, error in
            guard let self = self else { return }
            guard let fileUrl = url else { return }
            
            print("!!! response error", error)
            
            do {
                let documentsURL = try self.fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                let archiveURL = documentsURL.appendingPathComponent(fileName)
                let unzipURL = documentsURL.appendingPathComponent(branchName)
                
                try self.fileManager.clearDocumentDirectory()
                
                try self.fileManager.moveItem(at: fileUrl, to: archiveURL)
                try self.fileManager.unzipItem(at: archiveURL, to: unzipURL)
                try self.fileManager.removeIfExists(at: archiveURL)
                
                guard let applicationSupportURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else { return }
                
                let paths = self.fileManager.enumerator(atPath: unzipURL.path)?.allObjects as? [String] ?? []
                let templatesPaths = paths.filter({ $0.contains(".zip") })
                
                for path in templatesPaths {
                    let fullUrl = unzipURL.appendingPathComponent(path)
                    let saveTemplateUrl = applicationSupportURL.appendingPathComponent(fullUrl.lastPathComponent)
                    
                    try self.fileManager.removeIfExists(at: saveTemplateUrl)
                    try self.fileManager.moveItem(at: fullUrl, to: saveTemplateUrl)
                }
                
                try self.fileManager.clearDocumentDirectory()
            
            } catch {
                print("!!! error", error)
            }
            
        }
        
        task.resume()
    }
    
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

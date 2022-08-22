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
    func downloadTemplatesFromGITHUB() {
        guard let url = URL(string: "https://github.com/AppCraftTeam/appcraft-developer-service-macos/archive/refs/heads/main.zip") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.downloadTask(with: request) { url, response, error in
            guard let fileUrl = url else { return }
            
            do {
                let documentsURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
                let savedURL = documentsURL.appendingPathComponent(fileUrl.lastPathComponent)
                try FileManager.default.moveItem(at: fileURL, to: savedURL)
                
                print("!!! savedURL", savedURL)
            } catch {
                print("!!! error", error)
            }
            
        }
//        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
//                let session = NSURLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
//                let request = NSMutableURLRequest(URL: URL)
//                request.HTTPMethod = "GET"
//                let task = session.dataTaskWithRequest(request, completionHandler: { (data: NSData!, response: NSURLResponse!, error: NSError!) -> Void in
//                    if (error == nil) {
//                        // Success
//                        let statusCode = (response as NSHTTPURLResponse).statusCode
//                        println("Success: \(statusCode)")
//
//                        // This is your file-variable:
//                        // data
//                    }
//                    else {
//                        // Failure
//                        println("Failure: %@", error.localizedDescription);
//                    }
//                })
//                task.resume()
    }
    
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

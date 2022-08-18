//
//  XcodeProjectCreator.swift
//  ACDeveloperService
//
//  Created by Дмитрий Поляков on 18.08.2022.
//

import Foundation

class XcodeProjectCreator {
    
    func run(url: URL) throws {
        do {
            let fileManager = FileManager.default
            let templateName = "PROJECT_UIKIT_1.0.0"
            let templateFileExtension = "zip"
            let templateFileName = "\(templateName).\(templateFileExtension)"
            let projectName = "NewProjectName"
            let saveUrl = url.appendingPathComponent(projectName, isDirectory: true)

            guard !fileManager.fileExists(atPath: saveUrl.path) else {
                throw XcodeProjectCreatorError.projectAlreadyExists
            }

            guard let templateUrl = Bundle.main.url(forResource: templateName, withExtension: templateFileExtension) else {
                throw XcodeProjectCreatorError.templateNoFound
            }

            guard let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                throw XcodeProjectCreatorError.documentsDirectoryNoFound
            }

            try fileManager.clearDocumentDirectory()

            let documentDirectoryUrl = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let templateDocumentsZipUrl = documentDirectoryUrl.appendingPathComponent(templateFileName)
            let templateDocumentsUnzipUrl = documentDirectoryUrl
            let templateDocumentsFolderUrl = documentDirectoryUrl.appendingPathComponent(templateName)

//            try fileManager.removeIfExists(at: templateDocumentsZipUrl)
//            try fileManager.removeIfExists(at: templateDocumentsFolderUrl)

            print("templateUrl:", templateUrl)
            print("templateDocumentsZipUrl:", templateDocumentsZipUrl)
            print("templateDocumentsUnzipUrl:", templateDocumentsUnzipUrl)
            print("templateDocumentsFolderUrl:", templateDocumentsFolderUrl)

            try fileManager.copyItem(at: templateUrl, to: templateDocumentsZipUrl)
            try fileManager.unzipItem(at: templateDocumentsZipUrl, to: templateDocumentsUnzipUrl)
            try fileManager.removeIfExists(at: templateDocumentsZipUrl)

            let renamer = XcodeProjectRenamer(oldName: templateName, newName: projectName)
            renamer.run(projectPath: templateDocumentsFolderUrl.path)

            try fileManager.moveItem(at: templateDocumentsFolderUrl, to: saveUrl)
            try fileManager.clearDocumentDirectory()

        } catch {
            throw error
        }
    }
    
}

//
//  XcodeProjectRenamer.swift
//  ACDeveloperService
//
//  Created by Дмитрий Поляков on 18.08.2022.
//

import Foundation

class XcodeProjectRenamer: NSObject {
    
    // MARK: - Init
    init(oldName: String, newName: String) {
        self.oldName = oldName
        self.newName = newName
    }

    // MARK: - Props
    let fileManager = FileManager.default
    private var processedPaths = [String]()

    let oldName: String
    let newName: String

    // MARK: - Methods
    func run(projectPath: String) {
        print("\n------------------------------------------")
        print("Rename Xcode Project from [\(self.oldName)] to [\(self.newName)]")
        print("Current Path: \(projectPath)")
        print("------------------------------------------\n")

        if self.validatePath(projectPath) {
            self.enumeratePath(projectPath)
        } else {
            print("Xcode project or workspace with name: [\(self.oldName)] is not found at current path.")
        }

        print("\n------------------------------------------")
        print("Xcode Project Rename Finished!")
        print("------------------------------------------\n")
    }

}

// MARK: - Private
private extension XcodeProjectRenamer {
    
    func validatePath(_ path: String) -> Bool {
        let projectPath = path.appending("/\(self.oldName).xcodeproj")
        let workspacePath = path.appending("/\(self.oldName).xcworkspace")
        let isValid = self.fileManager.fileExists(atPath: projectPath) || self.fileManager.fileExists(atPath: workspacePath)
        return isValid
    }

    func enumeratePath(_ path: String) {
        let enumerator = self.fileManager.enumerator(atPath: path)
        
        while let element = enumerator?.nextObject() as? String {
            let itemPath = path.appending("/\(element)")
            
            if !self.processedPaths.contains(itemPath) && !shouldSkip(element) {
                self.processPath(itemPath)
            }
        }
    }

    func processPath(_ path: String) {
        print("Processing: \(path)")

        var isDir: ObjCBool = false
        
        if self.fileManager.fileExists(atPath: path, isDirectory: &isDir) {
            if isDir.boolValue {
                self.enumeratePath(path)
            } else {
                self.updateContentsOfFile(atPath: path)
            }
            
            self.renameItem(atPath: path)
        }

        self.processedPaths.append(path)
    }

    func shouldSkip(_ element: String) -> Bool {
        guard
            !element.hasPrefix("."),
            !element.contains(".DS_Store"),
            !element.contains("Carthage"),
            !element.contains("Pods"),
            !element.contains("fastlane"),
            !element.contains("build")
        else { return true }

        let fileExtension = URL(fileURLWithPath: element).pathExtension
        
        switch fileExtension {
        case "appiconset",
            "json",
            "png",
            "xcuserstate":
            return true
        default:
            return false
        }
    }

    func updateContentsOfFile(atPath path: String) {
        do {
            let oldContent = try String(contentsOfFile: path, encoding: .utf8)
            
            if oldContent.contains(self.oldName) {
                let newContent = oldContent.replacingOccurrences(of: self.oldName, with: self.newName)
                try newContent.write(toFile: path, atomically: true, encoding: .utf8)
                print("-- Updated: \(path)")
            }
        } catch {
            print("Error while updating file: \(error.localizedDescription)\n")
        }
    }

    func renameItem(atPath path: String) {
        do {
            let oldItemName = URL(fileURLWithPath: path).lastPathComponent
            if oldItemName.contains(oldName) {
                let newItemName = oldItemName.replacingOccurrences(of: oldName, with: newName)
                let directoryURL = URL(fileURLWithPath: path).deletingLastPathComponent()
                let newPath = directoryURL.appendingPathComponent(newItemName).path
                try fileManager.moveItem(atPath: path, toPath: newPath)
                print("-- Renamed: \(oldItemName) -> \(newItemName)")
            }
        } catch {
            print("Error while renaming file: \(error.localizedDescription)")
        }
    }
    
}

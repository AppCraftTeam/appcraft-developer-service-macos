//
//  FileManager.swift
//  ACDeveloperService
//
//  Created by Дмитрий Поляков on 18.08.2022.
//

import Foundation

extension FileManager {
    
    func removeIfExists(at url: URL) throws {
        guard self.fileExists(atPath: url.path) else { return }
        try self.removeItem(at: url)
    }
    
    func clearDocumentDirectory() throws {
        guard let documentsUrl =  self.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

        do {
            let contentsOfDirectory = try self.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            
            for fileURL in contentsOfDirectory {
                try self.removeIfExists(at: fileURL)
            }
        } catch {
            throw error
        }
    }
    
}

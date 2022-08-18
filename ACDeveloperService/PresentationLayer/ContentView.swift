//
//  ContentView.swift
//  ACDeveloperService
//
//  Created by Дмитрий Поляков on 17.08.2022.
//

import SwiftUI
import ZIPFoundation

struct ContentView: View {
    
    @State var filePath: String?
    @State var isError: Bool = false
    var error: Error?
    let templateService = XcodeProjectCreator()
    
    var body: some View {
        HStack {
            Button("Create project") {
                self.test()
            }
        }
        .alert(self.error?.localizedDescription ?? "Some error", isPresented: self.$isError, actions: {
            Text("dfdfdfgd")
        })
        .frame(width: 500, height: 500)
      }
}

private extension ContentView {
    
    func test() {
        let openPanel = NSOpenPanel()
        openPanel.message = "Select folder"
        openPanel.prompt = "Create project"
        openPanel.canChooseFiles = false
        openPanel.canChooseDirectories = true
        openPanel.canCreateDirectories = true
        
        openPanel.begin { response in
            guard response == .OK, let url = openPanel.url else { return }
            
            do {
                try self.templateService.run(url: url)
            } catch {
                self.isError = true
            }
        }
        
        
        
        
        
//        openPanel.begin { response in
//            print("!!!", response)
//        }
//        openPanel.begin() { (result2) -> Void in
//            if result2 == NSApplication.ModalResponse.OK {
//                storeBookmark(url: openPanel.url!)          // Save the bookmark for future use if needed
//
//                let savePanel = NSSavePanel()
//                savePanel.title = NSLocalizedString("File to create", comment: "enableFileMenuItems")
//                savePanel.nameFieldStringValue = ""
//                savePanel.prompt = NSLocalizedString("Create", comment: "enableFileMenuItems")
//                savePanel.allowedFileTypes = ["xxxx"]   // if you want to specify file signature
//                let fileManager = FileManager.default
//
//                savePanel.begin() { (result) -> Void in
//                    if result == NSApplication.ModalResponse.OK {
//                        let fileWithExtensionURL = savePanel.url!  //  May test that file does not exist already
//                        if fileManager.fileExists(atPath: fileWithExtensionURL.path) {
//                        } else {
//                                       // Now, write the file
//                    }
//                }
//            }
//        }
//        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

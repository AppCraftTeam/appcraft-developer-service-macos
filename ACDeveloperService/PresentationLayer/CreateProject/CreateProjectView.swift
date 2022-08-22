//
//  CreateProjectView.swift
//  ACDeveloperService
//
//  Created by Дмитрий Поляков on 18.08.2022.
//

import SwiftUI

struct CreateProjectView: View {
    
    @EnvironmentObject var errorPresented: ErrorPresentedObject
    @StateObject private var viewModel: CreateProjectViewModel = .init()
    @State private var disabledFocus: Bool = true
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                
                if self.viewModel.isLoading {
                    ProgressView("Project creating")
                        .scaleEffect(x: 1, y: 1, anchor: .center)
                } else {
                    self.drawForm()
                        .frame(width: 300, alignment: .center)
                }
                
                Spacer()
            }
            
            Spacer()
        }
        .onReceive(self.viewModel.$error, perform: { error in
            self.errorPresented.error = error
        })
        .onAppear {
           DispatchQueue.main.async {
               self.disabledFocus = false
           }
        }
    }
    
}

// MARK: - Private
private extension CreateProjectView {
    
    func drawForm() -> some View {
        Form {
            if !self.viewModel.templates.isEmpty {
                Picker("Template:", selection: self.$viewModel.selectedTemplateId) {
                    ForEach(self.viewModel.templates) { template in
                        Text(template.name)
                            .tag(template.id)
                    }
                }
            }
            
            TextField("Project Name", text: self.$viewModel.projectName)
                .textFieldStyle(.roundedBorder)
                .disabled(self.disabledFocus)

            Button("Create Project") {
                self.tapConfirmButton()
            }
            .buttonStyle(.borderedProminent)
            .disabled(!self.viewModel.createProjectAvalible)
        }
    }
    
    
    func tapConfirmButton() {
        self.openPanel { url in
            guard let url = url else { return }
            self.viewModel.createProject(to: url)
        }
    }
    
    func openPanel(completion: @escaping ContextClosure<URL?>) {
        let openPanel = NSOpenPanel()
        openPanel.message = "Select folder"
        openPanel.prompt = "Create project"
        openPanel.canChooseFiles = false
        openPanel.canChooseDirectories = true
        openPanel.canCreateDirectories = true

        openPanel.begin { response in
            guard response == .OK, let url = openPanel.url else {
                completion(nil)
                return
            }
            
            completion(url)
        }
    }
    
}

//
//  CreateProjectView.swift
//  ACDeveloperService
//
//  Created by Дмитрий Поляков on 18.08.2022.
//

import SwiftUI

struct CreateProjectView: View {
    
    @StateObject private var viewModel: CreateProjectViewModel = .init()
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Spacer()
            
//            HStack {
                
                
                Form {
                    TemplatesView(templates: self.viewModel.templates, selectedTemplate: self.$viewModel.selectedTemplate)
                    
                    Picker(selection: self.$viewModel.selectedTemplate) {
                        ForEach(self.viewModel.templates) { template in
                            Text(template.name)
                                .tag(template)
                        }
                    } label: {
                        Text("Select Template")
                    }

                }
                .frame(width: 300, alignment: .center)
//            }
            
            
            Spacer()
            
        }
    }
    
}

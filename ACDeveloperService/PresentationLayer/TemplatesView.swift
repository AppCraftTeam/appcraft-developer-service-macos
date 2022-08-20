//
//  TemplatesView.swift
//  ACDeveloperService
//
//  Created by Дмитрий Поляков on 19.08.2022.
//

import Foundation
import SwiftUI

struct TemplatesView: View {
    
    let templates: [TemplateModel]
    @Binding var selectedTemplate: TemplateModel?
    
    var body: some View {
        Menu {
            ForEach(self.templates) { template in
                Button {
                    self.selectedTemplate = template
                } label: {
                    Text(template.name)
                }
            }
        } label: {
            Text(self.selectedTemplate?.name ?? "")
        }
    }
    
}

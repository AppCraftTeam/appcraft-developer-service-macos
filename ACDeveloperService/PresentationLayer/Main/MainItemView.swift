//
//  MainItemView.swift
//  ACDeveloperService
//
//  Created by Дмитрий Поляков on 18.08.2022.
//

import Foundation
import SwiftUI

struct MainItemView: View {
    
    let item: MainItemModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            VStack(alignment: .leading, spacing: 8) {
                Text(self.item.title)
                    .font(.system(size: 16))
                    .lineLimit(2)
                Text(self.item.description)
                    .font(.system(size: 10))
                    .lineLimit(2)
            }
            
            Spacer()
        }
    }
    
}

//
//  MainView.swift
//  ACDeveloperService
//
//  Created by Дмитрий Поляков on 18.08.2022.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var viewModel: MainViewModel = .init()
    
    var body: some View {
        ZStack {
//            NavigationView {
//                LazyVStack {
//                    ForEach(self.viewModel.items) { item in
//                        MainItemView(item: item)
//                    }
//                    
//                    Spacer()
//                }
////                .frame(minWidth: 300)
//                .frame(width: 200)
//                
//                Text("!1111")
//            }
//            .navigationViewStyle(.columns)
//            .interactiveDismissDisabled()
        }
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

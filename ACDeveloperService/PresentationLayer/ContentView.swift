//
//  ContentView.swift
//  ACDeveloperService
//
//  Created by Дмитрий Поляков on 17.08.2022.
//

import SwiftUI
import ZIPFoundation

struct ContentView: View {
    
    @StateObject var errorPresented: ErrorPresentedObject = .init()
    
    var body: some View {
        CreateProjectView()
            .frame(minWidth: 700, minHeight: 300)
            .environmentObject(self.errorPresented)
            .alert(isPresented: self.$errorPresented.error.mappedToBool()) {
                Alert(
                    title: Text("Error"),
                    message: Text(self.errorPresented.error?.localizedDescription ?? "")
                )
            }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

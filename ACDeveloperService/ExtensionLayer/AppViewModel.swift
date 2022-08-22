//
//  AppViewModel.swift
//  ACDeveloperService
//
//  Created by Дмитрий Поляков on 18.08.2022.
//

import Foundation
import Combine

class AppViewModel: ObservableObject {
    
    // MARK: - Init
    init() {}
    
    // MARK: - Props
    @Published var error: Error?
    @Published var isLoading: Bool = false
}

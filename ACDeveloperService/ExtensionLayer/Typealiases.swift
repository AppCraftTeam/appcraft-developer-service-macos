//
//  Typealiases.swift
//  ACDeveloperService
//
//  Created by Дмитрий Поляков on 19.08.2022.
//

import Foundation

typealias Closure = () -> Void
typealias ContextClosure<T> = (T) -> Void
typealias ResultClosure<T> = ContextClosure<Result<T, Error>>

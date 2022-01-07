//
//  ViewModelType.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2022/01/06.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

//
//  DateManager.swift
//  SeSACWeek14
//
//  Created by 박연배 on 2022/01/04.
//

import Foundation

class DateManager {
    static let shared = DateManager()
    let dateFormatter = DateFormatter()
    
    private init() {
        
    }
    
    func stringToDate(string: String) -> Date {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return dateFormatter.date(from: string)!
    }
    
    func dateToString(date: Date) -> String {
        dateFormatter.dateFormat = "MM/dd"
        return dateFormatter.string(from: date)
    }
}

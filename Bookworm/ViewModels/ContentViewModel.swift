//
//  ContentViewModel.swift
//  Bookworm
//
//  Created by Vincent Salinas on 9/6/22.
//

import Foundation

class ContentViewModel {
    static func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        // US English Locale (en_US)
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: date) // Jan 2, 2001
    }
}

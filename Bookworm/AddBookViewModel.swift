//
//  AddBookViewModel.swift
//  Bookworm
//
//  Created by Vincent Salinas on 9/6/22.
//

import Foundation

class AddBookViewModel {
    static func validateDetails(newBook: NewBook) -> Bool {
        
        guard !newBook.title.isEmpty else {
            return false
        }
        
        guard !newBook.author.isEmpty else {
            return false
        }
        
        guard !newBook.genre.isEmpty else {
            return false
        }
        
        guard !newBook.review.isEmpty else {
            return false
        }
        
        guard (1...5).contains(newBook.rating) else {
            return false
        }
        
        return true
        
    }
}

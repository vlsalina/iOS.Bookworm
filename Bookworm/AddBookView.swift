//
//  AddBookView.swift
//  Bookworm
//
//  Created by Vincent Salinas on 9/4/22.
//

import SwiftUI

struct NewBook {
    var title: String
    var author: String
    var genre: String
    var review: String
    var rating: Int
}

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var genre = ""
    @State private var review = ""
    @State private var rating = 3
    
    @State private var validationAlert = false
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }
                
                Section {
                    Button(action: {
                        let newBook = Book(context: moc)
                        
                        let result = AddBookViewModel.validateDetails(newBook: NewBook(title: title, author: author, genre: genre, review: review, rating: rating))
                        
                        if (result) {
                            newBook.id = UUID()
                            newBook.title = title
                            newBook.author = author
                            newBook.genre = genre
                            newBook.review = review
                            newBook.rating = Int16(rating)
                            
                            try? moc.save()
                            dismiss()
                        } else {
                            validationAlert = true
                        }
                        
                        
                    }) {
                        HStack {
                            Spacer()
                            Text("Save")
                            Spacer()
                        }
                    }
                }
                
            }
            
        }
        .navigationTitle("Add Book")
        .alert(isPresented: $validationAlert) {
            Alert(
                title: Text("Alert"),
                message: Text("Invalid book details"),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}

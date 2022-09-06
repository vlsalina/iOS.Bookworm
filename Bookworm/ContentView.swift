//
//  ContentView.swift
//  Bookworm
//
//  Created by Vincent Salinas on 9/4/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),
        SortDescriptor(\.author)
    ]) var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    NavigationLink {
                        DetailView(book: book)
                    } label: {
                        HStack {
                            EmojiRatingReview(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unknown Title")
                                    .font(.headline)
                                    .foregroundColor(ratingColor(rating: Int(book.rating)))
                                HStack(spacing: 20) {
                                    Text(book.author ?? "Unknown Author")
                                        .foregroundColor(.secondary)
                                    Text(ContentViewModel.formatDate(date: book.date!))
                                        .foregroundColor(.secondary)
                                    
                                    
                                }
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddScreen.toggle()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookView()
            }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            // find this book in our fetch request
            let book = books[offset]
            
            // delete it from the context
            moc.delete(book)
        }
        
        // save the context
        try? moc.save()
    }
    
    func ratingColor(rating: Int) -> Color {
        switch (rating) {
        case 1: return Color.red
        case 2: return Color.orange
        case 3: return Color.yellow
        case 4: return Color.green
        default: return Color.blue
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

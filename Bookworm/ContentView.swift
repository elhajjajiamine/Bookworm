//
//  ContentView.swift
//  Bookworm
//
//  Created by Elhajjaji on 5/25/20.
//  Copyright © 2020 Elhajjaji. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Book.entity(), sortDescriptors: []) var books: FetchedResults<Book>
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books,id:\.self){book in
                    NavigationLink(destination: Text(book.title ?? "Unknown title"))
                    {
                        EmojiRatingView(rating: book.rating)
                            .font(.largeTitle)
                        
                        VStack(alignment:.leading){
                            Text(book.title ?? "Unknown title")
                                .font(.headline)
                            Text(book.author ?? "Unknown author")
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }

            .navigationBarTitle("Bookworm")
                .navigationBarItems(trailing: Button(action : {
                    self.showingAddScreen.toggle()
                }){
                    Image(systemName: "plus")
                })
                .sheet(isPresented: $showingAddScreen) {
                    AddBookView().environment(\.managedObjectContext,self.moc)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

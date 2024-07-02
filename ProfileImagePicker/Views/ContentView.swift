//
//  ContentView.swift
//  ProfileImagePicker
//
//  Created by Nowroz Islam on 2/7/24.
//

import PhotosUI
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \User.username) private var users: [User]
    
    @State private var showingAddUserSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(users) { user in
                    HStack(spacing: 16) {
                        ProfileImageView(imageState: user.imageState)
                            .frame(width: 40, height: 40)
                            .clipShape(.circle)
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text(user.name)
                                .font(.headline)
                            Text("@\(user.username)")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteUsers)
            }
            .navigationTitle("Users")
            .toolbar {
                Button("Add User", systemImage: "person.fill.badge.plus") {
                    showingAddUserSheet = true
                }
            }
            .sheet(isPresented: $showingAddUserSheet) {
                AddUserView()
            }
        }
    }
    
    func deleteUsers(at offsets: IndexSet) {
        for offset in offsets {
            let user = users[offset]
            modelContext.delete(user)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(previewContainer)
}

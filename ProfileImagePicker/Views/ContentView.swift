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
                if users.isEmpty {
                    ContentUnavailableView {
                        Label("No Users Found", systemImage: "person.2.fill")
                    } description: {
                        Text("You have not added any users yet.")
                    } actions: {
                        addUserButton
                    }
                } else {
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
            }
            .navigationTitle("Users")
            .toolbar {
                addUserButton
            }
            .sheet(isPresented: $showingAddUserSheet) {
                AddUserView()
            }
        }
    }
    
    var addUserButton: some View {
        Button("Add User", systemImage: "person.fill.badge.plus") {
            showingAddUserSheet = true
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

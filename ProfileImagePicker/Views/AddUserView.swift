//
//  AddUserView.swift
//  ProfileImagePicker
//
//  Created by Nowroz Islam on 2/7/24.
//

import SwiftData
import SwiftUI

struct AddUserView: View {
    enum FocusField {
        case username
    }
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var user: User = User(username: "", name: "")
    @State private var showingAlert: Bool = false
    @FocusState private var focusField: FocusField?
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    EditableCircularProfileImageView(for: user)
                        .frame(maxWidth: .infinity)
                }
                
                Section {
                    TextField("Enter Name", text: $user.name)
                    TextField("Username", text: $user.username)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .focused($focusField, equals: .username)
                }
            }
            .navigationTitle("Add User")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", action: save)
                }
            }
            .alert("Empty Username", isPresented: $showingAlert) {
                
            } message: {
                Text("The user must have a username.")
            }
        }
    }
    
    func save() {
        guard isValid() else { 
            showingAlert = true
            return
        }
        modelContext.insert(user)
        dismiss()
    }
    
    func isValid() -> Bool {
        if user.trimmedUsername.isEmpty {
            focusField = .username
            return false
        } else {
            user.name = user.trimmedName
            user.username = user.trimmedUsername
            return true
        }
    }
}

#Preview {
    AddUserView()
}

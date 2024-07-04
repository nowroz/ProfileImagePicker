//
//  ProfileImagePickerApp.swift
//  ProfileImagePicker
//
//  Created by Nowroz Islam on 2/7/24.
//

import SwiftData
import SwiftUI

@main
struct ProfileImagePickerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self, isUndoEnabled: true)
    }
}

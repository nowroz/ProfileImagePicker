//
//  User.swift
//  ProfileImagePicker
//
//  Created by Nowroz Islam on 2/7/24.
//

import Foundation
import SwiftData
import SwiftUI

@Model final class User {
    @Attribute(.unique) var username: String
    var name: String
    var imageData: Data?
    
    init(username: String, name: String, imageData: Data? = nil) {
        self.username = username
        self.name = name
        self.imageData = imageData
    }
}

extension User {
    var imageState: ImageState {
        guard let imageData else {
            return .empty
        }
        
        let uiImage = UIImage(data: imageData)
        
        guard let uiImage else {
            fatalError("Failed to create UIImage from data")
        }
        
        let image = Image(uiImage: uiImage)
        
        return .success(image)
    }
    
    var trimmedName: String {
        name.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var trimmedUsername: String {
        username.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

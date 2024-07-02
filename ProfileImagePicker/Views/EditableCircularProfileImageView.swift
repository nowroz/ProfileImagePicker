//
//  EditableCircularProfileImageView.swift
//  ProfileImagePicker
//
//  Created by Nowroz Islam on 2/7/24.
//

import PhotosUI
import SwiftData
import SwiftUI

struct EditableCircularProfileImageView: View {
    var user: User
    @State private var photosPickerItem: PhotosPickerItem?
    @State private var imageState: ImageState = .empty
    
    var body: some View {
        CircularProfileImageView(imageState: imageState)
            .overlay(alignment: .bottomTrailing) {
                PhotosPicker(selection: $photosPickerItem, matching: .images) {
                    Image(systemName: "pencil.circle.fill")
                        .symbolRenderingMode(.multicolor)
                        .font(.system(size: 30))
                }
                .buttonStyle(.borderless)
            }
            .onChange(of: photosPickerItem) {
                Task {
                    await assignImage()
                }
            }
    }
    
    @MainActor func assignImage() async {
        do {
            guard let photosPickerItem else {
                throw ImageHandlingError.emptyPickerItem
                
            }
            
            imageState = .loading
            
            let imageData = try await photosPickerItem.loadTransferable(type: Data.self)
            
            guard let imageData else {
                throw ImageHandlingError.loadTransferableFailure
            }
            
            user.imageData = imageData
            
            let uiImage = UIImage(data: imageData)
            
            guard let uiImage else {
                throw ImageHandlingError.uiImageInitializationFailure
            }
            
            let image = Image(uiImage: uiImage)
            
            imageState = .success(image)
            
        } catch ImageHandlingError.emptyPickerItem {
            fatalError("Failed to select an image")
        } catch ImageHandlingError.loadTransferableFailure {
            fatalError("Failed to load image data from the PhotosPickerItem")
        } catch ImageHandlingError.uiImageInitializationFailure {
            fatalError("Failed to initialize UIImage from image data")
        } catch {
            fatalError("Failed to assign image - \(error.localizedDescription)")
        }
    }
    
    init(for user: User) {
        self.user = user
    }
}

#Preview {
    EditableCircularProfileImageView(for: User(username: "", name: ""))
        .modelContainer(previewContainer)
}

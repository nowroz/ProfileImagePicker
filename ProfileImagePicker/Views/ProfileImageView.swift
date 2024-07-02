//
//  ProfileImageView.swift
//  ProfileImagePicker
//
//  Created by Nowroz Islam on 2/7/24.
//

import SwiftUI

struct ProfileImageView: View {
    let imageState: ImageState
    
    var body: some View {
        switch imageState {
        case .success(let image):
            image
                .resizable()
                .scaledToFill()
        case .loading:
            ProgressView()
        case .empty:
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.secondary)
        case .failure:
            Image(systemName: "exclamationmark.circle.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    ProfileImageView(imageState: .failure)
}

//
//  CircularProfileImageView.swift
//  ProfileImagePicker
//
//  Created by Nowroz Islam on 2/7/24.
//

import SwiftUI

struct CircularProfileImageView: View {
    let imageState: ImageState
    
    var body: some View {
        ProfileImageView(imageState: imageState)
            .frame(width: 100, height: 100)
            .clipShape(.circle)
            
            
    }
}

#Preview {
    CircularProfileImageView(imageState: .failure)
}

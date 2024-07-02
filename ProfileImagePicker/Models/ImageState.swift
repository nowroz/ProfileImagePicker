//
//  ImageState.swift
//  ProfileImagePicker
//
//  Created by Nowroz Islam on 2/7/24.
//

import Foundation
import SwiftUI

enum ImageState: Equatable {    
    case success(Image)
    case loading
    case empty
    case failure
}

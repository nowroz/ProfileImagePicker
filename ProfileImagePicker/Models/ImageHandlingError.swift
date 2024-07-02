//
//  ImageHandlingError.swift
//  ProfileImagePicker
//
//  Created by Nowroz Islam on 2/7/24.
//

import Foundation

enum ImageHandlingError: Error {
    case emptyPickerItem
    case loadTransferableFailure
    case uiImageInitializationFailure
}

//
//  PreviewSampleData.swift
//  ProfileImagePicker
//
//  Created by Nowroz Islam on 2/7/24.
//

import Foundation
import SwiftData

@MainActor let previewContainer: ModelContainer = {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
        
        if try container.mainContext.fetch(FetchDescriptor<User>()).isEmpty {
            SampleUsers.content.forEach { container.mainContext.insert($0) }
        }
        
        return container
    } catch {
        fatalError("Failed to create ModelContainer")
    }
}()

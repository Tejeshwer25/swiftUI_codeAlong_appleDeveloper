//
//  DataContainer.swift
//  GratefulMoments
//
//  Created by Tejeshwer Singh on 18/11/25.
//

import SwiftData
import SwiftUI

@Observable
@MainActor
class DataContainer {
    let modelContainer: ModelContainer
    var badgeManager: BadgeManager
    
    var context: ModelContext {
        self.modelContainer.mainContext
    }
    
    init(includeSampleMoments: Bool = false) {
        let schema = Schema([
            Moment.self,
            Badge.self
        ])
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: includeSampleMoments)
        do {
            self.modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            self.badgeManager = BadgeManager(modelContainer: modelContainer)
            
            try badgeManager.loadBadgesIfNeeded()
            
            if includeSampleMoments {
                try self.loadSampleMoments()
            }
            try self.context.save()
        } catch {
            fatalError("Could not create model container: \(error)")
        }
    }
    
    private func loadSampleMoments() throws {
        for moment in Moment.sampleData {
            self.context.insert(moment)
            
            try self.badgeManager.unlockBadges(newMoment: moment)
        }
    }
}

private let sampleContainer = DataContainer(includeSampleMoments: true)

extension View {
    func sampleDataContainer() -> some View {
        self
            .environment(sampleContainer)
            .modelContainer(sampleContainer.modelContainer)
    }
}

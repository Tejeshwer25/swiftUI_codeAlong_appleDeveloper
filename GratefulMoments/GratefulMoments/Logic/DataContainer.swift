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
    
    var context: ModelContext {
        self.modelContainer.mainContext
    }
    
    init(includeSampleMoments: Bool = false) {
        let schema = Schema([
            Moment.self
        ])
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: includeSampleMoments)
        do {
            self.modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            
            if includeSampleMoments {
                self.loadSampleMoments()
            }
            try self.context.save()
        } catch {
            fatalError("Could not create model container: \(error)")
        }
    }
    
    private func loadSampleMoments() {
        for moment in Moment.sampleData {
            self.context.insert(moment)
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

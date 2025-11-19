//
//  GratefulMomentsApp.swift
//  GratefulMoments
//
//  Created by Tejeshwer Singh on 16/11/25.
//

import SwiftUI
import SwiftData

@main
struct GratefulMomentsApp: App {
    let dataContainer = DataContainer()
    
    var body: some Scene {
        WindowGroup {
            MomentsView()
                .environment(dataContainer)
        }
        .modelContainer(dataContainer.modelContainer)
    }
}

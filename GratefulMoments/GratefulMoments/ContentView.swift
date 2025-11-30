//
//  ContentView.swift
//  GratefulMoments
//
//  Created by Tejeshwer Singh on 16/11/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Moments", image: "MomentsTab") {
                MomentsView()
            }
            
            Tab("Achievements", systemImage: "medal.fill") {
                AchievementsView()
            }
        }
    }
}

#Preview {
    ContentView()
        .sampleDataContainer()
}

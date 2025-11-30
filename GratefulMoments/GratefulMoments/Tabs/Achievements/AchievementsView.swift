//
//  AchievementsView.swift
//  GratefulMoments
//
//  Created by Tejeshwer Singh on 30/11/25.
//

import SwiftUI
import SwiftData

struct AchievementsView: View {
    @Query(filter: #Predicate<Badge> { $0.timestamp != nil })
    private var unlockedBadges: [Badge]
    
    @Query(filter: #Predicate<Badge> { $0.timestamp == nil })
    private var lockedBadges: [Badge]
    
    @Query(sort: \Moment.timeStamp)
    private var moments: [Moment]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                contentStack
            }
            .navigationTitle("Achievements")
        }
    }
    
    private var contentStack: some View {
        VStack(alignment: .leading) {
            StreakView(numberOfDays: StreakCalculator().calculateStreak(for: moments))
                .frame(maxWidth: .infinity)
            
            if !unlockedBadges.isEmpty {
                header("Your Badges")
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(sortedUnlockedBadges) {
                            UnlockedBadgeView(badge: $0)
                        }
                    }
                }
                .scrollClipDisabled()
                .scrollIndicators(.hidden)
            }
            
            if !lockedBadges.isEmpty {
                header("Locked Badges")
                ForEach(sortedLockedBadges) {
                    LockedBadgeView(badge: $0)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
    }
    
    private var sortedLockedBadges: [Badge] {
        lockedBadges.sorted {
            $0.details.rawValue < $1.details.rawValue
        }
    }
    
    private var sortedUnlockedBadges: [Badge] {
        unlockedBadges.sorted {
            ($0.timestamp!, $0.details.title) < ($1.timestamp!, $1.details.title)
        }
    }
    
    func header(_ text: String) -> some View {
        Text(text)
            .font(.subheadline.bold())
            .padding()
    }
}

#Preview {
    AchievementsView()
        .sampleDataContainer()
}

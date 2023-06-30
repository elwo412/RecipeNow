//
//  BadgeContainerView.swift
//  RecipeNow!
//
//  Created by Thomas Worrall on 6/29/23.
//

import Foundation
import SwiftUI

struct BadgeContainerView: View {
    var maxWidth: CGFloat
    var badgesString: String
    
    private var badges: [String] {
        return badgesString.split(separator: ",").map { String($0.trimmingCharacters(in: .whitespaces)) }
    }
    
    var body: some View {
        var totalLength: CGFloat = 0
        var visibleBadges: [String] = []
        
        for badge in badges {
            let badgeLength: CGFloat = CGFloat(badge.count * 8 + 10) // 10 per character + 10 padding
            if totalLength + badgeLength > maxWidth {
                break
            }
            totalLength += badgeLength
            visibleBadges.append(badge)
        }
        
        return HStack {
            ForEach(visibleBadges, id: \.self) { badge in
                BadgeView(text: badge)
            }
            
            if visibleBadges.count < badges.count {
                BadgeView(text: "...")
            }
        }
        .frame(maxWidth: maxWidth, alignment: .leading)
    }
}

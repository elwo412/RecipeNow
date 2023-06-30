//
//  BadgeView.swift
//  RecipeNow!
//
//  Created by Thomas Worrall on 6/29/23.
//

import Foundation
import SwiftUI

struct BadgeView: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.subheadline)
            .fontWeight(.bold)
            .fixedSize(horizontal: true, vertical: false)
            .padding(.vertical, 5)
            .padding(.horizontal, 5)
            .foregroundColor(.white)
    }
}

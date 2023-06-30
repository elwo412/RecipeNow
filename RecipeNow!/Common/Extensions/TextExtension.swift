//
//  TextExtension.swift
//  RecipeNow!
//
//  Created by Thomas Worrall on 6/29/23.
//

import Foundation
import SwiftUI

//not actually extension, but I wouldn't consider it to be a Common View
struct ScaledFont: View {
    var text: String
    var minSize: CGFloat = 12
    var maxSize: CGFloat = .infinity

    var body: some View {
        GeometryReader { geometry in
            Text(self.text)
                .font(.system(size: min(maxSize, max(minSize, geometry.size.width * 0.25))))
        }
    }
}

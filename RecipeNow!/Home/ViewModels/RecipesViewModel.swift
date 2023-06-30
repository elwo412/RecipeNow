//
//  RecipesViewModel.swift
//  RecipeNow!
//
//  Created by Thomas Worrall on 6/27/23.
//

import Foundation
import SwiftUI

class RecipesViewModel: ObservableObject {
    let gridItems: [GridItem]
    
    init() {
        gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    }
}

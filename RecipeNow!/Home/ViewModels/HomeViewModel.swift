//
//  HomeViewModel.swift
//  RecipeNow!
//
//  Created by Thomas Worrall on 6/27/23.
//

import Foundation
class HomeViewModel: ObservableObject {
    @Published var recipeBook: RecipeBook
    
    init() {
        recipeBook = RecipeBook()
    }
}

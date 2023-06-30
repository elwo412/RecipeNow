//
//  RecipeDetailsViewModel.swift
//  RecipeNow!
//
//  Created by Thomas Worrall on 6/29/23.
//

import Foundation
import SwiftUI

class RecipeDetailsViewModel: ObservableObject {
    @Published var dataloaded = false
    @Published var recipeDetails: RecipeDetail?
    var recipe: Recipe

    init(recipe: Recipe) {
        self.recipe = recipe
    }

    func fetchDetails() {
        Task {
            do {
                let details = try await fetchRecipeDetails(recipeID: recipe.mealdb_id)
                DispatchQueue.main.async {
                    self.recipeDetails = details
                    withAnimation(.easeIn) {
                        self.dataloaded = true
                    }
                }
            } catch {
                print("Failed to fetch recipe details: \(error)")
                DispatchQueue.main.async {
                    self.dataloaded = false
                }
            }
        }
    }
}


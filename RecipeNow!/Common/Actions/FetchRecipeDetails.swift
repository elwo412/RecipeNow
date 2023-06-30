//
//  FetchRecipeDetails.swift
//  RecipeNow!
//
//  Created by Thomas Worrall on 6/29/23.
//

import Foundation

func fetchRecipeDetails(recipeID: Int) async throws -> RecipeDetail {
    let url = URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=\(recipeID)")!
    
    let (data, _) = try await URLSession.shared.data(from: url)
        
    let decoder = JSONDecoder()
    let response = try decoder.decode(RecipeDetailResponse.self, from: data)
    
    guard let recipeDetail = response.meals.first else {
        throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid data format"])
    }
    
    return recipeDetail
}

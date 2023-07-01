//
//  FetchRecipes.swift
//  RecipeNow!
//
//  Created by Thomas Worrall on 6/27/23.
//

import Foundation

func fetchRecipes(foodType: String) async throws -> [Recipe] {
    let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=\(foodType)")! //for now 
    
    let (data, _) = try await URLSession.shared.data(from: url)
    
    let decoder = JSONDecoder()
    let response = try decoder.decode([String: [Recipe]].self, from: data)
    
    guard let recipes = response["meals"] else {
        throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid data format"])
    }
    
    return recipes
}

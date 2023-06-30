//
//  RecipeRelated.swift
//  RecipeNow!
//
//  Created by Thomas Worrall on 6/27/23.
//

import Foundation

struct RecipeBook {
    var categories: [RecipeCategory]
    
    init() {
        let dessertCategory = RecipeCategory(title: "Desserts", imageName: "photo", desc: "goodness", recipes: [])
        let entreeCategory = RecipeCategory(title: "Entrées", imageName: "photo", desc: "please don't click", recipes: [])
        let customCategory = RecipeCategory(title: "My Recipes", imageName: "photo", desc: "don't click, seriously", recipes: [])

        categories = [dessertCategory, entreeCategory, customCategory]
    }
}

struct RecipeCategory: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
    let desc: String
    
    var recipes: [Recipe]
}

struct Recipe: Identifiable, Codable {
    let id = UUID()
    let idMeal: String
    let strMeal: String
    let strMealThumb: String

    enum CodingKeys: String, CodingKey {
        case idMeal = "idMeal"
        case strMeal = "strMeal"
        case strMealThumb = "strMealThumb"
    }
    
    var mealdb_id: Int {
        return Int(idMeal) ?? 0
    }

    var title: String {
        return strMeal
    }

    var imageURL: String {
        return strMealThumb
    }
}

struct RecipeDetailResponse: Decodable {
    let meals: [RecipeDetail]
}

struct RecipeDetail: Decodable, Identifiable {
    let idMeal: String
    let strMeal: String
    let strDrinkAlternate: String?
    let strCategory: String
    let strArea: String
    let strInstructions: String
    let strMealThumb: String
    let strTags: String?
    let strYoutube: String?
    let strSource: String?
    let strIngredients: [String?]
    let strMeasures: [String?]

    enum CodingKeys: String, CodingKey {
        case idMeal
        case strMeal
        case strDrinkAlternate
        case strCategory
        case strArea
        case strInstructions
        case strMealThumb
        case strTags
        case strYoutube
        case strSource
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5, strIngredient6, strIngredient7, strIngredient8, strIngredient9, strIngredient10
        case strIngredient11, strIngredient12, strIngredient13, strIngredient14, strIngredient15, strIngredient16, strIngredient17, strIngredient18, strIngredient19, strIngredient20
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5, strMeasure6, strMeasure7, strMeasure8, strMeasure9, strMeasure10
        case strMeasure11, strMeasure12, strMeasure13, strMeasure14, strMeasure15, strMeasure16, strMeasure17, strMeasure18, strMeasure19, strMeasure20
    }

    var id: String { idMeal }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        idMeal = try values.decode(String.self, forKey: .idMeal)
        strMeal = try values.decode(String.self, forKey: .strMeal)
        strDrinkAlternate = try values.decode(String?.self, forKey: .strDrinkAlternate)
        strCategory = try values.decode(String.self, forKey: .strCategory)
        strArea = try values.decode(String.self, forKey: .strArea)
        strInstructions = try values.decode(String.self, forKey: .strInstructions)
        strMealThumb = try values.decode(String.self, forKey: .strMealThumb)
        strTags = try values.decode(String?.self, forKey: .strTags)
        strYoutube = try values.decode(String?.self, forKey: .strYoutube)
        strSource = try values.decode(String?.self, forKey: .strSource)

        strIngredients = [
            try values.decode(String?.self, forKey: .strIngredient1),
            try values.decode(String?.self, forKey: .strIngredient2),
            try values.decode(String?.self, forKey: .strIngredient3),
            try values.decode(String?.self, forKey: .strIngredient4),
            try values.decode(String?.self, forKey: .strIngredient5),
            try values.decode(String?.self, forKey: .strIngredient6),
            try values.decode(String?.self, forKey: .strIngredient7),
            try values.decode(String?.self, forKey: .strIngredient8),
            try values.decode(String?.self, forKey: .strIngredient9),
            try values.decode(String?.self, forKey: .strIngredient10),
            try values.decode(String?.self, forKey: .strIngredient11),
            try values.decode(String?.self, forKey: .strIngredient12),
            try values.decode(String?.self, forKey: .strIngredient13),
            try values.decode(String?.self, forKey: .strIngredient14),
            try values.decode(String?.self, forKey: .strIngredient15),
            try values.decode(String?.self, forKey: .strIngredient16),
            try values.decode(String?.self, forKey: .strIngredient17),
            try values.decode(String?.self, forKey: .strIngredient18),
            try values.decode(String?.self, forKey: .strIngredient19),
            try values.decode(String?.self, forKey: .strIngredient20),
        ]

        strMeasures = [
            try values.decode(String?.self, forKey: .strMeasure1),
            try values.decode(String?.self, forKey: .strMeasure2),
            try values.decode(String?.self, forKey: .strMeasure3),
            try values.decode(String?.self, forKey: .strMeasure4),
            try values.decode(String?.self, forKey: .strMeasure5),
            try values.decode(String?.self, forKey: .strMeasure6),
            try values.decode(String?.self, forKey: .strMeasure7),
            try values.decode(String?.self, forKey: .strMeasure8),
            try values.decode(String?.self, forKey: .strMeasure9),
            try values.decode(String?.self, forKey: .strMeasure10),
            try values.decode(String?.self, forKey: .strMeasure11),
            try values.decode(String?.self, forKey: .strMeasure12),
            try values.decode(String?.self, forKey: .strMeasure13),
            try values.decode(String?.self, forKey: .strMeasure14),
            try values.decode(String?.self, forKey: .strMeasure15),
            try values.decode(String?.self, forKey: .strMeasure16),
            try values.decode(String?.self, forKey: .strMeasure17),
            try values.decode(String?.self, forKey: .strMeasure18),
            try values.decode(String?.self, forKey: .strMeasure19),
            try values.decode(String?.self, forKey: .strMeasure20),
        ]
    }
}

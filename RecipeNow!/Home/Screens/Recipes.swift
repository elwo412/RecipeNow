//
//  Recipes.swift
//  RecipeNow!
//
//  Created by Thomas Worrall on 6/27/23.
//

import Foundation
import SwiftUI

struct RecipesScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var recipesVM = RecipesViewModel()
    @State var recipeCategory: RecipeCategory
    
    @State public var selectedRecipe: Recipe?
    @State public var isExpandAllowed = true
    
    var body: some View {
        TopActionBar(title: recipeCategory.title){
            VStack {
                ScrollView {
                    LazyVGrid(columns: recipesVM.gridItems) {
                        ForEach(recipeCategory.recipes) { recipe in
                            RecipeCardView(recipe: recipe, selectedRecipe: $selectedRecipe, isEA: $isExpandAllowed)
                        }
                    }
                    .padding(.top, 75)
                }
                .sheet(item: $selectedRecipe, onDismiss: didDismiss) { recipe in
                    RecipeDetails(recipeDetailsVM: RecipeDetailsViewModel(recipe: recipe))
                        .padding(.top, 25)
                        .presentationDetents([.fraction(0.4), .fraction(1)])
                } 
                .padding(.top, 50)
                .padding(.horizontal)
            }
        }
        .onAppear() {
            Task {
                do {
                    let recipes = try await fetchRecipes(foodType: recipeCategory.title)
                    withAnimation(.easeIn){
                        recipeCategory.recipes = recipes
                    }
                } catch {
                    print("Failed to fetch recipes: \(error)")
                }

            }
        }
    }
    func didDismiss() {
        // Handle the dismissing action.
        print("Dismissing Sheet")
        self.isExpandAllowed = true
    }
}

struct Recipes_Preview: PreviewProvider {
    static var previews: some View {
        let testrec = Recipe(idMeal: "0", strMeal: "Apple & Blackberry Crumble", strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")
        let testrec2 = Recipe(idMeal: "1", strMeal: "Cake", strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")
        let testrec3 = Recipe(idMeal: "2", strMeal: "Christmas Pudding Trifle", strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")
        let testCat = RecipeCategory(title: "Test", imageName: "photo", desc: "test", recipes: [testrec, testrec2, testrec3])
        RecipesScreen(recipeCategory: testCat)
    }
}

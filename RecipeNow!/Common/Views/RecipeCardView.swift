//
//  RecipeCardView.swift
//  RecipeNow!
//
//  Created by Thomas Worrall on 6/27/23.
//

import Foundation
import SwiftUI


struct RecipeCardView: View {
    var recipe: Recipe
    
    @Binding var selectedRecipe: Recipe?
    @Binding var isEA: Bool
    
    var body: some View {
        Button(action: {
            if (isEA) {
                print("Button Pressed")
                self.selectedRecipe = recipe
                isEA = false
            }
        }){
            ZStack {
                RemoteImage(url: URL(string: recipe.imageURL)!)
                    .overlay {
                        Rectangle()
                            .background(Color.black)
                            .opacity(0.2)
                    }
                
                Text(recipe.title)
                    .font(.title2)
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.leading)
                    .bold()
            }
        }
        .frame(maxWidth: .infinity, minHeight: 150)
        .background(Color(hex: "#F2F2F6"))
        .cornerRadius(10)
        .buttonStyle(.plain)
    }
}

struct RecipeCard_Preview: PreviewProvider {
    static var previews: some View {
        let testrec = Recipe(idMeal: "0", strMeal: "Apple & Blackberry Crumble", strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")
        let selectedRecipe = testrec
        RecipeCardView(recipe: testrec, selectedRecipe: .constant(selectedRecipe), isEA: .constant(true))
    }
}

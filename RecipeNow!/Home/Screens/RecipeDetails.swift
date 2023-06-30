//
//  RecipeDetails.swift
//  RecipeNow!
//
//  Created by Thomas Worrall on 6/29/23.
//

import Foundation
import SwiftUI
import YouTubePlayerKit

struct RecipeDetails: View {
    
    @StateObject var recipeDetailsVM: RecipeDetailsViewModel
    
    var body: some View {
        VStack {
            HStack {
                RemoteImage(url: URL(string: recipeDetailsVM.recipeDetails?.strMealThumb ?? recipeDetailsVM.recipe.imageURL)!)
                    .frame(minWidth: 100, maxWidth: 100, minHeight: 100)
                    .cornerRadius(10)
                    .padding(.top, 25)
                VStack (spacing: 0) {
                    Text(recipeDetailsVM.recipe.title)
                        .font(.system(size: 24))
                        .padding(.top, 25)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                        .bold()
                    
                    HStack {
                        BadgeContainerView(maxWidth: 225, badgesString: recipeDetailsVM.recipeDetails?.strTags ?? "")
                    }
                    .padding(.top, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 25)
            .frame(maxHeight: 125)
            
            ScrollView {
                if let origin = recipeDetailsVM.recipeDetails?.strArea {
                    Text("Origin")
                        .font(.system(size: 18, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 25)
                        .padding(.top, 5)
                    Text(recipeDetailsVM.dataloaded ? origin : "")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .padding(.horizontal, 25)
                }
                
                Text("Preperations")
                    .font(.system(size: 18, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 25)
                    .padding(.vertical, 5)
                
                ForEach(recipeDetailsVM.recipeDetails?.strIngredients.indices ?? 0..<0, id: \.self) { index in
                    if let ingredient = recipeDetailsVM.recipeDetails?.strIngredients[index] {
                        if ingredient != "" {
                            if let measure = recipeDetailsVM.recipeDetails?.strMeasures[index] {
                                HStack(spacing: 0) {
                                    Text("    • ")
                                    Text(" \(measure) ")
                                        .font(.system(size: 14, weight: .semibold))
                                    Text(ingredient)
                                }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal, 25)
                            } else {
                                Text("    • \(ingredient)")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal, 25)
                            }
                        }
                    }
                }
                
                
                Text("Instructions")
                    .font(.system(size: 25, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 25)
                    .padding(.vertical, 5)
                
                Text(recipeDetailsVM.dataloaded ? recipeDetailsVM.recipeDetails?.strInstructions ?? "" : "")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 25)
                    .padding(.top, 5)
                
                
                if let youtubeURL = recipeDetailsVM.recipeDetails?.strYoutube {
                    
                    Text("Video")
                        .font(.system(size: 25, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 25)
                        .padding(.vertical, 5)
                    
                    
                    let youTubePlayer = YouTubePlayer(
                        source: .url(youtubeURL)
                    )
                    
                    HStack {
                        YouTubePlayerView(youTubePlayer) { state in
                            // Overlay ViewBuilder closure to place an overlay View
                            // for the current `YouTubePlayer.State`
                            switch state {
                            case .idle:
                                ProgressView()
                            case .ready:
                                EmptyView()
                            case .error(_):
                                Text(verbatim: "YouTube player couldn't be loaded")
                            }
                        }
                        .cornerRadius(20)
                    }
                    .padding(.horizontal, 25)
                    .frame(maxWidth: .infinity, minHeight: 250)
                }
            }
            
            Spacer()
                
        }
        .frame(maxWidth: .infinity)
        .onAppear() {
            recipeDetailsVM.fetchDetails()
        }
    }
}

struct RecipeDetails_Preview: PreviewProvider {
    static var previews: some View {
        let testrec = Recipe(idMeal: "52923", strMeal: "Apple", strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")
        let testrec2 = Recipe(idMeal: "1", strMeal: "Cake", strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")
        let testrec3 = Recipe(idMeal: "2", strMeal: "Christmas Pudding Trifle", strMealThumb: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")
        let testCat = RecipeCategory(title: "Test", imageName: "photo", desc: "test", recipes: [testrec, testrec2, testrec3])
        RecipesScreen(recipeCategory: testCat)
            .sheet(item: .constant(testrec)) { recipe in
                RecipeDetails(recipeDetailsVM: RecipeDetailsViewModel(recipe: recipe))
                    .padding(.top, 25)
                    .presentationDetents([.fraction(0.4), .fraction(1)])
            }
            
    }
}

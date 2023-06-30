//
//  CategoryCardView.swift
//  RecipeNow!
//
//  Created by Thomas Worrall on 6/27/23.
//

import Foundation
import SwiftUI

struct CatagoryCardView: View {
    var recipeCategory: RecipeCategory
    
    var body: some View {
        NavigationLink(destination: RecipesScreen(recipeCategory: recipeCategory)) {
            HStack {
                Image(systemName: recipeCategory.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 75, height: 75)
                    .foregroundColor(.gray)
                    .padding(.leading, 15)
                    .padding(.vertical, 15)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(recipeCategory.title)
                        .font(.title2)
                        .foregroundColor(.primary)
                    
                    Text(recipeCategory.desc)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.leading, 10)
                .padding(.vertical, 15)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(hex: "#F2F2F6"))
            .cornerRadius(10)
            .padding(.vertical, 5)
            .padding(.horizontal, 30)
            .shadow(color: Color.gray.opacity(0.4), radius: 4, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

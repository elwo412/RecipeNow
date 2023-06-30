//
//  Home.swift
//  RecipeNow!
//
//  Created by Thomas Worrall on 6/27/23.
//

import Foundation

import SwiftUI

struct Home: View {
    
    @StateObject private var homeVM = HomeViewModel()
    
    var body: some View {
        TopActionBar(title: "Recipe Book"){
            VStack {
                ScrollView {
                    Spacer(minLength: 175)
                    ForEach(homeVM.recipeBook.categories) { category in
                        CatagoryCardView(recipeCategory: category)
                    }
                }
            }
            .background(Color(hex: "#F5F5FA"))
            .ignoresSafeArea()
        }
        
    }
}


struct Home_Preview: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

//
//  RecipeNow_App.swift
//  RecipeNow!
//
//  Created by Thomas Worrall on 6/27/23.
//

import SwiftUI

@main
struct RecipeNow_App: App {
    var body: some Scene {
        WindowGroup {
            Home()
                .preferredColorScheme(.light)
        }
    }
}

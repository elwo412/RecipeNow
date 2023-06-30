//
//  TopActionBar.swift
//  RecipeNow!
//
//  Created by Thomas Worrall on 6/27/23.
//

import Foundation
import SwiftUI

struct TopActionBar<Content>: View where Content: View {
    @Environment(\.presentationMode) var presentationMode
    var title: String
    let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                content
                
                VStack {
                    HStack (spacing: 0) {
                        if self.presentationMode.wrappedValue.isPresented {
                            Button(action: {
                                self.presentationMode.wrappedValue.dismiss()
                            }) {
                                Image(systemName: "chevron.left")
                                    .imageScale(.large)
                                    .padding(.leading, 15)
                                    .foregroundColor(Color(hex: "#4F5D75"))
                            }
                        }
                        
                        Text(title)
                            .font(.title)
                            .bold()
                            .padding(.leading, self.presentationMode.wrappedValue.isPresented ? 10 : 25)
                        
                        Spacer()
                        
                        Button(action: {
                        }) {
                            Image(systemName: "ellipsis")
                                .imageScale(.large)
                                .rotationEffect(.degrees(90))
                                .padding(.trailing, 16)
                                .foregroundColor(Color(hex: "#4F5D75"))
                        }
                    }
                    .padding(.top, 50)
                    .frame(maxWidth: .infinity, minHeight: 150, alignment: .leading)
                    .background(Color(hex: "#F2F2F6"))
                    .cornerRadius(25)
                    .shadow(color: Color.gray.opacity(0.2), radius: 4, x: 0, y: 4)
                    .edgesIgnoringSafeArea(.top)
                    Spacer()
                }
            }
            .navigationBarHidden(true)
            
        }
        .navigationBarBackButtonHidden(true)
    }
}



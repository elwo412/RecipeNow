//
//  RemoteImage.swift
//  RecipeNow!
//
//  Created by Thomas Worrall on 6/27/23.
//

import SwiftUI
import Foundation
import UIKit

struct RemoteImage: View {
    var url: URL
    
    @StateObject private var imageLoader: ImageLoader
    
    init(url: URL) {
        self.url = url
        self._imageLoader = StateObject(wrappedValue: ImageLoader(url: url))
    }
    
    var body: some View {
        GeometryReader { geometry in
            Group {
                if let image = imageLoader.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width, height: geometry.size.width) // Adjust frame as needed
                } else {
                    Image(systemName: "text.below.photo.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.gray)
                        .background(Color.white)
                        .opacity(imageLoader.isLoading ? 0.4 : 0.8)
                        .onAppear {
                            withAnimation(Animation.easeInOut(duration: 1.0).repeatForever()) {
                                imageLoader.isLoading = true
                            }
                            imageLoader.load()
                        }
                        .frame(width: geometry.size.width, height: geometry.size.width) // Adjust frame as needed
                }
            }
        }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    @Published var isLoading = false
    
    private let url: URL
    
    private static var cache = NSCache<NSURL, UIImage>()
    private var loadingURL: NSURL?
    
    init(url: URL) {
        self.url = url
    }
    
    func load() {
        guard isLoading else { return }
        
        let nsUrl = url as NSURL
        
        if let cachedImage = ImageLoader.cache.object(forKey: nsUrl) {
            image = cachedImage
            return
        }
        
        isLoading = true
        loadingURL = nsUrl
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                guard let data = data, let loadedImage = UIImage(data: data) else {
                    self.isLoading = false
                    return
                }
                
                ImageLoader.cache.setObject(loadedImage, forKey: nsUrl)
                
                if self.loadingURL == nsUrl {
                    withAnimation(.easeIn){
                        self.image = loadedImage
                    }                    
                }
                
                self.isLoading = false
            }
        }.resume()
    }
}


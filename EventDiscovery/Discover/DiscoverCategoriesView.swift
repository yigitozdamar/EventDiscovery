//
//  DiscoverCategoriesView.swift
//  EventDiscovery
//
//  Created by Yigit Ozdamar on 13.04.2023.
//

import SwiftUI

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}

struct DiscoverCategoriesView: View {
    
    let categories: [Category] = [
        .init(name: "Art", imageName: "paintpalette.fill"),
        .init(name: "Sports", imageName: "sportscourt.fill"),
        .init(name: "Live Events", imageName: "music.mic"),
        .init(name: "Food", imageName: "music.mic"),
        .init(name: "History", imageName: "music.mic"),
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing:16) {
                ForEach(categories, id: \.self) { category in
                    NavigationLink {
                        
                        NavigationLazyView(CategoryDetailsView(name: category.name))
                        
                    } label: {
                        VStack(spacing:4) {
                            Image(systemName: category.imageName)
                                .font(.system(size: 20))
                                .foregroundColor(Color.orange)
                                .frame(width: 68, height: 68)
                                .background(Color.white)
                                .cornerRadius(.infinity)
                                .shadow(color: .gray, radius: 4, x: 0, y: 2)
                            Text(category.name)
                                .font(.system(size: 12, weight: .semibold))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                        }
                        .frame(width:68)
                    }

                }
            }
            .padding(.horizontal)
        }
    }
}

struct DiscoverCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DiscoverCategoriesView()
        }
    }
}

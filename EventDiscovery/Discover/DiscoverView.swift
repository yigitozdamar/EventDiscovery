//
//  ContentView.swift
//  EventDiscovery
//
//  Created by Yigit Ozdamar on 8.04.2023.
//

import SwiftUI

struct DiscoverView: View {
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
    }
    
    var body: some View {
        NavigationView {
            
            ZStack{
                
                LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                Color(.init(white: 0.95, alpha: 1))
                    .offset(y: 400)
                
                ScrollView{
                    
                    HStack{
                        Image(systemName: "magnifyingglass")
                        Text("Where do you want to go?")
                        Spacer()
                    }
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(.init(white:1, alpha: 0.3)))
                    .cornerRadius(10)
                    .padding(16)
                    
                    DiscoverCategoriesView()
                    
                    VStack{
                        
                        PopularDestinationsView()
                        
                        PopularRestaurantsView()
                        
                        TrendingCreatorsView()
                    }
                    .background(Color.white)
                    .cornerRadius(16)
                    .padding(.top,32)
                    
                    
                    
                }
            }
            .navigationTitle("Discover")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}

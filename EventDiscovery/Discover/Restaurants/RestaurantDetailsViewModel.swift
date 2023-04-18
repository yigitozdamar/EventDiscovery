//
//  RestaurantDetailsViewModel.swift
//  EventDiscovery
//
//  Created by Yigit Ozdamar on 17.04.2023.
//

import Foundation
import Kingfisher

struct RestaurantDetails: Codable {
    let description: String
    let popularDishes: [Dish]
    let photos: [String]
    let reviews: [Review]
}

struct Review: Codable, Hashable {
    let user: ReviewUser
    let rating: Int
    let text: String
}

struct ReviewUser: Codable, Hashable {
    let id: Int
    let username, firstName, lastName, profileImage: String
}

struct Dish: Codable, Hashable {
    let name, price, photo: String
    let numPhotos: Int
}

class RestaurantDetailsViewModel: ObservableObject {
    
    @Published var isLoading = true
    @Published var details: RestaurantDetails?
    
    init(){
        let urlString = "https://travel.letsbuildthatapp.com/travel_discovery/restaurant?id=0"
        
        guard let url = URL(string: urlString) else { return  }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data else { return }
            
            DispatchQueue.main.async {
                
                self.details = try? JSONDecoder().decode(RestaurantDetails.self, from: data)
            }
            
        }.resume()
    }
    
}

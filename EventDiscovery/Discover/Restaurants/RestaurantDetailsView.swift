//
//  RestaurantDetailsView.swift
//  EventDiscovery
//
//  Created by Yigit Ozdamar on 17.04.2023.
//

import SwiftUI
import Kingfisher

struct RestaurantDetails: Codable {
    let description: String
    let popularDishes: [Dish]
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

struct RestaurantDetailsView: View {
    
    @ObservedObject var vm = RestaurantDetailsViewModel()
    let restaurant: Restaurant
    
    var body: some View{
        
        ScrollView{
            ZStack(alignment:.bottomLeading) {
                Image(restaurant.imageName)
                    .resizable()
                    .scaledToFill()
                
                LinearGradient(colors: [.clear,.black], startPoint: .center, endPoint: .bottom)
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(restaurant.name)
                            .foregroundColor(.white)
                        .font(.system(size:18, weight: .bold))
                        
                        HStack {
                            ForEach(0..<5, id: \.self) { num in
                                Image(systemName: "star.fill")
                            }.foregroundColor(.orange)
                        }
                    }
                    
                    Spacer()
                    
                    Text("See more photos")
                        .foregroundColor(.white)
                        .font(.system(size: 14,weight: .regular))
                        .frame(width: 80)
                        .multilineTextAlignment(.trailing)
                }.padding()
               
            }
            
            VStack(alignment: .leading, spacing: 8.0) {
                Text("Location & Description")
                    .font(.system(size: 16,weight: .bold))
                
                Text("Tokyo, Japan")
                
                HStack {
                    ForEach(0..<5, id: \.self) { num in
                        Image(systemName: "dollarsign.circle.fill")
                    }.foregroundColor(.orange)
                }
                
                Text(vm.details?.description ?? "")
                    .padding(.top,8)
                    .font(.system(size: 14,weight: .regular))

            }
            .padding()
            
            HStack {
                Text("Popular Dishes")
                    .font(.system(size: 16,weight: .bold))
                
                Spacer()
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal) {
                HStack(spacing:16) {
                    ForEach(vm.details?.popularDishes ?? [], id: \.self) { dish in
                        VStack(alignment: .leading) {
                            ZStack(alignment: .bottomLeading) {
                                
                                LinearGradient(colors: [.clear,.black], startPoint: .center, endPoint: .bottom)
                                
                                KFImage(URL(string: dish.photo))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 80)
                                    .cornerRadius(5)
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 5).stroke(Color.gray)
                                    }
                                    .shadow(radius: 2)
                                .padding(.vertical,2)
                                
                                Text(dish.price)
                                    .foregroundColor(.white)
                                    .font(.system(size: 14,weight: .bold))
                            }
                            
                            Text(dish.name)
                                .font(.system(size: 14,weight: .bold))

                            Text("\(dish.numPhotos) photos")
                                .foregroundColor(.gray)
                                .font(.system(size: 12,weight: .regular))
                            
                        }
                    }
                }.padding(.horizontal)
                
            }
        }
        .navigationBarTitle("Restaurant Details",displayMode: .inline)
    }
    
    let sampleDishPhotos = [
    "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/e2f3f5d4-5993-4536-9d8d-b505d7986a5c",
    "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/a4d85eff-4c79-4141-a0d6-761cca48eae1",
    "https://letsbuildthatapp-videos.s3.us-west-2.amazonaws.com/0d1d2e79-2f10-4cfd-82da-a1c2ab3638d2"
    ]
}

struct RestaurantDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RestaurantDetailsView(restaurant: .init(name: "Japan's Finest Tapas", imageName: "tapas"))
        }
    }
}

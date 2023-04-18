//
//  TrendingCreatorsView.swift
//  EventDiscovery
//
//  Created by Yigit Ozdamar on 13.04.2023.
//

import SwiftUI

struct TrendingCreatorsView: View {
    
    let users: [User] = [
        .init(id: 0, name: "Amy Adams", imageName: "amy"),
        .init(id: 1, name: "Billy Adams", imageName: "billy"),
        .init(id: 2, name: "Sam Smith", imageName: "sam"),
    ]
    
    var body: some View {
        VStack {
            HStack{
                Text("Trending Creators")
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
                Text("See All")
                    .font(.system(size: 12, weight: .semibold))
            }
            .padding(.horizontal)
            .padding(.top)
            
            ScrollView(.horizontal) {
                HStack(alignment: .top, spacing: 12.0){
                    ForEach(users, id: \.self) { user in
                        NavigationLink {
                            NavigationLazyView(UserDetailsView(user: user))
                        } label: {
                            DiscoverUserView(user: user)
                        }

                        
                    }
                }
                .padding(.horizontal)
            }
            
        }
    }
}

struct DiscoverUserView: View {
    
    let user: User
    
    var body: some View {
        VStack{
            Image(user.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 60, height: 60)
                .clipped()
                .cornerRadius(.infinity)
            
            Text(user.name)
                .font(.system(size: 11, weight: .semibold))
                .multilineTextAlignment(.center)
                .foregroundColor(Color(uiColor: .label))
            
        }
        .frame(width: 60)
        .shadow(color: .gray, radius: 4, x: 0, y: 2)
        .padding(.bottom)
    }
}

struct TrendingCreatorsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TrendingCreatorsView()
        }
    }
}

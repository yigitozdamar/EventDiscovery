//
//  UserDetailsView.swift
//  EventDiscovery
//
//  Created by Yigit Ozdamar on 18.04.2023.
//

import SwiftUI
import Kingfisher

struct UserDetails: Codable {
    let username, firstName, lastName, profileImage: String
    let followers, following: Int
    let posts: [Post]
}

struct Post: Codable, Hashable {
    let title, imageUrl, views: String
    let hashtags: [String]
}

class UserDetailsViewModel: ObservableObject {
    
    @Published var userDetails: UserDetails?
    
    init(userId: Int) {
        guard let url = URL(string: "https://travel.letsbuildthatapp.com/travel_discovery/user?id=\(userId)") else { return }
        
      
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                DispatchQueue.main.async {
                    guard let data = data else { return }
                    
                    do{
                        self.userDetails =  try JSONDecoder().decode(UserDetails.self, from: data)
                        
                    }catch let jsonError{
                        print("Decoding failed for userdetails:", jsonError)
                    }
                }
            }.resume()
             
        
    }
}

struct UserDetailsView: View {
    
    @ObservedObject var vm: UserDetailsViewModel
    
    let user: User
    
    init(user: User) {
        self.user = user
        self.vm = .init(userId: user.id)
    }
    
    var body: some View{
        ScrollView {
            VStack(spacing: 12.0) {
                Image(user.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .padding(.horizontal)
                    .padding(.top)
                
                Text("\(vm.userDetails?.firstName ?? "") \(vm.userDetails?.lastName ?? "")")
                    .font(.system(size: 14,weight: .semibold))
                
                HStack {
                    Text("@\(vm.userDetails?.username ?? "") •")
                    
                    Image(systemName: "hand.thumbsup.fill")
                        .font(.system(size: 10,weight: .semibold))
                    
                    Text("2513")
                }.font(.system(size: 12,weight: .regular))
                
                Text("Youtuber, Vlogger, Travel bitch")
                    .font(.system(size: 14,weight: .regular))
                    .foregroundColor(Color.gray)
                
                HStack(spacing: 12) {
                    VStack {
                        Text("\(vm.userDetails?.followers ?? 0)")
                            .font(.system(size: 13,weight: .semibold))
                        Text("Followers")
                            .font(.system(size: 9,weight: .semibold))
                    }
                    Spacer()
                        .frame(width: 0.5, height: 12)
                        .background(Color(.lightGray))
                    VStack {
                        Text("\(vm.userDetails?.following ?? 0)")
                            .font(.system(size: 13,weight: .semibold))
                        Text("Followers")
                            .font(.system(size: 9,weight: .semibold))
                    }
                }
                
                HStack(spacing:12) {
                    Button {
                        
                    } label: {
                        HStack {
                            Spacer()
                            Text("Follow")
                                .foregroundColor(.white)
                            Spacer()
                        }
                        .padding(.vertical,8)
                        .background(Color.orange)
                        .cornerRadius(100)
                        
                    }
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Spacer()
                            Text("Contact")
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .padding(.vertical,8)
                        .background(Color(uiColor: .systemGray4))
                        .cornerRadius(100)
                        
                    }
                }.font(.system(size: 11,weight: .semibold))
               
                ForEach(vm.userDetails?.posts ?? [], id: \.self) { post in
                    
                    VStack(alignment: .leading) {
                        KFImage(URL(string: post.imageUrl))
                            .resizable()
                            .scaledToFill()
                            .frame(height: 200)
                            .clipped()
                        HStack {
                            Image(user.imageName)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 34)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading) {
                                Text(post.title)
                                    .font(.system(size: 13,weight: .semibold))
                                Text("\(post.views) views")
                                    .font(.system(size: 12,weight: .regular))
                                    .foregroundColor(.gray)
                            }
                            
                           
                        }
                        .padding(.bottom,4)
                        .padding(.horizontal,8)
                        
                        HStack {
                            ForEach(post.hashtags, id: \.self) { hashtag in
                                Text("#\(hashtag)")
                                    .foregroundColor(Color.accentColor)
                                    .font(.system(size: 12,weight: .semibold))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical,4)
                                    .background(Color(white: 0.9, opacity: 0.5))
                                    .cornerRadius(20)
                            }
                        }
                        .padding(.bottom)
                        .padding(.horizontal,2)
                        
                        
                    }
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: .init(white:0.8), radius: 5, x: 0, y: 4)
                }
                
            }
            .padding(.horizontal)
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UserDetailsView(user: .init(id: 0, name: "Amyyy", imageName: "amy"))
        }
    }
}

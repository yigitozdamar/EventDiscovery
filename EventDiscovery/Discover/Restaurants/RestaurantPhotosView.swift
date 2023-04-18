//
//  RestaurantPhotosView.swift
//  EventDiscovery
//
//  Created by Yigit Ozdamar on 18.04.2023.
//

import SwiftUI
import Kingfisher

struct RestaurantPhotosView: View {
    
    @ObservedObject var vm = RestaurantDetailsViewModel()
    @State var mode = "grid"
    @State var showFullScreenModal = false
    @State var selectedPhotoIndex = 0
    
    init() {
        
        UISegmentedControl.appearance().selectedSegmentTintColor = .orange
        UISegmentedControl.appearance().backgroundColor = .black
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }
    
    var body: some View {
        GeometryReader { proxy in
            
            ScrollView {

                //GRID
                Picker("Test", selection: $mode) {
                    Text("Grid")
                        .tag("grid")
                    Text("List")
                        .tag("list")
                }
                .pickerStyle(.segmented)
                .padding()
                
                Spacer()
                    .fullScreenCover(isPresented: $showFullScreenModal) {
                        ZStack(alignment:.topLeading) {
                            Color.black.ignoresSafeArea()
                            if let photos = vm.details?.photos {
                                RestaurantCarouselContainer(imageNames: photos, selectedIndex: selectedPhotoIndex)

                            }
                            
                            Button {
                                showFullScreenModal.toggle()
                            } label: {
                                Image(systemName: "xmark")
                                    .font(.system(size: 24,weight: .bold))
                                    .foregroundColor(.white)
                                    .padding()
                            }

                        }
                    }
                    .opacity(showFullScreenModal ? 1 : 0)
                
                if mode == "grid" {
                    LazyVGrid(columns: [
                        GridItem(.adaptive(minimum: proxy.size.width / 3 - 4, maximum: 300), spacing: 2)
                    ], spacing: 4) {
                        if let photos = vm.details?.photos {
                            ForEach(photos, id: \.self) { photo in
                                
                                Button {
                                    
                                    self.selectedPhotoIndex = photos.firstIndex(of: photo) ?? 0
                                    self.showFullScreenModal.toggle()
                                } label: {
                                    KFImage(URL(string: photo))
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: proxy.size.width / 3 - 3 , height: proxy.size.width / 3 - 3)
                                        .clipped()
                                }
                                
                            }
                        }
                       
                        
                    }
                    .padding(.horizontal,2)
                } else {
                    
                    if let details = vm.details {
                        ForEach(details.photos, id: \.self) { photo in
                            VStack(alignment: .leading, spacing: 8) {
                                KFImage(URL(string: photo))
                                    .resizable()
                                    .scaledToFill()
                                HStack {
                                    Image(systemName: "heart")
                                    Image(systemName: "bubble.right")
                                    Image(systemName: "paperplane")
                                    Spacer()
                                    Image(systemName: "bookmark")
                                }
                                .padding(.horizontal,8)
                                .font(.system(size: 22))
                                Text("Description of the image post and it goes here, make sure to use a bunch of lines of text otherwise you will never know what's going to happen.\n\nGood job fellas...")
                                    .font(.system(size: 14))
                                    .padding(.horizontal,8)
                                
                                Text("Posted on 11/4/23")
                                    .font(.system(size: 14))
                                    .padding(.horizontal,8)
                                    .foregroundColor(.gray)
                                
                            }
                            .padding(.bottom)
                        }
                    }
                    
                   
                }
               
                
            }
            .navigationTitle("All Photos")
        .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct RestaurantPhotosView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RestaurantPhotosView()
        }
    }
}

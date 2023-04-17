//
//  CategoryDetailsView.swift
//  EventDiscovery
//
//  Created by Yigit Ozdamar on 13.04.2023.
//

import SwiftUI
import Kingfisher
import SDWebImageSwiftUI

struct CategoryDetailsView: View {
    
    private let name: String
    @ObservedObject private var vm: CategoryDetailsViewModel
    
    init(name: String) {
        self.name = name
        self.vm = .init(name: name)
    }
    
    var body: some View {
        ZStack{
            if vm.isLoading {
                VStack(spacing: 8.0) {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(.white)
                    Text("Loading")
                        .foregroundColor(.white)
                        .font(.system(size: 16,weight: .semibold))
                    
                }
                .padding()
                .background(Color.gray)
                .cornerRadius(8)
            }else {
                ZStack{
                    if !vm.errorMessage.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "xmark.octagon.fill")
                                .font(.system(size: 64,weight: .semibold))
                                .foregroundColor(.red)
                            Text(vm.errorMessage)
                        }
                        
                    } else {
                        ScrollView {
                            ForEach(vm.places, id: \.self) { place in
                                VStack(alignment: .leading, spacing: 0.0) {
                                    WebImage(url: URL(string: place.thumbnail))
                                        .resizable()
                                        .indicator(.activity)
                                        .transition(.fade(duration: 0.5))
                                        .scaledToFill()
                                    Text(place.name)
                                        .font(.system(size: 12, weight: .semibold))
                                        .padding()
                                    
                                }
                                .asTile()
                                .padding()
                            }
                        }
                    }
                }
               
                
            }
        }
        .navigationTitle(name)
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct CategoryDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CategoryDetailsView(name: "Fod")
        }
    }
}

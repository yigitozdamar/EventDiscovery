//
//  PopularDestinationsView.swift
//  EventDiscovery
//
//  Created by Yigit Ozdamar on 13.04.2023.
//

import SwiftUI
import MapKit

struct PopularDestinationsView: View {
    
    let destinations: [Destination] = [
        .init(name: "Paris", country: "France", imageName: "eiffel_tower",latitude: 48.855014,longitude: 2.341231),
        .init(name: "Tokyo", country: "Japan", imageName: "japan",latitude: 35.67988,longitude: 139.7695),
        .init(name: "New York", country: "USA", imageName: "new_york",latitude: 40.71592,longitude: -74.0055),
    ]
    
    var body: some View {
        VStack {
            HStack{
                Text("Popular Destinations")
                    .font(.system(size: 14, weight: .semibold))
                Spacer()
                Text("See All")
                    .font(.system(size: 12, weight: .semibold))
            }
            .padding(.horizontal)
            .padding(.top)
            
            ScrollView(.horizontal) {
                HStack(spacing: 8.0){
                    ForEach(destinations, id: \.self) { destination in
                        NavigationLink {
                            NavigationLazyView(PopularDestinationDetailsView(destination: destination))
                        } label: {
                            PopularDestinationTile(destination: destination)
                        }

                    }
                }
                .padding(.horizontal)
            }
            
        }
    }
}

struct DestinationDetails: Codable {
    let description: String
    let photos: [String]
    
}

struct PopularDestinationDetailsView: View {
    
    @ObservedObject var vm: DestinationDetailsViewModel
    let destination: Destination
    
    @State var region: MKCoordinateRegion
    @State var isShowingAttractions = true
    
    init(destination: Destination) {
        self.destination = destination
        self._region = State(initialValue: MKCoordinateRegion(center: .init(latitude: destination.latitude, longitude: destination.longitude), span: .init(latitudeDelta: 0.1, longitudeDelta: 0.1)))
        self.vm = .init(name: destination.name)
    }
    
    var body: some View {
        ScrollView {
            if let photos = vm.destinationDetails?.photos {
                DestinationHeaderContainer(imageNames: photos)
                    .frame(height: 350)
            }

            VStack(alignment: .leading) {
                Text(destination.name)
                    .font(.system(size: 18,weight: .bold))
                Text(destination.country)
                HStack{
                    ForEach(0..<5, id: \.self) { num in
                        Image(systemName: "star.fill")
                            .foregroundColor(.orange)
                    }
                }
                .padding(.top,2)
                
                Text(vm.destinationDetails?.description ?? "")
                    .padding(.top,4)
                    .font(.system(size: 14))
                
                HStack{ Spacer() }
            }
            .padding(.horizontal)
            
            HStack {
                Text("Location")
                    .font(.system(size: 14,weight: .bold))

                Spacer()
                
                Button {
                    self.isShowingAttractions.toggle()
                } label: {
                    Text(isShowingAttractions ? "Hide attractions" : "Show Attactions")
                        .font(.system(size: 14,weight: .bold))
                }
                
                Toggle("", isOn: $isShowingAttractions)
                    .labelsHidden()

            }
            .padding(.horizontal)
            
            Map(coordinateRegion: $region, annotationItems: isShowingAttractions ? attractions : []) { attraction in
//                MapMarker(coordinate: .init(latitude: attraction.latitude, longitude: attraction.longitude),tint: .red)
                MapAnnotation(coordinate: .init(latitude: attraction.latitude, longitude: attraction.longitude)) {
                    CustomMapAnnotation(attraction: attraction)
                }
            }.frame(height: 300)
            
            
        }
        .navigationTitle(destination.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    let attractions: [Attraction] = [
        .init(name: "Eiffel Tower", imageName: "eiffel_tower", latitude: 48.858605, longitude: 2.2946),
        .init(name: "Champs-Elysees", imageName: "new_york", latitude: 48.866867, longitude: 2.311780),
        .init(name: "Louvre Museum", imageName: "art2", latitude: 48.860288, longitude: 2.337789)
    ]

}

struct CustomMapAnnotation: View {
    
    let attraction: Attraction
    var body: some View{
        VStack{
            Image(attraction.imageName)
                .resizable()
                .frame(width: 80, height: 60)
                .cornerRadius(4)
                .overlay {
                    RoundedRectangle(cornerRadius: 4, style: .continuous)
                        .stroke(Color(.init(white: 0, alpha: 0.5)))
                }
            Text(attraction.name)
                .font(.system(size: 12, weight: .semibold))
                .padding(.horizontal,6)
                .padding(.vertical,4)
                .background(LinearGradient(colors: [Color.red,Color.blue], startPoint: .leading, endPoint: .trailing))
                .foregroundColor(.white)
//                .border(Color.black)
                .cornerRadius(4)
                .overlay {
                    RoundedRectangle(cornerRadius: 4, style: .continuous)
                        .stroke(Color(.init(white: 0, alpha: 0.5)))
                }
        }
        .shadow(radius: 5)
    }
}

struct Attraction: Identifiable {
    let id = UUID().uuidString
    let name, imageName: String
    let latitude, longitude: Double
}

struct PopularDestinationTile: View {
    
    let destination: Destination
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            
            Image(destination.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: 125, height: 125)
                .cornerRadius(4)
                .padding(.horizontal,6)
                .padding(.vertical, 6)
            
            Text(destination.name)
                .font(.system(size: 12,weight: .semibold))
                .padding(.horizontal,12)
                .foregroundColor(Color(.label))
            
            Text(destination.country)
                .font(.system(size: 12,weight: .semibold))
                .padding(.horizontal,12)
                .padding(.bottom,8)
                .foregroundColor(.gray)
            
        }
        .asTile()
        .padding(.bottom)
    }
}

struct PopularDestinationsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
//            PopularDestinationsView()
            PopularDestinationDetailsView(destination: .init(name: "Paris", country: "France", imageName: "eiffel_tower",latitude: 48.855024,longitude: 2.341221))

        }
        
    }
}

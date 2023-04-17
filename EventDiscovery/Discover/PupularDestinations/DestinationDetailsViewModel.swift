//
//  DestinationDetailsViewModel.swift
//  EventDiscovery
//
//  Created by Yigit Ozdamar on 17.04.2023.
//

import Foundation

class DestinationDetailsViewModel: ObservableObject {
    
    @Published var isLoading = true
    @Published var destinationDetails: DestinationDetails?
    
    init(name: String) {
        //        let name = "paris"
        let fixedUrlString = "https://travel.letsbuildthatapp.com/travel_discovery/destination?name=\(name.lowercased())".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: fixedUrlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                guard let data = data else { return }
                //            print(String(data: data, encoding: .utf8))
                
                do{
                    self.destinationDetails = try JSONDecoder().decode(DestinationDetails.self, from: data)
                    
                }catch {
                    print("Failed to decode JSON", error.localizedDescription)
                }
            }
            
            
        }.resume()
    }
}

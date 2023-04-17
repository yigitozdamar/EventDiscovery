//
//  TileModifier.swift
//  EventDiscovery
//
//  Created by Yigit Ozdamar on 13.04.2023.
//

import SwiftUI

extension View {
    
    func asTile() -> some View {
        modifier(TileModifier())
    }
}

struct TileModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .background(Color.white)
            .cornerRadius(5)
            .shadow(color: .gray, radius: 4, x: 0, y: 2)
    }
}


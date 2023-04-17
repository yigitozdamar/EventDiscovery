//
//  ActivityIndicatorView.swift
//  EventDiscovery
//
//  Created by Yigit Ozdamar on 14.04.2023.
//

import SwiftUI

struct ActivityIndicatorView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.startAnimating()
        aiv.color = .white
        return aiv
    }

    typealias UIViewType = UIActivityIndicatorView

    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {

    }

}

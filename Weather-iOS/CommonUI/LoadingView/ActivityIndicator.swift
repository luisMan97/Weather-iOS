//
//  ActivityIndicator.swift
//  Recipes-iOS
//
//  Created by Jorge Luis Rivera Ladino on 26/01/23.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool

    let style: UIActivityIndicatorView.Style

    init(isAnimating: Binding<Bool> = .constant(true), style: UIActivityIndicatorView.Style = .large) {
        self._isAnimating = isAnimating
        self.style = style
    }

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}

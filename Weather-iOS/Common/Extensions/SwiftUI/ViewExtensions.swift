//
//  ViewExtensions.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 1/02/23.
//

import SwiftUI

extension View {

    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }

}

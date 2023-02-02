//
//  HandleBar.swift
//  Weather-iOS
//
//  Created by Jorge Luis Rivera Ladino on 1/02/23.
//

import SwiftUI

struct HandleBar: View {
    var body: some View {
        Rectangle()
            .frame(width: 40, height: 6)
            .foregroundColor(Color.handlebarGrayColor)
            .cornerRadius(8)
    }
}

struct HandleBar_Previews: PreviewProvider {
    static var previews: some View {
        HandleBar()
    }
}

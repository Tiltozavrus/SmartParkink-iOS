//
//  LocationImage.swift
//  SmartParking
//
//  Created by Даня Демин on 29.11.2021.
//

import SwiftUI

struct LocationImage: View {
    @State var circleColor: Color = .blue
    
    var body: some View {
        VStack(spacing: 0) {
            Image("location")
                .renderingMode(.template)
                .foregroundColor(.SPBlue)
            
            Circle()
                .frame(width: 10, height: 10)
                .foregroundColor(circleColor)
        }
    }
}

struct LocationImage_Previews: PreviewProvider {
    static var previews: some View {
        LocationImage()
    }
}

//
//  LoadingView.swift
//  SmartParking
//
//  Created by Даня Демин on 21.11.2021.
//

import SwiftUI

struct LoadingView: View {
    
    var withAnimation: Bool
    
    init(withAnimation: Bool = true) {
        self.withAnimation = withAnimation
    }
    
    var body: some View {
        VStack {
            Spacer()
            Image("parking-1")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200, alignment: .center)
            Text("SmartPark")
                .font(.system(size: 30))
            LoadingLine(withAnimation: self.withAnimation)
                .scaledToFit()
            Spacer()
            
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(withAnimation: false)
    }
}

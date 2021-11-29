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

struct LoadingWrapper<Content>: View where Content: View {
    @Binding var isLoading: Bool
    
    var content: () -> Content
    
    var body: some View {
        GeometryReader {
            geom in
            ZStack(alignment: .center) {
                self.content()
                    .zIndex(-1)
                    .position(x: geom.frame(in: .local).midX, y: geom.frame(in: .local).midY)
                
                if isLoading {
                    // TODO add color scheme base on theme
                    Color.white.zIndex(1)
                    LoadingView()
                        .zIndex(2)
                        .position(x: geom.frame(in: .local).midX, y: geom.frame(in: .local).midY)
                }
            }
        }

    }
    
}

struct LoadingView_Previews: PreviewProvider {
    @State static var isLoading = false;
    @State static var text = "Hello"
    static var previews: some View {
        LoadingWrapper(isLoading: $isLoading) {
            Color.red
        }
    }
}

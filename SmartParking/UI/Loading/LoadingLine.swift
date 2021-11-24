//
//  LoadingLine.swift
//  SmartParking
//
//  Created by Даня Демин on 21.11.2021.
//

import SwiftUI

struct LoadingLine: View {
    @State private var scaleFirst: CGFloat = 0.5
    @State private var scaleSecond: CGFloat = 0.5
    @State private var scaleThird: CGFloat = 0.5
    
    private var withAnimation = true
    
    init(withAnimation: Bool = true) {
        self.withAnimation = withAnimation
    }
    
    var body: some View {
        HStack {
            if withAnimation {
                Circle()
                    .scaledToFit()
                    .foregroundColor(Color(red: 0.63, green: 0, blue: 0))
                    .scaleEffect(scaleFirst)
                    .animation(
                        Animation.easeInOut(duration: 0.6)
                            .repeatForever(), value: scaleFirst
                    )
                    .onAppear{
                        self.scaleFirst = 0.9
                    }
                Circle()
                    .scaledToFit()
                    .foregroundColor(.init(red: 0, green: 0, blue: 0.7))
                    .scaleEffect(scaleSecond)
                    .animation(
                        Animation.easeInOut(duration: 0.6)
                            .repeatForever().delay(0.3), value: scaleSecond
                    )
                    .onAppear{
                        self.scaleSecond = 0.9
                    }
                Circle()
                    .scaledToFit()
                    .foregroundColor(.init(red: 0, green: 0.55, blue: 0))
                    .scaleEffect(scaleThird)
                    .animation(
                        Animation.easeInOut(duration: 0.6)
                            .repeatForever().delay(0.6), value: scaleThird
                    )
                    .onAppear{
                        self.scaleThird = 0.9
                    }
            } else {
                Circle()
                    .scaledToFit()
                    .foregroundColor(Color(red: 0.63, green: 0, blue: 0))
                    .scaleEffect(scaleFirst)
                    .onAppear{
                        self.scaleFirst = 0.9
                    }
                Circle()
                    .scaledToFit()
                    .foregroundColor(.init(red: 0, green: 0, blue: 0.7))
                    .scaleEffect(scaleSecond)
                    .onAppear{
                        self.scaleSecond = 0.9
                    }
                Circle()
                    .scaledToFit()
                    .foregroundColor(.init(red: 0, green: 0.55, blue: 0))
                    .scaleEffect(scaleThird)
                    .onAppear{
                        self.scaleThird = 0.9
                    }
            }
        }
    }
}

struct LoadingLine_Previews: PreviewProvider {
    static var previews: some View {
        LoadingLine(withAnimation: true)
    }
}

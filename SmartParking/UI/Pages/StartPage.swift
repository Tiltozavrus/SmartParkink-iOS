//
//  StartPage.swift
//  SmartParking
//
//  Created by Даня Демин on 22.11.2021.
//

import SwiftUI

struct StartPage: View {
    var body: some View {
        NavigationView {
            VStack {
                LoadingView(withAnimation: false)
                HStack {
                    Button(
                        action: {
                        
                        }, label: {
                            Text("Авторизация")
                                .padding()
                                .frame(minWidth: 100, idealWidth: 200, maxWidth: .infinity)
                                .foregroundColor(.SPBlue)
                                .font(Font.headline.weight(.bold))
                                .background(Color.white)
                                .cornerRadius(6)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.SPBlue, lineWidth: 4)
                                )
                        }
                    )
                    
                    Button(
                        action: {
                        
                        }, label: {
                            Text("Регистрация")
                                .padding()
                                .frame(minWidth: 100, idealWidth: 200, maxWidth: .infinity)
                                .foregroundColor(.white)
                                .font(Font.headline.weight(.bold))
                                .background(Color.SPBlue)
                                .cornerRadius(6)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color.SPBlue, lineWidth: 4)
                                )
                                
                            
                        }
                    )
                    
                }
            }.padding()
        }
    }
}

struct StartPage_Previews: PreviewProvider {
    static var previews: some View {
        StartPage()
    }
}

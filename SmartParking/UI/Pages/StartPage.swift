//
//  StartPage.swift
//  SmartParking
//
//  Created by Даня Демин on 22.11.2021.
//

import SwiftUI

struct StartPage: View {
    @ObservedObject var authObserver = AuthObserved()
    
    var body: some View {
        if authObserver.isLogin {
            Text("Login")
        } else {
            LoadingWrapper(isLoading: $authObserver.isLoading) {
                NotLoginView().environmentObject(authObserver)
            }
        }
    }
}

struct NotLoginView: View {
    @EnvironmentObject var authObserver: AuthObserved
    
    var body: some View {
            NavigationView {
               
                    VStack {
                        LoadingView(withAnimation: false)
                        
                        Spacer(minLength: 120)
                        HStack {
                            NavigationLink(
                                destination: SignInView()
                                    .navigationViewStyle(StackNavigationViewStyle())
                                    .environmentObject(authObserver),
                                label: {
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
                                })
                            
                            NavigationLink(
                                destination: RegestationView()
                                    .navigationViewStyle(StackNavigationViewStyle())
                                    .environmentObject(authObserver)
                                    ,
                                label: {
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
                                })
                            
                        }
                    }
                    .navigationBarTitle("Назад")
                    .navigationBarHidden(true)
                    .padding()
            }.navigationViewStyle(StackNavigationViewStyle())
                
    }
}

struct StartPage_Previews: PreviewProvider {
    static var previews: some View {
        StartPage()
    }
}

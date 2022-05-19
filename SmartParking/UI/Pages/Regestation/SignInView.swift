//
//  SignInView.swift
//  SmartParking
//
//  Created by Даня Демин on 28.11.2021.
//

import SwiftUI

struct SignInView: View, Header {
    @State var isConfirmView = false
    @EnvironmentObject var authObserved: AuthObserved
    
    var header: some View {
        Text("Вход")
            .padding()
            .font(.custom("Comfortaa-VariableFont_wght", size: 40))
            .foregroundColor(.SPBlue)
    }
    
    var body: some View {
        VStack {
            HStack {
                header
                Spacer()
            }
            VStack(spacing: 15) {
                PhoneNumberView(phoneNubmer: $authObserved.phoneNumber)
                    .padding()
                    .clipShape(Rectangle())
                    .border(Color.SPBlue, width: 3)
                Button(
                    action: {
                        if authObserved.getCode() {
                            isConfirmView.toggle()
                        }
                    },
                    label: {
                        Text("Войти")
                        .padding()
                        .foregroundColor(.white)
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
                
                NavigationLink(
                    "",
                    destination: ConfirmView(header: self, btnText: "Войти")
                        .environmentObject(authObserved),
                    isActive: $isConfirmView
                )
                
                Spacer()
            }.padding()
            
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SignInView()
                .environmentObject(AuthObserved())
                .navigationBarTitle("Вход")
                .navigationBarHidden(true)
        }
    }
}

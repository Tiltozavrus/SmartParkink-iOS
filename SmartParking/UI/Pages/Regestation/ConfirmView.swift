//
//  ConfirmView.swift
//  SmartParking
//
//  Created by Даня Демин on 27.11.2021.
//

import SwiftUI

protocol Header {
    associatedtype HeaderBody: View
    var header: HeaderBody {get}
}

class TextFieldInputChecker: ObservableObject {
    var limit: Int = 4
    
    @Published var text: String = "" {
        didSet {
            if text.count > limit {
                text = String(text.prefix(limit))
            }
        }
    }
}

struct ConfirmView<ConfirmHeader: Header>: View {
    @EnvironmentObject var authObservable: AuthObserved
    @ObservedObject private var codeChecker = TextFieldInputChecker()
    
    let header: ConfirmHeader
    var btnText: String
    
    var body: some View {
        VStack {
            HStack {
                header.header
                Spacer()
            }
            VStack {
                TextField("Код подтверждения", text: $codeChecker.text)
                    .foregroundColor(Color.SPBlue)
                    .padding()
                    .clipShape(Rectangle())
                    .border(Color.SPBlue, width: 3)
                    .keyboardType(.numberPad)
                
                Button(
                    action: {
                        authObservable.verifyCode(code: codeChecker.text)
                    }, label: {
                        Text(btnText)
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
            }.padding()
            Spacer()
        }
    }
}

struct ConfirmView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmView(header: RegestationView(), btnText: "Регистрация")
            .environmentObject(AuthObserved())
    }
}

struct ConfirmHeader_Preview: Header {
    var header: some View {
        Text("Header")
            .padding()
    }
}

//
//  RegestationView.swift
//  SmartParking
//
//  Created by Даня Демин on 22.11.2021.
//

import SwiftUI

struct PhoneTextFieldView: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String

    func makeUIView(context: UIViewRepresentableContext<PhoneTextFieldView>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.textColor = UIColor(Color.SPBlue)
        textField.delegate = context.coordinator
        textField.placeholder = placeholder
        return textField
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<PhoneTextFieldView>) {
        uiView.text = text
        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        uiView.setContentCompressionResistancePriority(.required, for: .vertical)
    }

    func makeCoordinator() -> PhoneTextFieldView.Coordinator {
       Coordinator(parent: self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: PhoneTextFieldView

        init(parent: PhoneTextFieldView) {
           self.parent = parent
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
           parent.text = textField.text ?? ""
        }

        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            guard let text = textField.text else {return false}
            
            let currentText = textField.text ?? ""
            let replacementText = (currentText as NSString).replacingCharacters(in: range, with: string)
            textField.text = phoneNumberToFormat(phone: replacementText)
            return false
        }

        func phoneNumberToFormat(phone: String) -> String {
            let mask = "(xxx) xxx - xx - xx"
            
            let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
                var result = ""
                var index = numbers.startIndex // numbers iterator

                // iterate over the mask characters until the iterator of numbers ends
                for ch in mask where index < numbers.endIndex {
                    if ch == "x" {
                        // mask requires a number in this place, so take the next one
                        result.append(numbers[index])

                        // move numbers iterator to the next index
                        index = numbers.index(after: index)

                    } else {
                        result.append(ch) // just append a mask character
                    }
                }
                return result
        }

    }
    
    
}

struct PhoneNumberView: View {
    @Binding var phoneNubmer: String
    
    var body: some View {
        HStack {
            Text("+7")
                .foregroundColor(Color.SPBlue)
            PhoneTextFieldView(text: self.$phoneNubmer, placeholder: "(xxx) xxx - xx - xx")
                .foregroundColor(Color.SPBlue)
        }
    }
}

struct RegestationView: View, Header {
    @State var isConfirmView = false
    var header: some View {
        Text("Регистрация")
            .padding()
            .font(.custom("Comfortaa-VariableFont_wght", size: 40))
            .foregroundColor(.SPBlue)
    }
    
    @EnvironmentObject var authObserved: AuthObserved
    
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
                
                TextField("Имя Фамилия", text: $authObserved.userData)
                    .foregroundColor(Color.SPBlue)
                    .padding()
                    .clipShape(Rectangle())
                    .border(Color.SPBlue, width: 3)
                    .keyboardType(.phonePad)
                
                Button(
                    action: {
                        if authObserved.registr() {
                            isConfirmView.toggle()
                        }
                    },
                    label: {
                        Text("Дальше")
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
                    destination: ConfirmView(header: self, btnText: "Регистрация")
                        .environmentObject(authObserved),
                    isActive: $isConfirmView
                )
                    
            }
            .padding()
            Spacer()
        }
    }
}

struct RegestationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RegestationView()
                .navigationBarTitle("Регистрация")
                .navigationBarHidden(true)
                .environmentObject(AuthObserved())
        }
    }
}

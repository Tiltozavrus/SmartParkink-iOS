//
//  ProfileView.swift
//  SmartParking
//
//  Created by Даня Демин on 29.11.2021.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userObserved: UserObserved
    
    var body: some View {
        VStack {
            Image(systemName: "person.crop.circle")
                .resizable()
                .frame(width: 101, height: 101)
            VStack(spacing: 10) {
                HStack {
                    Text(userObserved.user?.name ?? "Имя Фамилия")
                        .font(.custom("", size: 18))
                        .foregroundColor(.gray)
                }
                Text(userObserved.user?.phoneNumber ?? "+7 (999) 999 99 99")
                    .font(.custom("", size: 18))
                    .foregroundColor(.gray)
            }
            Spacer()
        }.padding()
    }
}

struct PhoneNumberTextView: View {
    var phoneNumber: String
    var body: some View {
        Text(textToPhoneNumber(number: phoneNumber))
            .font(.custom("", size: 18))
            .foregroundColor(.gray)
    }
    
    func textToPhoneNumber(number: String) -> String {
        var mask = "+7 (9xx) xxx - xx - xx"
        
        for num in number {
            if let index = mask.firstIndex(of: "x") {
                mask.remove(at: index)
                mask.insert(num, at: index)
            }
        }
        
        return mask
    }
}

struct ProfileView_Previews: PreviewProvider {
    @ObservedObject static var user = UserObserved()
    static var previews: some View {
        ProfileView().environmentObject(user).onAppear{
            user.getUser(id: 12)
        }
    }
}

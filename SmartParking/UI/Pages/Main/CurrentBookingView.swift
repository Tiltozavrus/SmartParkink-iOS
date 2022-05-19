//
//  CurrentBookingView.swift
//  SmartParking
//
//  Created by Даня Демин on 30.11.2021.
//

import SwiftUI

struct CurrentBookingView: View {
    @EnvironmentObject var bookingObserver: ParkBookingObservable
    @EnvironmentObject var userObserver: UserObserved
    @State var cancelBtnClicked: Bool = false
    
    
    var body: some View {
        VStack {
            if let park = bookingObserver.parkBooking {
                HStack {
                    VStack(spacing: 1) {
                        Image("location-big")
                        
                        Circle()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.SPDarkBlue)
                    }
                    VStack(spacing: 1) {
                        Text("Забронировано место")
                            .foregroundColor(.gray)
                            .font(.custom("", size: 18))
                        Text(park.location.addres)
                            .foregroundColor(.gray)
                            .font(.custom("", size: 18))
                        Text(park.place.name)
                            .foregroundColor(.gray)
                            .font(.custom("", size: 18))
                    }
                }
                
                if cancelBtnClicked {
                    HStack(spacing: 10) {
                        Button(
                            action: {
                                if let userId = userObserver.user?._id {
                                    bookingObserver.cancelBook(userID: userId.intValue, parkID: park.location.id)
                                    cancelBtnClicked = false
                                }
                            },
                            label: {
                                Text("Да")
                                    .padding()
                                    .frame(minWidth: 30, idealWidth: 30, maxWidth: .infinity)
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
                                cancelBtnClicked = false
                            },
                            label: {
                                Text("Нет")
                                    .padding()
                                    .frame(minWidth: 30, idealWidth: 30, maxWidth: .infinity)
                                    .foregroundColor(.black)
                                    .font(Font.headline.weight(.bold))
                                    .background(Color.gray)
                                    .cornerRadius(6)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 6)
                                            .stroke(Color.gray, lineWidth: 4)
                                    )
                            }
                        )
                    }.padding()
                } else {
                    Button(
                        action: {
                            cancelBtnClicked.toggle()
                        },
                        label: {
                            Text("Отменить бронирование")
                                .padding()
                                .frame(minWidth: 50, idealWidth: 80, maxWidth: .infinity)
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
                    .padding()
                }
                
                Spacer()
                
            } else {
                Spacer()
                Text("На данный момент нет действительных бронирований")
                    .font(.custom("", size: 18))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
                Spacer()
            }
        }.onDisappear {
            cancelBtnClicked = false
        }
    }
}

struct CurrentBookingView_Previews: PreviewProvider {
    @ObservedObject static var park = ParkBookingObservable()
    static var previews: some View {
        CurrentBookingView()
            .environmentObject(park)
            .environmentObject(UserObserved())
            .onAppear {
                park.bookPlace(userID: 12, parkId: 12)
            }
    }
}

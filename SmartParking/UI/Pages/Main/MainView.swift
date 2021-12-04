//
//  MainView.swift
//  SmartParking
//
//  Created by Даня Демин on 28.11.2021.
//

import SwiftUI

private protocol TabImage {
    func imageName() -> String
}

private enum Tab: String, CaseIterable, Equatable {
    
    case profile = "profile"
    
    case map = "map"
    
    case home = "home"
    
    case settings = "settings"
    
    case qrCode = "qrCode"
}

extension Tab: TabImage {
    func imageName() -> String {
        switch self {
        case .settings:
            return "settings"
        case .map:
            return "location"
        case .qrCode:
            return "qr_code"
        case .profile:
            return "profile"
        case .home:
            return "home"
        }
    }
}

extension Color {
    
}

struct MainView: View {
    @EnvironmentObject var authObserved: AuthObserved
    @ObservedObject var userObserved: UserObserved = UserObserved()
    @ObservedObject var parkingBook: ParkBookingObservable = ParkBookingObservable()
    @ObservedObject var parkLocations: ParkingLocationsObserved = ParkingLocationsObserved()
    
    @State private var selectedTab: Tab = .home
    
    init() {
        let navBarApperance = UINavigationBarAppearance()
        navBarApperance.backgroundColor = UIColor.systemBackground
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    switch selectedTab {
                    case .home:
                        HomeView()
                            .environmentObject(userObserved)
                            .environmentObject(parkingBook)
                            .environmentObject(parkLocations)
                    case .profile:
                        ProfileView()
                            .environmentObject(userObserved)
                    case .map:
                        CurrentBookingView()
                            .environmentObject(parkingBook)
                            .environmentObject(userObserved)
                    case .settings:
                        Text("settings")
                    case .qrCode:
                        BookingView()
                            .environmentObject(parkingBook)
                    }
                }
                
                Spacer()
                HStack {
                    ForEach(Tab.allCases, id: \.self) {tab in
                        Spacer()
                            Image(tab.imageName())
                                .frame(width: 25.0, height: 25.0)
                                .imageScale(.large)
                                .foregroundColor(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 6)
                                        .fill(selectedTab == tab ? Color.SPLiteBlue : Color.SPBlue)
                                        .frame(width: 50, height: 30)
                                )
                                .onTapGesture {
                                    selectedTab = tab
                                }
                        Spacer()
                    }
                }
                    .padding()
                    .background(Rectangle().foregroundColor(.SPBlue))
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    HStack {
                        Text("SmartPark")
                            .font(.custom("Comfortaa-VariableFont_wght", size: 36))
                            .foregroundColor(.SPBlue)
                        LoadingLine(withAnimation: false).frame(width: 100, height: 100, alignment: .center)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }.onAppear {
            userObserved.getUser(id: authObserved.userID)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    @ObservedObject static var auth = AuthObserved()
    static var previews: some View {
        MainView().environmentObject(auth).onAppear {
            auth.verifyCode(code: "0000")
        }
    }
}

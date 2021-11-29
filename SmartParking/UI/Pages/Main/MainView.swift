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
    @State private var selectedTab: Tab = .home
    
    init() {
        let navBarApperance = UINavigationBarAppearance()
        navBarApperance.backgroundColor = UIColor.systemBackground
    }
    
    var body: some View {
        NavigationView {
            VStack {
                    switch selectedTab {
                    case .home:
                        HomeView()
                    case .profile:
                        Text("Profile")
                    case .map:
                        Text("map")
                    case .settings:
                        Text("settings")
                    case .qrCode:
                        Text("qr code")
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
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

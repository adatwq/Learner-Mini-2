//
//  ContentView.swift
//  AutoAuthInCloudKit
//
//  Created by Khawlah Khalid on 29/10/2023.
//

import SwiftUI

struct AppTabView: View {
    var body: some View {
        TabView{
            LearnersView()
                .tabItem { Label("Learners", systemImage: "person.3.fill") }
            
            ProfileView()
                .tabItem { Label("Me", systemImage: "person") }
        }

    }
}

#Preview {
    AppTabView()
}

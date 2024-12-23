//
//  ContentView.swift
//  BaziAnalysis
//
//  Created by catcher on 2024/12/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var birthViewModel = BirthViewModel()
    
    var body: some View {
        TabView {
            NavigationStack {
                BirthInputView()
                    .environmentObject(birthViewModel)
            }
            .tabItem {
                Label("八字分析", systemImage: "chart.bar")
            }
            
            NavigationStack {
                ProfileView()
                    .environmentObject(birthViewModel)
            }
            .tabItem {
                Label("个人中心", systemImage: "person")
            }
        }
    }
}

#Preview {
    ContentView()
}
//
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
                Label("分析", systemImage: "chart.bar")
            }
            
            NavigationStack {
                ProfileView()
                    .environmentObject(birthViewModel)
            }
            .tabItem {
                Label("我的", systemImage: "person")
            }
        }
        .tint(Color(hex: "5B7FFF"))
        .background(AppTheme.gradient)
    }
}

#Preview {
    ContentView()
}
//
//
//  ContentView.swift
//  BaziAnalysis
//
//  Created by catcher on 2024/12/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = BirthViewModel()
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        TabView {
            NavigationStack {
                BirthInputView()
                    .environmentObject(viewModel)
                    .navigationTitle("八字分析")
            }
            .tabItem {
                Label("分析", systemImage: "chart.bar")
            }
            
            NavigationStack {
                HistoryView()
                    .navigationTitle("历史记录")
            }
            .tabItem {
                Label("历史", systemImage: "clock")
            }
            
            NavigationStack {
                ProfileView()
                    .navigationTitle("我的")
            }
            .tabItem {
                Label("我的", systemImage: "person.circle")
            }
        }
        .tint(.blue)
    }
}

#Preview {
    ContentView()
}
//
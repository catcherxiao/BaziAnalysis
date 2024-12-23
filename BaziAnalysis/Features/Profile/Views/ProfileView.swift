import SwiftUI

struct ProfileView: View {
    @EnvironmentObject private var appState: AppState
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        List {
            Section {
                HStack(spacing: 15) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.blue)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("游客")
                            .font(.headline)
                        Text("点击登录")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.vertical, 8)
            }
            
            Section {
                Toggle("深色模式", isOn: Binding(
                    get: { colorScheme == .dark },
                    set: { _ in appState.toggleTheme() }
                ))
                
                NavigationLink {
                    HistoryView()
                } label: {
                    Label("历史记录", systemImage: "clock")
                }
                
                NavigationLink {
                    SettingsView()
                } label: {
                    Label("设置", systemImage: "gear")
                }
            }
            
            Section {
                NavigationLink {
                    AboutView()
                } label: {
                    Label("关于", systemImage: "info.circle")
                }
                
                NavigationLink {
                    FeedbackView()
                } label: {
                    Label("反馈", systemImage: "envelope")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ProfileView()
            .environmentObject(AppState())
    }
} 